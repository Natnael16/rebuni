import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameEditingController =
      TextEditingController();
  final TextEditingController _bioEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 12.h),
                  child: Text("Almost Done",
                      style: Theme.of(context).textTheme.displayLarge),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Stack(children: [
                      Container(
                          width: 24.w,
                          height: 11.h,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFF1F3FC),
                            shape: OvalBorder(),
                          ),
                          child: image == null
                              ? Icon(Icons.add_a_photo_outlined)
                              : ClipOval(
                                  child:
                                      Image.file(image!, fit: BoxFit.cover))),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: InkWell(
                          onTap: _getImage,
                          child: Container(
                              width: 6.7.w,
                              height: 3.h,
                              decoration: const ShapeDecoration(
                                color: secondaryColor,
                                shape: OvalBorder(),
                              ),
                              child: Icon(Icons.add, color: white)),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 4.w,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Upload your photo",
                              maxLines: null,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: black)),
                          SizedBox(height: 2.h),
                          SizedBox(
                            width: 55.w,
                            child: Text(
                              "Will be displayed to other as your profile image",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            CustomTextField(
                hintText: "Full Name",
                validator: validateFullName,
                textEditingController: _fullNameEditingController,
                borderRadius: 4,
                icon: Icons.person_outline_outlined),
            SizedBox(
              height: 2.h,
            ),
            CustomTextField(
                hintText: 'Bio',
                validator: (value) => null,
                textEditingController: _bioEditingController,
                borderRadius: 4,
                icon: Icons.mail_outline_outlined),
            SizedBox(
              height: 4.h,
            ),
            CustomButton(
              borderRadius: 4,
              buttonText: "Complete profile",
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  if (_fullNameEditingController.text == "" ||
                      validateFullName(_fullNameEditingController.text) !=
                          null) {
                    return;
                  }
                  print("passed");
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
