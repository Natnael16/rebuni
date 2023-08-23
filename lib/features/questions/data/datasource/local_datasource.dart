import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/question_model.dart';

abstract class QuestionsLocalDataSource {
  Future<List<QuestionModel>> getBookmarkedQuestionsFromCache();
  Future<void> cacheBookmarkedQuestions(List<QuestionModel> questions);
}



class QuestionsLocalDataSourceImpl implements QuestionsLocalDataSource {
  static const String bookmarkedQuestionsKey = 'bookmarked_questions';

  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  @override
  Future<List<QuestionModel>> getBookmarkedQuestionsFromCache() async {
    final prefs = await _getInstance();

    final cachedQuestions = prefs.getStringList(bookmarkedQuestionsKey);
    if (cachedQuestions == null || cachedQuestions.isEmpty) {
      return [];
    }

    return cachedQuestions.map((json) => QuestionModel.fromJson(jsonDecode(json))).toList();
  }

  @override
  Future<void> cacheBookmarkedQuestions(List<QuestionModel> questions) async {
    final prefs = await _getInstance();

    final cachedQuestions =
        questions.map((question) => jsonEncode(question.toJson())).toList();
    await prefs.setStringList(bookmarkedQuestionsKey, cachedQuestions);
  }
}