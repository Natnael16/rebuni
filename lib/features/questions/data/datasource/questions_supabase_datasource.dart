import 'dart:io';

import 'package:supabase/supabase.dart';

import '../../../../core/utils/cloudinary.dart';
import '../../domain/entity/user_profile.dart';
import '../models/question_model.dart';
import '../models/vote_model.dart';

abstract class SupabaseQuestionsDataSource {
  Future<bool> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  });
  Future<List<QuestionModel>> getQuestions(int curIndex);
}

class SupabaseQuestionsDataSourceImpl implements SupabaseQuestionsDataSource {
  static const int limit = 20;
  final SupabaseClient supabaseClient;
  SupabaseQuestionsDataSourceImpl(this.supabaseClient);

  @override
  Future<bool> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  }) async {
    try {
      // Upload the file to Cloudinary
      String? imageUrl = image != null
          ? await cloudinaryUpload(
              image, supabaseClient.auth.currentUser!.id, 'question-images')
          : null;

      // Prepare the data to be inserted into the questions table
      final data = {
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'categories': categories,
        'is_anonymous': isAnonymous,
        'user_id': supabaseClient.auth.currentUser!.id,
      };
      // Perform the insert operation in the questions table
      final response = await supabaseClient.from('questions').insert(data);

      // Check if the insert operation was successful and return the appropriate result
      return response == null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<QuestionModel>> getQuestions(int curIndex) async {
    final response = await supabaseClient
        .from('questions')
        .select()
        .range(curIndex, curIndex + limit - 1);

    final questionsList = response;
    final List<QuestionModel> questions = [];

    for (final questionData in questionsList) {
      final String questionId = questionData['question_id'];
      final DateTime createdAt =
          DateTime.parse(questionData['created_at'] as String);
      final DateTime updatedAt =
          DateTime.parse(questionData['updated_at'] as String);
      final String userId = questionData['user_id'] as String;
      final String title = questionData['title'] as String;
      final String description = questionData['description'] as String;
      final String imageUrl = questionData['image_url'] ?? '';
      final bool isClosed = questionData['is_closed'] as bool;
      final bool isAnonymous = questionData['is_anonymous'] as bool;
      final int numberOfViews = questionData['number_of_views'] as int;
      final int numberOfAnswers = questionData['number_of_answers'] as int;
      final int numberOfDiscussions =
          questionData['number_of_discussions'] as int;
      final List<String> categories =
          (questionData['categories'] as List<dynamic>)
              .map((elem) => elem as String)
              .toList();
      final String? voteId = questionData['vote_id'];

      // Create a dummy vote if vote_id is null
      VoteModel vote;
      if (voteId == null) {
        vote = VoteModel(
          voteId: '',
          upvote: 0,
          downvote: 0,
          createdAt: DateTime.now(),
        );
      } else {
        // Get the actual vote data from your Supabase table or API
        final voteData = await getVoteData(voteId);
        vote = VoteModel.fromJson(voteData);
      }

      UserProfile userProfile =
          await getUserProfile(userId); // Fetch user profile based on userId

      final question = QuestionModel(
          title: title,
          description: description,
          questionId: questionId.toString(),
          createdAt: createdAt,
          updatedAt: updatedAt,
          imageUrl: imageUrl,
          isClosed: isClosed,
          numberOfViews: numberOfViews,
          vote: vote,
          categories: categories,
          numberOfAnswers: numberOfAnswers,
          numberOfDiscussions: numberOfDiscussions,
          userProfile: userProfile,
          isAnonymous: isAnonymous);

      questions.add(question);
    }

    return questions;
  }

  Future<Map<String, dynamic>> getVoteData(String voteId) async {
    final response = await supabaseClient
        .from('votes')
        .select()
        .eq('vote_id', voteId)
        .single();

    return response as Map<String, dynamic>;
  }

  Future<UserProfile> getUserProfile(String userId) async {
    final response = await supabaseClient
        .from('user_profile')
        .select()
        .eq('user_id', userId)
        .limit(1);

    final userProfileList = response;

    if (userProfileList.isEmpty) {
      throw Exception("User profile not found"); // User profile not found
    }
    final userProfileData = userProfileList[0];

    UserProfile userProfile = UserProfile.fromJson(userProfileData);
    return userProfile;
  }
}
