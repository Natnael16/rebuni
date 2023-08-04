import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../domain/entity/reply.dart';
import 'question_card.dart';

class ReplyCard extends StatelessWidget {
  Reply reply;
  void Function()? onPressed;
  int descriptionLength;
  ReplyCard(
      {super.key,
      required this.reply,
      this.onPressed,
      this.descriptionLength = 3,
     });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return QuestionCard(reply,
        showImage: false,
        isAnswer: true,
        onPressed: onPressed,
        descriptionLength: descriptionLength,
        showActions: actionsSection(textTheme,
            upvoteCount: reply.vote.upvote,
            downvoteCount: reply.vote.downvote,
             ));
  }
}
