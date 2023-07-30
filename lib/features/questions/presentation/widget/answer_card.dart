import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../domain/entity/answer.dart';
import 'question_card.dart';

class AnswerCard extends StatelessWidget {
  Answer answer;
  void Function()? onPressed;
  int descriptionLength;
  bool showImage;
  final bool isFormattedDescription;
  AnswerCard(
      {super.key,
      required this.answer,
      this.onPressed,
      this.descriptionLength = 3,
      this.isFormattedDescription = true,
      this.showImage = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return QuestionCard(answer,
        
        showImage: showImage,
        isAnswer: true,
        isFormattedBody: isFormattedDescription,
        onPressed: onPressed,
        descriptionLength: descriptionLength,
        showActions: actionsSection(textTheme,
            upvoteCount: answer.vote.upvote,
            downvoteCount: answer.vote.downvote,
            numberOfReplies: answer.numberOfReplies));
  }
}
