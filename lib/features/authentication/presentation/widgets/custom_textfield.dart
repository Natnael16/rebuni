import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

class CustomTextFieldQuestions extends StatefulWidget {
  CustomTextFieldQuestions(
      {this.isNumber = false,
      required this.borderRadius,
      required this.icon,
      required this.validator,
      Key? key,
      required this.textEditingController,
      required this.hintText,
      this.autofocus = false,
      this.onTap,
      this.suffix,
      this.readonly = false,
      this.color,
      this.width})
      : super(key: key);

  final double borderRadius;
  double? width;
  final Widget icon;
  final bool isNumber;
  final Color? color;
  final Widget? suffix;
  final bool autofocus;
  final String hintText;
  final bool readonly;
  final String? Function(String?) validator; // Updated validator parameter
  final void Function()? onTap;
  final TextEditingController textEditingController;

  @override
  _CustomTextFieldQuestionsState createState() =>
      _CustomTextFieldQuestionsState();
}

class _CustomTextFieldQuestionsState extends State<CustomTextFieldQuestions> {
  String? _errorText;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width ?? 85.w,
          padding: EdgeInsets.only(left: (3).w, right: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.color ?? textFieldColor,
          ),
          child: TextField(
            onTap: widget.onTap,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w500, color: black),
            keyboardType:
                widget.isNumber ? TextInputType.phone : TextInputType.text,
            cursorColor: primaryColor,
            readOnly: widget.readonly,
            autofocus: widget.autofocus,
            controller: widget.textEditingController,
            onChanged: (value) {
              setState(() {
                _errorText = widget.validator(value);
              });
            },
            decoration: InputDecoration(
              suffixIcon: widget.suffix,
              icon: widget.icon,
              hintText: widget.hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontWeight: FontWeight.w300),
              border: InputBorder.none,
            ),
          ),
        ),
        
        SizedBox(
          height: 2.h,
        ),
        _errorText != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(_errorText!,
                      style: const TextStyle(color: Colors.red)),
                ))
            : const SizedBox()
      ],
    );
  }
}
