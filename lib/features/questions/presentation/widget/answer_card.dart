import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../domain/entity/answer.dart';
import 'question_card.dart';

class AnswerCard extends StatelessWidget {
  Answer answer;
  AnswerCard({super.key,required this.answer});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return QuestionCard(answer, isAnswer: true,showActions:  actionsSection(textTheme,upvoteCount: answer.vote.upvote,downvoteCount: answer.vote.downvote, numberOfReplies: answer.numberOfReplies));
  }
}
