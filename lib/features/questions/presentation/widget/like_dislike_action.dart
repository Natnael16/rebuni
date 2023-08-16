import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/entity/vote_type.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import 'icon_text_actions.dart';

class LikeDislikeButton extends StatelessWidget {
  final int initialLikeCount;
  final int initialDislikeCount;
  final VoteType currentVote;
  final String table;
  final String id;

  const LikeDislikeButton({
    Key? key,
    required this.initialLikeCount,
    required this.initialDislikeCount,
    this.currentVote = VoteType.None,
    required this.table,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoteBloc, VoteState>(
      listener: (context, state) {
        if (state.voteState == EVoteState.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to react. Please check your internet connection and try again!",
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
        return Row(
          children: [

            iconTextAction(
              Theme.of(context).textTheme,

            Icon(
              state.currentVote == VoteType.Like
                  ? Icons.thumb_up
                  : Icons.thumb_up_outlined,
              color: state.currentVote == VoteType.Like
                  ? primaryColor
                  : greyIconColor,
            ),
              state.upvoteCount.toString(),
              () => onLikeDislikePressed(context, true),
            ),
            Container(height: 30, width: 2, color: containerBackgroundColor),

            iconTextAction(
              Theme.of(context).textTheme,
            Icon(
              (state.currentVote) == VoteType.Dislike
                  ? Icons.thumb_down
                  : Icons.thumb_down_outlined,
              color: (state.currentVote) == VoteType.Dislike
                  ? primaryColor
                  : greyIconColor,
            ),
              state.downvoteCount.toString(),
              () => onLikeDislikePressed(context, false),
            ),
          ],
        );
      },
    );
  }

  Widget likeWrapper(Widget icon) {
    return Container(
      margin: EdgeInsets.only(left: 1.w, right: 1.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: icon,
    );
  }

  void onLikeDislikePressed(BuildContext context, bool isLike) {
    BlocProvider.of<VoteBloc>(context).add(
      LikeDislike(
        table: table,
        id: id,
        voteType: isLike,
      ),
    );
  }
}
