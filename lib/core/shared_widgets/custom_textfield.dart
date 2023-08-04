import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.multiline = false,
    this.height,
    required this.width,
    this.isNumber = false,
    required this.borderRadius,
    this.icon,
    required this.validator,
    Key? key,
    required this.textEditingController,
    required this.hintText,
  }) : super(key: key);
  final bool multiline;
  final double width;
  final double? height;
  final double borderRadius;
  final IconData? icon;
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
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.symmetric(horizontal: (4).w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: textFieldColor,
          ),
          child: TextFormField(
            validator:widget.validator, 
            maxLines: widget.multiline ? null : 1,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300),
            keyboardType:
                widget.isNumber ? TextInputType.phone : TextInputType.text,
            cursorColor: primaryColor,
            focusNode: _textFieldFocusNode,
            controller: widget.textEditingController,
            onChanged: (value) {
              // setState(() {
              //   _errorText = widget.validator(value);
              // });
            },
            decoration: InputDecoration(
              icon: widget.icon != null ? Icon(widget.icon, color: textFieldGrayColor, size: (2.5).h) : null,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              border: InputBorder.none,
              
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
