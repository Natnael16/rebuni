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
import '../../../../main.dart';
import '../../domain/use_cases/profile_usecase.dart';
import '../bloc/sign_in_bloc/sign_in_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_providers_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _phoneEditingController = "";

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
                  SizedBox(
                    width: 85.w,
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Phone Number",
                        hintStyle: Theme.of(context).textTheme.labelSmall,
                        border: InputBorder.none,
                        fillColor: textFieldColor,
                      ),
                      initialCountryCode: 'ET',
                      onChanged: (phone) {
                        // Handle phone number changes
                        setState(() {
                          _phoneEditingController = phone.completeNumber;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  BlocConsumer<SignInBloc, SignInState>(
                      builder: (context, SignInState state) {
                    if (state is SignInLoading) {
                      return const UniqueProgressIndicator();
                    } else {
                      return CustomButton(
                        borderRadius: 4,
                        buttonText: "Sign in",
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            BlocProvider.of<SignInBloc>(context)
                                .add(SignInClick(_phoneEditingController));
                          }
                        },
                      );
                    }
                  }, listener: (context, SignInState state) {
                    if (state is SignInSuccess) {
                      context.push(path.otp, extra: {
                        'phoneNumber': _phoneEditingController,
                      });
                    }
                  }),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            // ProviderButtons(
            //   icon: const Icon(Icons.person_rounded, color: primaryColor),
            //   buttonText: "Continue as guest",
            //   onPressed: () {
            //     context.push(path.pagesHolder);
            //   },
            // ),
            // SizedBox(height: 2.h),
            BlocConsumer<ProviderSignInBloc, ProviderSignInState>(
                builder: (context, ProviderSignInState state) {
              return Column(
                children: [
                  (state is ProviderSignInLoading && state.provider == "Google")
                      ? const UniqueProgressIndicator()
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
                      ? const UniqueProgressIndicator()
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const UniqueProgressIndicator();
                  },
                );
                supabase.auth.onAuthStateChange.listen((data) {
                  final session = data.session;

                  if (session != null) {
                    User user = session.user;
                    SignUpUseCase signUpUseCase = SignUpUseCase(getIt());
                    signUpUseCase(SignUpParams(
                        fullName: user.userMetadata!["full_name"],
                        profileUrl: user.userMetadata!["picture"]));
                    context.go(path.home);
                  }
                }).onError((error, stackTrace) {
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
