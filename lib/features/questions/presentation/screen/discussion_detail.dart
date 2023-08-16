import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/shared_widgets/shimmer.dart';
import '../../domain/entity/discussion.dart';
import '../bloc/add_discussion_bloc/add_discussion_bloc.dart';
import '../bloc/get_replies_bloc/get_replies_bloc.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import '../widget/bottom_text_field.dart';
import '../widget/discussion_card.dart';
import '../widget/reply_card.dart';

class DiscussionDetail extends StatefulWidget {
  Discussion discussion;
  Map<String, VoteBloc> voteBlocDiscussionMap;

  DiscussionDetail({super.key, required this.discussion, required this.voteBlocDiscussionMap});

  @override
  State<DiscussionDetail> createState() => _DiscussionDetailState();
}

class _DiscussionDetailState extends State<DiscussionDetail> {
  final replyTextEditingController = TextEditingController();
  Map<String, VoteBloc> voteBlocMap = {};
  @override
  initState() {
    BlocProvider.of<GetRepliesBloc>(context)
        .add(GetReplies(widget.discussion.discussionId.toString(), false));

    super.initState();
  }

  @override
  dispose() {
    replyTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<GetRepliesBloc>(context).add(
                GetReplies(widget.discussion.discussionId.toString(), false));
          },
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),

              DiscussionCard(
                  voteBlocMap: widget.voteBlocDiscussionMap,
                  discussion: widget.discussion,
                  descriptionLength: widget.discussion.description.length),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text("Replies",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 19.sp)),
                ),
              ),
              repliesSection(context),
              SizedBox(height: 7.h),
              BlocListener<AddDiscussionBloc, AddDiscussionState>(
                  listener: (context, state) {
                    if (state is AddDiscussionSuccess) {
                      BlocProvider.of<GetRepliesBloc>(context).add(GetReplies(
                          widget.discussion.discussionId.toString(), false));
                      setState(() {
                        replyTextEditingController.text = '';
                      });
                    }
                  },
                  child: const SizedBox())
              //
            ],
          )),
        ),
        bottomSheet: bottomTextField("Add Reply", context,
            replyTextEditingController, onReplySubmitted));
  }

  Widget repliesSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: BlocConsumer<GetRepliesBloc, GetRepliesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetRepliesLoading) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                      child: ShimmerWidget(height: 15.h),
                    ));
          } else if (state is GetRepliesSuccess) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.replies.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ReplyCard(
                              voteBlocMap: voteBlocMap,
                              reply: state.replies[index],
                            )),
                      ],
                    ));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: NoDataReload(
                    height: 20.h,
                    onPressed: () {
                      BlocProvider.of<GetRepliesBloc>(context).add(GetReplies(
                          widget.discussion.discussionId.toString(), false));
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  onReplySubmitted() {
    if (replyTextEditingController.text == '') {
      return;
    }
    BlocProvider.of<AddDiscussionBloc>(context).add(AddDiscussion(
        id: widget.discussion.discussionId,
        body: replyTextEditingController.text,
        isQuestion: false));
  }
}
