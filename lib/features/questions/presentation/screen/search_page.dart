import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/core/utils/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/injections/injection_container.dart';
import '../../../../core/routes/paths.dart' as path;
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/shared_widgets/no_data_reload.dart';
import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/categories.dart';
import '../../../../core/utils/images.dart';
import '../../../authentication/presentation/widgets/custom_textfield.dart';
import '../../data/models/answer_model.dart';
import '../../data/models/discusion_model.dart';
import '../../data/models/question_model.dart';

import '../../domain/entity/answer.dart';
import '../../domain/entity/discussion.dart';
import '../../domain/entity/question.dart';
import '../../domain/entity/reply.dart';
import '../../domain/usecase/get_table_by_id_usecase.dart';
import '../bloc/search_bloc/search_bloc.dart';
import '../bloc/vote_bloc/vote_bloc.dart';
import '../widget/question_card.dart';
import 'filter_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchEditingController = TextEditingController();
  final searchForController = TextEditingController(text: "Questions");
  final sortByController = TextEditingController(text: "Upvotes");
  Map<String, VoteBloc> voteBlocDiscussionMap = {};

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => FilterPage(
          searchForController: searchForController,
          sortByController: sortByController,
          searchController: searchEditingController,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Align(
            alignment: Alignment.center,
            child: CustomTextFieldQuestions(
                readonly: true,
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => FilterPage(
                          sortByController: sortByController,
                          searchForController: searchForController,
                          searchController: searchEditingController,
                        )),
                color: textFieldColor.withOpacity(0.8),
                width: MediaQuery.of(context).size.width - 5.w,
                borderRadius: 4,
                suffix: const Icon(Icons.tune_rounded,
                    color: primaryColor, size: 32),
                icon: SvgPicture.asset(textFeildSearchIcon),
                validator: (value) => null,
                textEditingController: searchEditingController,
                hintText: "Search")),
        SizedBox(height: 1.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Search results",
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<SearchBloc>(context).add(Search(
                categories: categories,
                sortBy: "upvotes",
                table: 'questions',
                term: ''));
          },
          child: BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SearchLoading) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 2.h),
                          child: ShimmerWidget(height: 25.h),
                        ));
              } else if (state is SearchSuccess) {
                int modelType = state.searchResults[0].runtimeType ==
                        AnswerModel
                    ? 0
                    : state.searchResults[0].runtimeType != QuestionModel
                        ? 2
                        : 1; // 0 - answer, 1 - question, 2 -reply and comment
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: QuestionCard(
                                onPressed: () {
                                  switch (modelType) {
                                    case 1:
                                      onQuestionPressed(
                                          state.searchResults[index]);
                                      break;
                                    case 0:
                                      onAnswerPressed(
                                          state.searchResults[index]);
                                      break;
                                    case 2:
                                      if (state.searchResults[index]
                                              .runtimeType ==
                                          DiscussionModel) {
                                        onDiscussionPressed(
                                            state.searchResults[index]);
                                      } else {
                                        onReplyPressed(
                                            state.searchResults[index]);
                                      }

                                      break;
                                  }
                                },
                                moreOptions: false,
                                isAnswer: modelType != 1,
                                isFormattedBody: modelType == 0,
                                showImage: false,
                                showDivider: false,
                                state.searchResults[index],
                                showActions: const SizedBox(),
                              ),
                            ),
                          ],
                        ));
              } else if (state is SearchInitial) {
                return const SizedBox();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),
                  NoDataReload(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(Search(
                          categories: categories,
                          sortBy: "upvotes",
                          table: 'questions',
                          term: ''));
                    },
                  ),
                ],
              );
            },
          ),
        )
      ]),
    );
  }

  onQuestionPressed(Question question) async {
    context.push(path.questionDetail,
        extra: {"question": question, "tabIndex": 0});
  }

  onAnswerPressed(Answer answer) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const UniqueProgressIndicator();
      },
    );
    final getModelById = GetTableById(getIt());
    final dartz.Either<Failure, dynamic> response = await getModelById(
        TableByIdParams(table: 'question', id: answer.questionId));
    Map<String, VoteBloc> voteBloc = {};
    response.fold((failure) => context.pop(), (question) {
      context.pop();
      context.push(path.answerDetail, extra: {
        "question": question,
        "answer": answer,
        "voteBlocAnswerMap": voteBloc
      });
    });
  }

  onDiscussionPressed(Discussion discussion) async {
    context.push(path.discussionDetail, extra: {
      "discussion": discussion,
      "voteBlocDiscussionMap": voteBlocDiscussionMap
    });
  }

  onReplyPressed(Reply reply) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const UniqueProgressIndicator();
      },
    );
    final getModelById = GetTableById(getIt());
    var param = reply.discussionId != ''
        ? TableByIdParams(table: 'discussion', id: reply.discussionId)
        : TableByIdParams(table: 'answer', id: reply.answerId);
    final dartz.Either<Failure, dynamic> response = await getModelById(param);
    ;
    response.fold((failure) => context.pop(), (model) {
      context.pop();
      if (reply.discussionId != '') {
        context.push(path.discussionDetail, extra: {
          "discussion": model,
          "voteBlocDiscussionMap": voteBlocDiscussionMap
        });
      } else {}
    });
  }
}
