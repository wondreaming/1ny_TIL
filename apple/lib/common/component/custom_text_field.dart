import 'package:apple/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool obscureText;
  final String? hintText;
  const CustomTextField(
      {super.key,
      required this.onChanged,
      this.autofocus = false,
      this.obscureText = false,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    const baseborder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );
    return TextField(
      onChanged: onChanged,
      autofocus: autofocus,
      obscureText: obscureText,
      cursorColor: PRIMARY_COLOR,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        hintText: hintText,
        hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 13.0),
        filled: true,
        fillColor: INPUT_BG_COLOR,
        border: baseborder,
        enabledBorder: baseborder,
        focusedBorder: baseborder.copyWith(
          borderSide: baseborder.borderSide.copyWith(color: PRIMARY_COLOR)
        )
      ),
    );
  }
}
