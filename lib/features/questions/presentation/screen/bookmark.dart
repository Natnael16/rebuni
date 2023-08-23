import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/vote_bloc_maps.dart';
import '../bloc/bookmark_bloc/bookmark_bloc.dart';
import '../widget/question_actions.dart';
import '../widget/question_card.dart';

class BookMark extends StatefulWidget {
  BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {


  @override
  initState() {
    if (BlocProvider.of<BookmarkBloc>(context).state is BookmarkInitial){
      BlocProvider.of<BookmarkBloc>(context).add(BookmarkFetch());
    }
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<BookmarkBloc>(context).add(BookmarkFetch());
      },
      child: SingleChildScrollView(    
        child: Column(
          children: [
        
            BlocConsumer<BookmarkBloc, BookmarkState>(
              listener: (context, state) {
                
              },
              builder: (context, state) {
                if (state is BookmarkLoading) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) => Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                            child: ShimmerWidget(height: 25.h),
                          ));
                } else if (state is BookmarkSuccess) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.questions.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: QuestionCard(state.questions[index],
                                    showActions: ActionsSection(
                                        onAnswerPressed: () => context
                                                .push(path.questionDetail, extra: {
                                              "question": state.questions[index],
                                              "tabIndex": 0
                                            }),
                                        onDiscussionPressed: () => context
                                                .push(path.questionDetail, extra: {
                                              "question": state.questions[index],
                                              "tabIndex": 1
                                            }),
                                        voteBlocMap: questionsVoteBlocMap,
                                        key: Key(state.questions[index].questionId),
                                        upvoteCount:
                                            state.questions[index].vote.upvote,
                                        downvoteCount:
                                            state.questions[index].vote.downvote,
                                        numberOfAnswers:
                                            state.questions[index].numberOfAnswers,
                                        numberOfDiscussions: state.questions[index].numberOfDiscussions,
                                        table: 'question',
                                        userBookmarked: state.questions[index].userBookmarked,

                                        id: state.questions[index].questionId,
                                        userReaction: state.questions[index].userReaction),
                                    onPressed: () => context.push(path.questionDetail, extra: {"question": state.questions[index], "tabIndex": 0})),
                              ),
                            ],
                          ));
                }
                return Column(
                  children: [
                    SizedBox(height: 15.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: NoDataReload(
                        onPressed: () {
                          BlocProvider.of<BookmarkBloc>(context).add(BookmarkFetch());
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
