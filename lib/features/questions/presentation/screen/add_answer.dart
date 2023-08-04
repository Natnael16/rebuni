import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:go_router/go_router.dart';
import 'package:rebuni/core/shared_widgets/custom_loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/custom_round_button.dart';
import '../../../../core/utils/colors.dart';
import '../../domain/entity/question.dart';
import '../bloc/add_answer_bloc/add_answer_bloc.dart';
import '../bloc/get_answers_bloc/get_answers_bloc.dart';
import '../bloc/image_picker_bloc/image_picker_bloc.dart';
import '../widget/image_picker_text_field.dart';
import '../widget/top_snack_bar.dart';

class AddAnswerPage extends StatefulWidget {
  final Question question;
  const AddAnswerPage({super.key, required this.question});

  @override
  State<AddAnswerPage> createState() => _AddAnswerPageState();
}

class _AddAnswerPageState extends State<AddAnswerPage> {
  late QuillController _controller;
  late TextEditingController _textController;
  late TextEditingController imagePickerController;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();

    _textController =
        TextEditingController(text: _controller.document.toDelta().toString());
    imagePickerController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(children: [
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
              SizedBox(
                height: 1.h,
              ),
              Text(widget.question.description,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text(
                    'Answer ',
                    style: textTheme.bodyMedium!
                        .copyWith(color: black, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '*',
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: Adaptive.h(30),
                decoration: const BoxDecoration(
                  color: textFieldColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: QuillEditor.basic(
                      controller: _controller, readOnly: false),
                ),
              ),
              QuillToolbar.basic(
                controller: _controller,
                showSearchButton: false,
                showListCheck: false,
                showSubscript: false,
                showSuperscript: false,
                showHeaderStyle: false,
                showCodeBlock: false,
                showInlineCode: false,
                showBackgroundColorButton: false,
              ),
              Text(
                'Image',
                style: textTheme.bodyMedium!
                    .copyWith(color: black, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 1.h,
              ),
              ImagePickerTextField(
                  controller: imagePickerController,
                  hintText: "Select Image",
                  icon: Icons.add_photo_alternate_outlined),
              SizedBox(
                height: 8.h,
              ),
              BlocConsumer<AddAnswerBloc, AddAnswerState>(
                listener: (context, state) {
                  if (state is AddAnswerFailure) {
                    showTopSnackBar(context,
                        const TopSnackBar(error: true, message: "Post Failed"));
                  }
                  if (state is AddAnswerSuccess) {
                    showTopSnackBar(
                        context,
                        const TopSnackBar(
                            error: false, message: "Answered Successfully!"));
                    BlocProvider.of<GetAnswersBloc>(context)
                        .add(GetAnswers(widget.question.questionId));
                    context.pop();
                  }
                },
                builder: (context, state) {
                  if (state is AddAnswerLoading) {
                    return const Align(
                        alignment: Alignment.center,
                        child: UniqueProgressIndicator());
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: CustomRoundButton(
                        buttonText: 'Post',
                        onPressed: onPostPressed,
                        borderRadius: 20),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPostPressed() {
    var descriptionJson = _controller.document.toDelta().toJson();
    String description = jsonEncode(descriptionJson);

    if (description.length < 20) {
      showTopSnackBar(
          context,
          const TopSnackBar(
              error: true, message: "Answer Should at least be 20 characters"));
      return;
    }

    ImagePickerState imagePickerState =
        BlocProvider.of<ImagePickerBloc>(context).state;

    File? image;
    image =
        (imagePickerState is ImageAddedState) ? imagePickerState.image : null;
    BlocProvider.of<AddAnswerBloc>(context).add(AddAnswer(
        description: description,
        questionId: widget.question.questionId,
        image: image));
  }
}
