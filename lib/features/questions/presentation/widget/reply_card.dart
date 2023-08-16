import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../domain/entity/reply.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import 'question_card.dart';

class ReplyCard extends StatelessWidget {
  Reply reply;
  final Map<String , VoteBloc> voteBlocMap;
  void Function()? onPressed;
  int descriptionLength;
  ReplyCard({
    required this.voteBlocMap,
    super.key,
    required this.reply,
    this.onPressed,
    this.descriptionLength = 3,
  });

  @override
  Widget build(BuildContext context) {

    return QuestionCard(reply,
        showImage: false,
        isAnswer: true,
        onPressed: onPressed,
        descriptionLength: descriptionLength,
        showActions: ActionsSection(
          voteBlocMap: voteBlocMap,
          upvoteCount: reply.vote.upvote,
          userReaction: reply.userReaction,
          downvoteCount: reply.vote.downvote,
          table: 'reply',
          id: reply.replyId,
        ));
  }
}
