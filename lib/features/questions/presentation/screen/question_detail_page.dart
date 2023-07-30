import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/questions/presentation/bloc/add_discussion_bloc/add_discussion_bloc.dart';
import 'package:rebuni/features/questions/presentation/widget/question_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/colors.dart';
import '../../domain/entity/question.dart';
import '../bloc/get_answers_bloc/get_answers_bloc.dart';
import '../bloc/get_discussions_bloc/get_discussions_bloc.dart';
import '../widget/answer_card.dart';
import '../widget/bottom_text_field.dart';
import '../widget/custom_cached_image.dart';

import '../widget/discussion_card.dart';
import '../widget/full_screen_image_view.dart';

class QuestionDetail extends StatefulWidget {
  final Question question;
  const QuestionDetail({super.key, required this.question});

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  @override
  initState() {
    BlocProvider.of<GetAnswersBloc>(context)
        .add(GetAnswers(widget.question.questionId));
    BlocProvider.of<GetDiscussionsBloc>(context)
        .add(GetDiscussions(widget.question.questionId));
    super.initState();
  }

  final commentTextEditingController = TextEditingController();
  @override
  dispose() {
    commentTextEditingController.dispose();
    super.dispose();
  }

  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        InkWell(
          onTap: () {
            context.push(path.addAnswer,extra : {'question' : widget.question});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text("Answer",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: white)),
                SizedBox(width: 1.w),
                const Icon(Icons.add_sharp, color: white),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        )
      ]),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<GetAnswersBloc>(context)
              .add(GetAnswers(widget.question.questionId));
          BlocProvider.of<GetDiscussionsBloc>(context)
              .add(GetDiscussions(widget.question.questionId));
        },
        child: SingleChildScrollView(
            child: Column(
          children: [
            widget.question.imageUrl != ""
                ? InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => FullScreenImageViewer(
                              imagePath: widget.question.imageUrl));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomizedCachedImage(
                          imageURL: widget.question.imageUrl,
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
            QuestionCard(
              widget.question,
              showImage: false,
              showActions: tagsSection(context),
              descriptionLength: widget.question.description.length,
            ),
            DefaultTabController(
              length: 2,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    tabIndex = index;
                  });
                },
                isScrollable: true, // Allow horizontal scrolling
                tabs: ["Answers", "Discussions"].map((String tab) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 10.w,
                        child: Text(tab,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge)),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            tabIndex == 0
                ? answersSection(context)
                : discussionsSection(context),
            tabIndex == 0 ? const SizedBox() : SizedBox(height: 7.h),
            BlocListener<AddDiscussionBloc, AddDiscussionState>(
                listener: (context, state) {
                  if (state is AddDiscussionSuccess) {
                    BlocProvider.of<GetDiscussionsBloc>(context)
                        .add(GetDiscussions(widget.question.questionId));
                    setState(() {
                      commentTextEditingController.text = '';
                    });
                  }
                },
                child: const SizedBox())
          ],
        )),
      ),
      bottomSheet: tabIndex == 0
          ? const SizedBox()
          : bottomTextField(" Add Comment", context,
              commentTextEditingController, onCommentSubmitted),
    );
  }

  Widget tagsSection(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("Categories:", style: Theme.of(context).textTheme.bodyMedium),
      SizedBox(
        height: 1.h,
      ),
      Wrap(
          children: widget.question.categories
              .map((cat) => Text('$cat, ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: blackTextColor)))
              .toList())
    ]);
  }

  answersSection(BuildContext context) {
    return BlocConsumer<GetAnswersBloc, GetAnswersState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetAnswersLoading) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    child: ShimmerWidget(height: 15.h),
                  ));
        } else if (state is GetAnswersSuccess) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.answerList.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AnswerCard(
                            onPressed: () {
                              context.push(path.answerDetail, extra: {
                                'answer': state.answerList[index],
                                'question': widget.question
                              });
                            },
                            answer: state.answerList[index]),
                      ),
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
                    BlocProvider.of<GetAnswersBloc>(context)
                        .add(GetAnswers(widget.question.questionId));
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  discussionsSection(BuildContext context) {
    return BlocConsumer<GetDiscussionsBloc, GetDiscussionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetDiscussionsLoading) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    child: ShimmerWidget(height: 15.h),
                  ));
        } else if (state is GetDiscussionsSuccess) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.discussionList.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DiscussionCard(
                              onPressed: () {
                                context.push(path.discussionDetail, extra: {
                                  'discussion': state.discussionList[index]
                                });
                              },
                              discussion: state.discussionList[index])),
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
                    BlocProvider.of<GetDiscussionsBloc>(context)
                        .add(GetDiscussions(widget.question.questionId));
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  onCommentSubmitted() {
    if (commentTextEditingController.text == '') {
      return;
    }
    BlocProvider.of<AddDiscussionBloc>(context).add(AddDiscussion(
        id: widget.question.questionId,
        body: commentTextEditingController.text));
  }
}
