import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/injections/injection_container.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/vote_bloc_maps.dart';
import '../../domain/entity/vote_type.dart';
import '../bloc/add_bookmark_bloc/add_bookmark_bloc.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import 'icon_text_actions.dart';
import 'like_dislike_action.dart';

class ActionsSection extends StatefulWidget {
  final int upvoteCount;
  final int downvoteCount;
  final int? numberOfAnswers;
  final int? numberOfDiscussions;
  final int? numberOfReplies;
  final dynamic id;
  final int? userReaction;
  final bool userBookmarked;
  final String table;
  final Map<String, VoteBloc> voteBlocMap;
  void Function()? onAnswerPressed;
  void Function()? onDiscussionPressed;
  void Function()? onBookmarkPressed;
  void Function()? onReplyPressed;

  ActionsSection({
    super.key,
    required this.upvoteCount,
    required this.downvoteCount,
    this.numberOfAnswers,
    this.numberOfDiscussions,
    this.numberOfReplies,
    required this.id,
    this.userBookmarked = false,
    required this.table,
    this.userReaction,
    required this.voteBlocMap,
    this.onAnswerPressed,
    this.onDiscussionPressed,
    this.onReplyPressed,
    this.onBookmarkPressed,
  });

  @override
  State<ActionsSection> createState() => _ActionsSectionState();
}

class _ActionsSectionState extends State<ActionsSection> {
  late bool curBookmarkState;

  @override
  initState() {
    curBookmarkState = widget.userBookmarked;
    super.initState();
  }

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
              create: (context) => getBloc(widget.id),
              child: LikeDislikeButton(
                  initialDislikeCount: widget.downvoteCount,
                  initialLikeCount: widget.upvoteCount,
                  currentVote: widget.userReaction == 1
                      ? VoteType.Like
                      : widget.userReaction == 2
                          ? VoteType.Dislike
                          : VoteType.None,
                  table: widget.table,
                  id: widget.id.toString()),
            ),
          ),
          widget.numberOfAnswers != null
              ? iconTextAction(
                  textTheme,
                  SvgPicture.asset(
                    answerIconImage,
                    height: 2.5.h,
                    width: 23,
                    color: greyIconColor,
                  ),
                  widget.numberOfAnswers.toString(),
                  widget.onAnswerPressed,
                )
              : const SizedBox(),
          widget.numberOfDiscussions != null
              ? iconTextAction(
                  textTheme,
                  const Icon(
                    Icons.question_answer_outlined,
                    color: greyIconColor,
                  ),
                  widget.numberOfDiscussions.toString(),
                  widget.onDiscussionPressed,
                )
              : const SizedBox(),
          widget.numberOfReplies != null
              ? iconTextAction(
                  textTheme,
                  const Icon(
                    Icons.reply_rounded,
                    color: greyIconColor,
                  ),
                  widget.numberOfReplies.toString(),
                  widget.onReplyPressed,
                )
              : const SizedBox(),
          widget.table == 'question'
              ? BlocProvider(
                  create: (context) => getBookmarkBloc(widget.id),
                  child: BlocConsumer<AddBookmarkBloc, AddBookmarkState>(
                    listener: (context, state) {
                      if (state is AddBookmarkFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Failed to bookmark. Please check your internet connection and try again!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            elevation: 5,
                            showCloseIcon: true,
                            behavior: SnackBarBehavior.floating,
                            dismissDirection: DismissDirection.horizontal,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return iconTextAction(
                        textTheme,
                        Icon(
                          state.curVoteType
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color:
                              state.curVoteType ? primaryColor : greyIconColor,
                        ),
                        '',
                        () {
                          BlocProvider.of<AddBookmarkBloc>(context)
                              .add(BookmarkPressed(widget.id.toString()));
                        },
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  AddBookmarkBloc getBookmarkBloc(id) {
    if (addBookMarkBlocMap.containsKey(id)) {
      return addBookMarkBlocMap[id]!;
    } else {
      AddBookmarkBloc addBookmarkBloc =
          AddBookmarkBloc(getIt(), widget.userBookmarked);
      addBookMarkBlocMap[id] = addBookmarkBloc;

      return addBookmarkBloc;
    }
  }

  VoteBloc getBloc(id) {
    {
      if (widget.voteBlocMap.containsKey(id.toString())) {
        return widget.voteBlocMap[id.toString()]!;
      } else {
        VoteBloc voteBloc = VoteBloc(
          getIt(),
          initUpvoteCount: widget.upvoteCount,
          initDownvoteCount: widget.downvoteCount,
          initCurrentVote: widget.userReaction == 1
              ? VoteType.Like
              : widget.userReaction == 2
                  ? VoteType.Dislike
                  : VoteType.None,
          initPreviousVote: widget.userReaction == 1
              ? VoteType.Like
              : widget.userReaction == 2
                  ? VoteType.Dislike
                  : VoteType.None,
        );
        widget.voteBlocMap[id.toString()] = voteBloc;
        return voteBloc;
      }
    }
  }
}
