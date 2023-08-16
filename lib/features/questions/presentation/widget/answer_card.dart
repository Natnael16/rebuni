import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../domain/entity/answer.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import 'question_card.dart';

class AnswerCard extends StatelessWidget {
  Answer answer;
  void Function()? onPressed;
  int descriptionLength;
  bool showImage;
  Map<String, VoteBloc> voteBlocMap;
  final bool isFormattedDescription;
  AnswerCard(
      {super.key,
      required this.answer,
      this.onPressed,
      this.descriptionLength = 3,
      this.isFormattedDescription = true,
      required this.voteBlocMap,
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
        showActions: ActionsSection(
          onReplyPressed: onPressed,
          userReaction: answer.userReaction,
          voteBlocMap: voteBlocMap,
          upvoteCount: answer.vote.upvote,
          downvoteCount: answer.vote.downvote,
          numberOfReplies: answer.numberOfReplies,
          table: 'answer',
          id: answer.answerId,
        ));
  }
}
