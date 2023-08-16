import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/get_questions_bloc/get_questions_bloc.dart';
import '../bloc/image_picker_bloc/image_picker_bloc.dart';
import '../bloc/post_question_bloc/questions_bloc.dart';
import '../widget/categories_drop_down.dart';
import '../../../../core/shared_widgets/custom_round_button.dart';
import '../widget/image_picker_text_field.dart';
import '../widget/top_snack_bar.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({super.key});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();

  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final imagePickerController = TextEditingController();

  CategorySelectorBloc? _categorySelectorBloc;
  ImagePickerBloc? _imagePickerBloc;
  GetQuestionsBloc? _getQuestionsBloc;

  bool isAnonymous = false;
  @override
  void initState() {
    _categorySelectorBloc = BlocProvider.of<CategorySelectorBloc>(context);
    _imagePickerBloc = BlocProvider.of<ImagePickerBloc>(context);
    _getQuestionsBloc = BlocProvider.of<GetQuestionsBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    _categorySelectorBloc?.add(AddCategoriesEvent(const []));
    _imagePickerBloc?.add(RemoveImageEvent());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleBottomSheet(
        bottomSheetColor: black.withOpacity(0),
        initHeight: 0.7,
        maxHeight: 0.85,
        minHeight: 0.69999,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: white),
        bodyBuilder: (context, index) {
          TextTheme textTheme = Theme.of(context).textTheme;
          return SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Ask Question ',
                              style: textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                'Title ',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: black, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '*',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomTextField(
                              width: MediaQuery.of(context).size.width,
                              hintText: "Your question in one Sentence",
                              borderRadius: 4,
                              validator: validateTitle,
                              textEditingController: _titleController),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Description ',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: black, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '*',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomTextField(
                              multiline: true,
                              // height: 23.h,
                              width: MediaQuery.of(context).size.width,
                              hintText: "Write a discription for your question",
                              borderRadius: 4,
                              validator: validateDescription,
                              textEditingController: _descriptionController),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Categories ',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: black, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '*',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CategoriesDropDown(
                              categoryController: _categoryController),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Image',
                            style: textTheme.bodyMedium!.copyWith(
                                color: black, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ImagePickerTextField(
                              controller: imagePickerController,
                              hintText: "Select Image",
                              icon: Icons.add_photo_alternate_outlined),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isAnonymous,
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue != null) {
                                      isAnonymous = newValue;
                                    }
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                                // Customize the select color
                              ),
                              SizedBox(width: 3.h),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAnonymous =
                                        isAnonymous == true ? false : true;
                                  });
                                },
                                child: Text('Anonymously ask',
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: black,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Center(
                            child: BlocConsumer<QuestionsBloc, QuestionsState>(
                              listener: (context, state) {
                                if (state is PostQuestionSuccess) {
                                  _getQuestionsBloc?.add(RefreshQuestions());
                                  showTopSnackBar(
                                      context,
                                      const TopSnackBar(
                                          message: "Posted Successfully",
                                          error: false));

                                  context.pop();
                                } else if (state is PostQuestionFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Text(
                                            "Post Failed Please Try Again",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: white),
                                          ),
                                          const Spacer(),
                                          const Icon(Icons.cancel_outlined,
                                              color: white)
                                        ],
                                      ),
                                      elevation: 5,
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is PostQuestionLoading) {
                                  return const UniqueProgressIndicator();
                                }
                                return CustomRoundButton(
                                    buttonText: 'Ask Now',
                                    onPressed: onAskNowPressed,
                                    borderRadius: 20);
                              },
                            ),
                          )
                        ]),
                  ),
                ),
              );
            },
          );
        });
  }

  onAskNowPressed() {
    CategorySelectorState categoryState =
        BlocProvider.of<CategorySelectorBloc>(context).state;

    ImagePickerState imagePickerState =
        BlocProvider.of<ImagePickerBloc>(context).state;

    File? image;
    image =
        (imagePickerState is ImageAddedState) ? imagePickerState.image : null;
    List<String> categories;
    if (categoryState is CategorySelectorInitial) {
      categories = categoryState.categories;
    } else {
      return;
    }
    if (!_formKey.currentState!.validate() ||
        categoryState.categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill all neccessary fields",
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
          ),
          elevation: 5,
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
      return;
    }

    BlocProvider.of<QuestionsBloc>(context).add(PostQuestion(
        categories: categories,
        image: image,
        description: _descriptionController.text,
        isAnonymous: isAnonymous,
        title: _titleController.text));
  }
}
