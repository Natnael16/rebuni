import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/core/shared_widgets/shimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/routes/paths.dart' as path;
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../domain/entity/question.dart';
import '../bloc/get_questions_bloc/get_questions_bloc.dart';
import '../widget/bottom_navbar_item.dart';
import '../widget/question_card.dart';
import './ask_question.dart';

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
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(backgroundColor: white, actions: [
        InkWell(
          onTap: () {
            showDialog(context: context, builder: (context) => AskQuestion());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text("Ask", style: textTheme.bodySmall!.copyWith(color: white)),
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
      body: Column(children: [
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
                                              state.questions[index]),
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
                                                        : UniqueProgressIndicator()),
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
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: questions.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: QuestionCard(questions[index]),
                              )),
                    ),
                  ],
                ),
              ]),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          buildBottomNavigationBarItem(
              Icons.home, 'Home', homeIcon, primaryColor),
          buildBottomNavigationBarItem(
              Icons.search, 'Search', searchIcon, primaryColor),
          buildBottomNavigationBarItem(
              Icons.bookmark, 'Bookmark', bookmarkIcon, primaryColor),
          buildBottomNavigationBarItem(
              Icons.person, 'Profile', profileIcon, primaryColor),
        ],
      ),
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
