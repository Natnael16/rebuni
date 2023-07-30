import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/shared_widgets/shimmer.dart';
import '../../domain/entity/answer.dart';
import '../../domain/entity/question.dart';
import '../bloc/add_discussion_bloc/add_discussion_bloc.dart';
import '../bloc/get_replies_bloc/get_replies_bloc.dart';
import '../widget/answer_card.dart';
import '../widget/bottom_text_field.dart';
import '../widget/custom_cached_image.dart';
import '../widget/full_screen_image_view.dart';
import '../widget/reply_card.dart';

class AnswerDetail extends StatefulWidget {
  final Answer answer;
  final Question question;
  AnswerDetail({super.key, required this.answer, required this.question});

  @override
  State<AnswerDetail> createState() => _AnswerDetailState();
}

class _AnswerDetailState extends State<AnswerDetail> {
  final replyTextEditingController = TextEditingController();
  @override
  initState() {
    BlocProvider.of<GetRepliesBloc>(context)
        .add(GetReplies(widget.answer.answerId.toString(), true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<GetRepliesBloc>(context)
                .add(GetReplies(widget.answer.answerId.toString(), true));
          },
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Wrap(children: [
                  Text("Question: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 17.sp)),
                  Text(widget.question.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15.sp)),
                ]),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Text(widget.question.description,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 1.h,
              ),
        
              widget.answer.imageUrl != ""
                  ? InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => FullScreenImageViewer(
                                imagePath: widget.answer.imageUrl));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomizedCachedImage(
                            imageURL: widget.answer.imageUrl,
                            width: double.infinity,
                            height: 35.h,
                            borderRadius: 10,
                            fit: BoxFit.cover),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 2.h,
              ),
              AnswerCard(
                showImage: false,
                answer: widget.answer,
                descriptionLength: widget.answer.description.length,
              ),
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
                      BlocProvider.of<GetRepliesBloc>(context).add(
                          GetReplies(widget.answer.answerId.toString(), true));
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
        bottomSheet: bottomTextField(
            "Add Reply", context, replyTextEditingController, onReplySubmitted));
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
                      BlocProvider.of<GetRepliesBloc>(context).add(
                          GetReplies(widget.answer.answerId.toString(), true));
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
        id: widget.answer.answerId.toString(),
        body: replyTextEditingController.text,isQuestion: false));
  }
}
