import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/question_actions.dart';

import '../../domain/entity/discussion.dart';
import 'question_card.dart';

class DiscussionCard extends StatelessWidget {
  Discussion discussion;
  DiscussionCard({super.key, required this.discussion});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return QuestionCard(discussion,
    showImage: false,
        isAnswer: true,
        showActions: actionsSection(textTheme,
            upvoteCount: discussion.vote.upvote,
            downvoteCount: discussion.vote.downvote,
            numberOfReplies: discussion.numberOfReplies));
  }
}
