import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/core/shared_widgets/shimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/routes/paths.dart' as path;
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/vote_bloc_maps.dart';
import '../../domain/entity/question.dart';
import '../bloc/get_questions_bloc/get_questions_bloc.dart';
import '../widget/question_actions.dart';
import '../widget/question_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<GetQuestionsBloc>(context).add(GetQuestions());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  List<Question> questions = [];
  var tabIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                _pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: Text(
                'Questions',
                style: textTheme.bodyLarge!
                    .copyWith(color: tabIndex == 0 ? black : blackTextColor),
              ),
            ),
            TextButton(
              onPressed: () {
                _pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: Text(
                'Posts',
                style: textTheme.bodyLarge!
                    .copyWith(color: tabIndex == 1 ? black : blackTextColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 10,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: tabIndex == 0 ? black : blackTextColor,
                      width: tabIndex == 0 ? 2.0 : 1,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 10,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: tabIndex == 1 ? black : blackTextColor,
                      width: tabIndex == 1 ? 2.0 : 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Expanded(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  tabIndex = index;
                });
              },
              children: [
                Flex(direction: Axis.vertical, children: [
                  Expanded(
                    child: BlocConsumer<GetQuestionsBloc, GetQuestionsState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is GetQuestionsLoading) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 2.h),
                                    child: ShimmerWidget(height: 25.h),
                                  ));
                        } else if (state is QuestionsLoaded) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              BlocProvider.of<GetQuestionsBloc>(context)
                                  .add(RefreshQuestions());
                            },
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: state.questions.length,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: QuestionCard(
                                              state.questions[index],
                                              showActions: ActionsSection(
                                                onAnswerPressed: () => context
                                                    .push(path.questionDetail,
                                                        extra: {
                                                      "question": state
                                                          .questions[index],
                                                      "tabIndex": 0
                                                    }),
                                                onDiscussionPressed: () =>
                                                    context.push(
                                                        path.questionDetail,
                                                        extra: {
                                                      "question": state
                                                          .questions[index],
                                                      "tabIndex": 1
                                                    }),
                                                voteBlocMap:
                                                    questionsVoteBlocMap,
                                                key: Key(state.questions[index]
                                                    .questionId),
                                                upvoteCount: state
                                                    .questions[index]
                                                    .vote
                                                    .upvote,
                                                downvoteCount: state
                                                    .questions[index]
                                                    .vote
                                                    .downvote,
                                                numberOfAnswers: state
                                                    .questions[index]
                                                    .numberOfAnswers,
                                                numberOfDiscussions: state
                                                    .questions[index]
                                                    .numberOfDiscussions,
                                                table: 'question',
                                                id: state.questions[index]
                                                    .questionId,
                                                userReaction: state
                                                    .questions[index]
                                                    .userReaction,
                                                userBookmarked: state
                                                    .questions[index]
                                                    .userBookmarked,
                                              ),
                                              onPressed: () => context.push(
                                                      path.questionDetail,
                                                      extra: {
                                                        "question": state
                                                            .questions[index],
                                                        "tabIndex": 0
                                                      })),
                                        ),
                                        index >= state.questions.length - 1
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                child: Center(
                                                    child: state.hasReachedMax
                                                        ? Text(
                                                            "End of the list",
                                                            style: textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color:
                                                                        primaryColor),
                                                          )
                                                        : const UniqueProgressIndicator()),
                                              )
                                            : const SizedBox()
                                      ],
                                    )),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NoDataReload(
                                onPressed: () {
                                  BlocProvider.of<GetQuestionsBloc>(context)
                                      .add(RefreshQuestions());
                                  BlocProvider.of<GetQuestionsBloc>(context)
                                      .add(GetQuestions());
                                },
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ]),
                const Flex(
                  direction: Axis.vertical,
                  children: [],
                ),
              ]),
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<GetQuestionsBloc>().add(GetQuestions());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
