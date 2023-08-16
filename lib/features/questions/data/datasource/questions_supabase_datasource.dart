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

  Future<bool> addReply(String id, String body, bool isQuestion);

  Future<bool> postAnswer({
    required String questionId,
    required String description,
    File? image,
  });

  Future<bool> addVote(
      {required String id, required bool voteType, required String table});
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
        .range(curIndex, curIndex + limit - 1)
        .order('created_at', ascending: false);

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
      // final String? voteId = questionData['vote_id'];
      final int numberOfUpvotes = questionData['upvotes'] as int;
      final int numberOfDownvotes = questionData['downvotes'] as int;

      VoteModel vote = VoteModel(
        upvote: numberOfUpvotes,
        downvote: numberOfDownvotes,
      );

      int userReaction = await getUserReaction("question", questionId);

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
        isAnonymous: isAnonymous,
        userReaction: userReaction,
      );

      questions.add(question);
    }

    return questions;
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
      answer['vote'] = {
        'upvote': answer['upvotes'],
        'downvote': answer['downvotes'],
      };
      answer['user_profile'] = await getUserProfile(answer['user_id']);
      int userReaction = await getUserReaction("answer", answer['answer_id']);
      answer['user_reaction'] = userReaction;
      return AnswerModel.fromJson(answer);
    }).toList();

    return await Future.wait(answers);
  }

  @override
  Future<List<DiscussionModel>> getDiscussions(String questionId) async {
    final response = await supabaseClient
        .from('discussions')
        .select()
        .eq('question_id', questionId)
        .order('created_at', ascending: false);

    final discussionList = response as List<dynamic>;
    if (discussionList.isEmpty) {
      throw Exception("Discussions not found");
    }

    List<Future<DiscussionModel>> discussions =
        discussionList.map((discussion) async {
      discussion['vote'] = {
        'upvote': discussion['upvotes'],
        'downvote': discussion['downvotes'],
      };
      discussion['user_profile'] = await getUserProfile(discussion['user_id']);
      int userReaction =
          await getUserReaction("discussion", discussion['discussion_id']);
      discussion['user_reaction'] = userReaction;
      return DiscussionModel.fromJson(discussion);
    }).toList();

    return await Future.wait(discussions);
  }

  @override
  Future<List<ReplyModel>> getReplies(String id, bool isAnswer) async {
    final response = await supabaseClient
        .from('replys')
        .select()
        .eq(isAnswer ? 'answer_id' : 'discussion_id',
            isAnswer ? int.parse(id) : id)
        .order('created_at', ascending: false);

    final replyList = response as List<dynamic>;
    if (replyList.isEmpty) {
      throw Exception("Replies not found");
    }

    List<Future<ReplyModel>> replies = replyList.map((reply) async {
      reply['vote'] = {
        'upvote': reply['upvotes'],
        'downvote': reply['downvotes'],
      };
      reply['user_profile'] = await getUserProfile(reply['user_id']);
      int userReaction = await getUserReaction("reply", reply['reply_id']);
      reply['user_reaction'] = userReaction;

      return ReplyModel.fromJson(reply);
    }).toList();

    return await Future.wait(replies);
  }

  @override
  Future<bool> addReply(String id, String body, bool isQuestion) async {
    try {
      int? integerId = int.tryParse(id);
      final data = {
        isQuestion
            ? 'question_id'
            : integerId == null
                ? "discussion_id"
                : 'answer_id': id,
        'body': body,
        'user_id': supabaseClient.auth.currentUser!.id
      };
      // Perform the insert operation in the questions table
      final response = await supabaseClient
          .from(isQuestion ? 'discussions' : 'replys')
          .insert(data);

      // Check if the insert operation was successful and return the appropriate result
      return response == null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> postAnswer(
      {required String questionId,
      required String description,
      File? image}) async {
    try {
      // Upload the file to Cloudinary
      String? imageUrl = image != null
          ? await cloudinaryUpload(
              image, supabaseClient.auth.currentUser!.id, 'answer-images')
          : null;

      // Prepare the data to be inserted into the questions table
      final data = {
        'question_id': questionId,
        'description': description,
        'image_url': imageUrl,
        'user_id': supabaseClient.auth.currentUser!.id,
      };
      // Perform the insert operation in the questions table
      final response = await supabaseClient.from('answers').insert(data);

      // Check if the insert operation was successful and return the appropriate result
      return response == null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> addVote(
      {required String id,
      required bool voteType,
      required String table}) async {
    try {
      var result = await supabaseClient
          .from('user_vote')
          .select()
          .eq('user_id', supabaseClient.auth.currentUser!.id)
          .eq('${table}_id', id) as List<dynamic>;

      if (result.isEmpty) {
        //when no result found insert
        var insertResult = await supabaseClient.from('user_vote').insert({
          "${table}_id": id,
          'user_id': supabaseClient.auth.currentUser!.id,
          'vote_type': voteType,
        });
        if (insertResult != null) return false;
      } else {
        final vote = result[0];
        final updateBody = {
          'user_vote_id': vote['user_vote_id'],
          "${table}_id": id,
          'user_id': supabaseClient.auth.currentUser!.id,
          'vote_type': voteType,
        };
        var updateResult = await supabaseClient
            .from('user_vote')
            .update(updateBody)
            .eq('user_vote_id', vote['user_vote_id']);

        if (updateResult != null) return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> getUserReaction(table, id) async {
    // Your code to retrieve the user's vote based on user_id and other conditions
    var result = await supabaseClient
        .from('user_vote')
        .select('vote_type')
        .eq('user_id', supabaseClient.auth.currentUser!.id)
        .eq('${table}_id', id) as List<dynamic>;

    if (result.isEmpty) {
      return 0;
    }
    var vote = result[0];
    if (vote['vote_type'] == null) {
      return 0; // User hasn't voted
    } else if (vote['vote_type'] == true) {
      return 1; // User has upvoted
    } else {
      return 2; // User has downvoted or voted false
    }
  }
}
