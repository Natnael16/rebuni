import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../../../core/utils/colors.dart';
import '../widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String otpMatch;
  final bool isFirstTimeUser;
  final String phoneNumber;

  const OTPScreen(
      {Key? key,
      required this.otpMatch,
      required this.isFirstTimeUser,
      required this.phoneNumber})
      : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int duration = 120;
  int _endTime = DateTime.now().millisecondsSinceEpoch +
      (2 * 60 * 1000); // Initial end time
  bool get isTimerRunning => _endTime > DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              SizedBox(height: 21.h),
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
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                    // Handle OTP code changes here
                    if (value.length == 6) {
                      context.push(path.signUp);
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: primaryColor,
                    selectedColor: primaryColor,
                    inactiveColor: Colors.grey,
                    disabledColor: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                    activeFillColor: textFieldColor,
                    fieldHeight: 5.h,
                    fieldWidth: 10.w,
                    inactiveFillColor: textFieldColor,
                    selectedFillColor: textFieldColor,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: CustomButton(
                  buttonText: "Continue",
                  borderRadius: 4,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resend code in:',
                      style: Theme.of(context).textTheme.labelSmall),
                  CountdownTimer(
                    endTime: _endTime,
                    textStyle: Theme.of(context).textTheme.labelSmall,
                    onEnd: () {
                      // Timer ended, perform desired actions
                    },
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 24.w, maxHeight: 4.h),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(secondaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      onPressed: isTimerRunning
                          ? null
                          : () {
                              setState(() {
                                _endTime =
                                    DateTime.now().millisecondsSinceEpoch +
                                        (duration * 1000);
                                //! add bloc event
                              });
                            },
                      child: Text('Resend',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontSize: 14.sp, color: white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
