import 'dart:io';

import 'package:supabase/supabase.dart';

import '../../../../core/utils/cloudinary.dart';
import '../../domain/entity/user_profile.dart';
import '../models/answer_model.dart';
import '../models/discusion_model.dart';
import '../models/question_model.dart';
import '../models/reply_model.dart';
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

  Future<List<AnswerModel>> getAnswers(String questionId);

  Future<List<DiscussionModel>> getDiscussions(String questionId);

  Future<List<ReplyModel>> getReplies(String id, bool isAnswer);
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

  @override
  Future<List<AnswerModel>> getAnswers(String questionId) async {
    final response = await supabaseClient
        .from('answers')
        .select()
        .eq('question_id', questionId);

    final answerList = response as List<dynamic>;
    if (answerList.isEmpty) {
      throw Exception("Answers not found");
    }

    List<Future<AnswerModel>> answers = answerList.map((answer) async {
      answer['vote'] = answer['vote_id'] != null
          ? await getVoteData(answer['vote_id'])
          : {
              'voteId': '0',
              'createdAt': DateTime.now().toIso8601String(),
              'upvote': 0,
              'downvote': 0,
            };
      answer['user_profile'] = await getUserProfile(answer['user_id']);
      return AnswerModel.fromJson(answer);
    }).toList();

    return await Future.wait(answers);
  }

  @override
  Future<List<DiscussionModel>> getDiscussions(String questionId) async {
    final response = await supabaseClient
        .from('discussions')
        .select()
        .eq('question_id', questionId);

    final discussionList = response as List<dynamic>;
    if (discussionList.isEmpty) {
      throw Exception("Discussions not found");
    }

    List<Future<DiscussionModel>> discussions =
        discussionList.map((discussion) async {
      discussion['vote'] = discussion['vote_id'] != null
          ? await getVoteData(discussion['vote_id'])
          : {
              'voteId': '0',
              'createdAt': DateTime.now().toIso8601String(),
              'upvote': 0,
              'downvote': 0,
            };
      discussion['user_profile'] = await getUserProfile(discussion['user_id']);
      return DiscussionModel.fromJson(discussion);
    }).toList();

    return await Future.wait(discussions);
  }

  @override
  Future<List<ReplyModel>> getReplies(String id, bool isAnswer) async {
    final response = await supabaseClient.from('replys').select().eq(
        isAnswer ? 'answer_id' : 'discussion_id',
        isAnswer ? int.parse(id) : id);

    final replyList = response as List<dynamic>;
    if (replyList.isEmpty) {
      throw Exception("Replies not found");
    }

    List<Future<ReplyModel>> replies = replyList.map((reply) async {
      reply['vote'] = reply['vote_id'] != null
          ? await getVoteData(reply['vote_id'])
          : {
              'voteId': '0',
              'createdAt': DateTime.now().toIso8601String(),
              'upvote': 0,
              'downvote': 0,
            };
      reply['user_profile'] = await getUserProfile(reply['user_id']);
      return ReplyModel.fromJson(reply);
    }).toList();

    return await Future.wait(replies);
  }
}
