import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_providers_button.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign in',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText:"Phone Number",
                    textEditingController: _phoneEditingController,
                    validator: validatePhoneNumber,
                    borderRadius: 5,
                    icon: Icons.phone_android_rounded,
                    isNumber: true,
                  ),
                  SizedBox(height: 8.h),
                  CustomButton(
                    borderRadius: 4,
                    buttonText: "Sign in",
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        if (_phoneEditingController.text == "" || validatePhoneNumber(_phoneEditingController.text) != null) {
                          return;
                        }
                      
                        // Perform login logic if the form is valid
                        context.push(path.otp, extra: {
                          'otpMatch': '696447',
                          'phoneNumber': _phoneEditingController.text,
                          'isFirstTimeUser': true
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            ProviderButtons(
              icon: Icon(Icons.person_rounded, color: primaryColor),
              buttonText: "Continue as guest",
              onPressed: () {},
            ),
            SizedBox(height: 2.h),
            ProviderButtons(
              buttonText: "Continue with Google",
              icon: Image(
                height: 7.h,
                width: 7.w,
                image: AssetImage(googleLogoImage),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 2.h),
            ProviderButtons(
              buttonText: "Continue with Facebook",
              icon: Image(
                height: 7.h,
                width: 7.w,
                image: AssetImage(facebookLogoImage),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
