import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/core/shared_widgets/custom_loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../../core/injections/injection_container.dart';
import '../../../../core/routes/paths.dart' as path;
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/colors.dart';
import '../../domain/use_cases/check_first_time_login_use_case.dart';
import '../bloc/otp_bloc/otp_bloc_bloc.dart';
import '../bloc/sign_in_bloc/sign_in_bloc.dart';
import '../widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();
  int duration = 120;
  int _endTime =
      DateTime.now().millisecondsSinceEpoch + (120 * 1000); // Initial end time
  bool get isTimerRunning => DateTime.now().millisecondsSinceEpoch < _endTime;
  bool showResend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const BackButtonIcon()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Enter OTP',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
              ),
              SizedBox(height: 1.h),
              Text(
                'An OTP has been sent to ${widget.phoneNumber}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: PinCodeTextField(
                  controller: _otpController,
                  appContext: context,
                  length: 6,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: primaryColor,
                    selectedColor: primaryColor,
                    inactiveColor: Colors.grey,
                    disabledColor: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                    activeFillColor: textFieldColor,
                    fieldHeight: 54,
                    fieldWidth: 10.w,
                    inactiveFillColor: textFieldColor,
                    selectedFillColor: textFieldColor,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 4.h),
              BlocConsumer<OtpBlocBloc, OtpBlocState>(
                  builder: (context, state) {
                if (state is VerifyOtpLoading) {
                  return const Center(child: UniqueProgressIndicator());
                } else {
                  return Center(
                    child: CustomButton(
                      onPressed: () {
                        if (_otpController.text.length == 6) {
                          BlocProvider.of<OtpBlocBloc>(context).add(VerifyOTP(
                              _otpController.text, widget.phoneNumber));
                        }
                      },
                      buttonText: "Continue",
                      borderRadius: 4,
                    ),
                  );
                }
              }, listener: (context, state) {
                if (state is VerifyOtpSuccess) {
                  isFirstTimeUser();
                }
              }),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resend code in:',
                      style: Theme.of(context).textTheme.labelSmall),
                  CountdownTimer(
                    endTime: _endTime,
                    textStyle: Theme.of(context).textTheme.labelSmall,
                    endWidget: Text("00 : 00 : 00",
                        style: Theme.of(context).textTheme.labelSmall),
                    onEnd: () {
                      setState(() {
                        showResend = true;
                      });
                    },
                  ),
                  showResend
                      ? ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: 24.w, maxHeight: 4.h),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (isTimerRunning) {
                                return;
                              }
                              setState(() {
                                _endTime =
                                    DateTime.now().millisecondsSinceEpoch +
                                        (duration * 1000);
                                BlocProvider.of<SignInBloc>(context)
                                    .add(SignInClick(widget.phoneNumber));
                              });
                            },
                            child: Text('Resend',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontSize: 14.sp, color: white)),
                          ),
                        )
                      : SizedBox(width: 8.w)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> isFirstTimeUser() async {
    final firstTimeUseCase = FirstTimeUseCase(getIt());

    final isFirstTime = await firstTimeUseCase(NoParams());

    isFirstTime.fold((failure) => context.push(path.signUp), (success) {
      success ? context.go(path.home) : context.push(path.signUp);
    });
  }
}
