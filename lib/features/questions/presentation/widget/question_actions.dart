import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/injections/injection_container.dart';
import '../../../../core/utils/bloc_providers.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../domain/entity/vote_type.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import 'icon_text_actions.dart';
import 'like_dislike_action.dart';

class ActionsSection extends StatelessWidget {
  final int upvoteCount;
  final int downvoteCount;
  final int? numberOfAnswers;
  final int? numberOfDiscussions;
  final int? numberOfReplies;
  final dynamic id;
  final int? userReaction;
  final String table;
  final Map<String, VoteBloc> voteBlocMap;
  void Function()? onAnswerPressed;
  void Function()? onDiscussionPressed;
  void Function()? onBookmarkPressed;
  void Function()? onReplyPressed;

  ActionsSection(
      {super.key,
      required this.upvoteCount,
      required this.downvoteCount,
      this.numberOfAnswers,
      this.numberOfDiscussions,
      this.numberOfReplies,
      required this.id,
      required this.table,
      this.userReaction,
      required this.voteBlocMap,
      this.onAnswerPressed,
      this.onDiscussionPressed,
      this.onReplyPressed,
      this.onBookmarkPressed,
      });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: BlocProvider(
              create: (context) => getBloc(id),
              child: LikeDislikeButton(
                  initialDislikeCount: downvoteCount,
                  initialLikeCount: upvoteCount,
                  currentVote: userReaction == 1
                      ? VoteType.Like
                      : userReaction == 2
                          ? VoteType.Dislike
                          : VoteType.None,
                  table: table,
                  id: id.toString()),
            ),
          ),
          numberOfAnswers != null
              ? iconTextAction(
                  textTheme,
                  SvgPicture.asset(
                    answerIconImage,
                    height: 2.5.h,
                    width: 23,
                    color: greyIconColor,
                  ),
                  numberOfAnswers.toString(),
                  onAnswerPressed,
                )
              : const SizedBox(),
          numberOfDiscussions != null
              ? iconTextAction(
                  textTheme,
                  const Icon(
                    Icons.question_answer_outlined,
                    color: greyIconColor,
                  ),
                  numberOfDiscussions.toString(),
                  onDiscussionPressed,
                )
              : const SizedBox(),
          numberOfReplies != null
              ? iconTextAction(
                  textTheme,
                  const Icon(
                    Icons.reply_rounded,
                    color: greyIconColor,
                  ),
                  numberOfReplies.toString(),
                  onReplyPressed
,
                )
              : const SizedBox(),
          iconTextAction(
            textTheme,
            const Icon(
              Icons.bookmark_border,
              color: greyIconColor,
            ),
            '',
            onBookmarkPressed,
          ),
        ],
      ),
    );
  }

  VoteBloc getBloc(id) {
    {
      if (voteBlocMap.containsKey(id.toString())) {
        return voteBlocMap[id.toString()]!;
      } else {
        VoteBloc voteBloc = VoteBloc(
          getIt(),
          initUpvoteCount: upvoteCount,
          initDownvoteCount: downvoteCount,
          initCurrentVote: userReaction == 1
              ? VoteType.Like
              : userReaction == 2
                  ? VoteType.Dislike
                  : VoteType.None,
          initPreviousVote: userReaction == 1
              ? VoteType.Like
              : userReaction == 2
                  ? VoteType.Dislike
                  : VoteType.None,
        );
        voteBlocMap[id.toString()] = voteBloc;
        return voteBloc;
      }
    }
  }
}
