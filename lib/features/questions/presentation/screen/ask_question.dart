import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../../../core/utils/validators.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../bloc/image_picker_bloc/image_picker_bloc.dart';
import '../widget/categories_drop_down.dart';
import '../widget/custom_round_button.dart';
import '../widget/image_picker_text_field.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({super.key});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _titleController = TextEditingController();

  final _imageController = TextEditingController();
  bool? isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    return FlexibleBottomSheet(
        bottomSheetColor: black.withOpacity(0),
        initHeight: 0.9,
        maxHeight: 0.9,
        minHeight: 0.89999,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
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
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title *',
                            style: textTheme.bodyMedium!.copyWith(
                                color: black, fontWeight: FontWeight.w500),
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
                          Text(
                            'Description *',
                            style: textTheme.bodyMedium!.copyWith(
                                color: black, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomTextField(
                              multiline: true,
                              height: 30.h,
                              width: MediaQuery.of(context).size.width,
                              hintText: "Write a discription for your question",
                              borderRadius: 4,
                              validator: validateDescription,
                              textEditingController: _descriptionController),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Categories *',
                            style: textTheme.bodyMedium!.copyWith(
                                color: black, fontWeight: FontWeight.w500),
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
                              controller: _imageController,
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
                                    isAnonymous = newValue;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                                // Customize the select color
                              ),
                              SizedBox(width: 3.h),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAnonymous = isAnonymous != null &&
                                            isAnonymous == true
                                        ? false
                                        : true;
                                  });
                                },
                                child: Text(
                                  'Anonymously ask',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Center(
                            child: CustomRoundButton(
                                buttonText: 'Ask Now',
                                onPressed: onAskNowPressed,
                                borderRadius: 20),
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
    if (_formKey.currentState!.validate()) {
      CategorySelectorState categoryState;
      ImagePickerState imagePickerState;

      categoryState = BlocProvider.of<CategorySelectorBloc>(context).state;
      imagePickerState = BlocProvider.of<ImagePickerBloc>(context).state;

      if (categoryState is CategorySelectorInitial &&
          categoryState.categories.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please fill all the fields with * sign",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
            ),
            elevation: 5,
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
          ),
        );
        return;
      }
      _formKey.currentState!.save();
      return;
    }

    

  }
}
