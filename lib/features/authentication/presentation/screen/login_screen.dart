import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/authentication/presentation/bloc/provider_sign_in/provider_sign_in_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/injections/injection_container.dart';
import '../../../../core/routes/paths.dart' as path;
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/validators.dart';
import '../../../../main.dart';
import '../../domain/use_cases/profile_usecase.dart';
import '../bloc/sign_in_bloc/sign_in_bloc.dart';
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
                    hintText: "Phone Number",
                    textEditingController: _phoneEditingController,
                    validator: validatePhoneNumber,
                    borderRadius: 5,
                    icon: Icons.phone_android_rounded,
                    isNumber: true,
                  ),
                  SizedBox(height: 8.h),
                  BlocConsumer<SignInBloc, SignInState>(
                      builder: (context, SignInState state) {
                    if (state is SignInLoading) {
                      return UniqueProgressIndicator();
                    } else {
                      return CustomButton(
                        borderRadius: 4,
                        buttonText: "Sign in",
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            if (_phoneEditingController.text == "" ||
                                validatePhoneNumber(
                                        _phoneEditingController.text) !=
                                    null) {
                              return;
                            }
                            BlocProvider.of<SignInBloc>(context)
                                .add(SignInClick(_phoneEditingController.text));
                          }
                        },
                      );
                    }
                  }, listener: (context, SignInState state) {
                    if (state is SignInSuccess) {
                      context.push(path.otp, extra: {
                        'phoneNumber': _phoneEditingController.text,
                      });
                    }
                  }),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            ProviderButtons(
              icon: const Icon(Icons.person_rounded, color: primaryColor),
              buttonText: "Continue as guest",
              onPressed: () {
                context.push(path.home);
              },
            ),
            SizedBox(height: 2.h),
            BlocConsumer<ProviderSignInBloc, ProviderSignInState>(
                builder: (context, ProviderSignInState state) {
              return Column(
                children: [
                  (state is ProviderSignInLoading && state.provider == "Google")
                      ? UniqueProgressIndicator()
                      : ProviderButtons(
                          buttonText: "Continue with Google",
                          icon: Image(
                            height: 7.h,
                            width: 7.w,
                            image: const AssetImage(googleLogoImage),
                          ),
                          onPressed: () {
                            BlocProvider.of<ProviderSignInBloc>(context)
                                .add(const ContinueWithProvider("Google"));
                          },
                        ),
                  SizedBox(height: 2.h),
                  (state is ProviderSignInLoading &&
                          state.provider == "Facebook")
                      ? UniqueProgressIndicator()
                      : ProviderButtons(
                          buttonText: "Continue with Facebook",
                          icon: Image(
                            height: 7.h,
                            width: 7.w,
                            image: const AssetImage(facebookLogoImage),
                          ),
                          onPressed: () {
                            BlocProvider.of<ProviderSignInBloc>(context)
                                .add(const ContinueWithProvider("Facebook"));
                          },
                        ),
                ],
              );
            }, listener: (context, ProviderSignInState state) {
              if (state is ProviderSignInSuccess) {
                final AlertDialog alertDialog = AlertDialog(
                  content: UniqueProgressIndicator(),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alertDialog;
                  },
                );
                supabase.auth.onAuthStateChange.listen((data) {
                  final session = data.session;

                  if (session != null) {
                    User user = session.user;
                    SignUpUseCase signUpUseCase = SignUpUseCase(getIt());
                    signUpUseCase(
                      SignUpParams(fullName: user.userMetadata!["full_name"],profileUrl: user.userMetadata!["picture"]));
                    context.go(path.home);
                  }
                }).onError((error, stackTrace) {
                  print(error);
                  context.go(path.login);
                });
              }
            }),
          ],
        ),
      ),
    );
  }
}
