import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    this.isNumber = false,
    required this.borderRadius,
    required this.icon,
    required this.validator,
    Key? key,
    required this.textEditingController, required this.hintText,
  }) : super(key: key);

  final double borderRadius;
  final IconData icon;
  final bool isNumber;
  final String hintText;
  final String? Function(String?) validator; // Updated validator parameter
  final textEditingController;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _textFieldFocusNode = FocusNode();
  String? _errorText;

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 85.w,
          padding: EdgeInsets.symmetric(horizontal: (4).w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: textFieldColor,
          ),
          child: TextField(
            keyboardType:
                widget.isNumber ? TextInputType.phone : TextInputType.text,
            cursorColor: primaryColor,
            focusNode: _textFieldFocusNode,
            controller: widget.textEditingController,
            onChanged: (value) {
              setState(() {
                _errorText = widget.validator(value);
              });
            },
            decoration: InputDecoration(
              icon: Icon(widget.icon, color: textFieldGrayColor, size: (2.5).h),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.labelSmall,
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
            : SizedBox()
      ],
    );
  }
}
