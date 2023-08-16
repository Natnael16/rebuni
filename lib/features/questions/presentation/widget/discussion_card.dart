import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../domain/entity/discussion.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import 'question_card.dart';

class DiscussionCard extends StatelessWidget {
  Discussion discussion;
  int descriptionLength;
  Map<String, VoteBloc> voteBlocMap;
  void Function()? onPressed;
  DiscussionCard(
      {super.key,
      required this.discussion,
      required this.voteBlocMap,
      this.descriptionLength = 3,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return QuestionCard(discussion,
        onPressed: onPressed,
        descriptionLength: descriptionLength,
        showImage: false,
        isAnswer: true,
        showActions: ActionsSection(
            onReplyPressed: onPressed,
            voteBlocMap: voteBlocMap,
            userReaction: discussion.userReaction,
            upvoteCount: discussion.vote.upvote,
            downvoteCount: discussion.vote.downvote,
            numberOfReplies: discussion.numberOfReplies,
            table: 'discussion',
            id: discussion.discussionId));
  }
}
