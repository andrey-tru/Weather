import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.validator,
    this.maxLength,
    this.controller,
    this.labelText,
  });

  final String? Function(String?)? validator;
  final int? maxLength;
  final TextEditingController? controller;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ?? _emptyValidator,
      maxLength: maxLength,
      controller: controller,
      style: TextStyles.b1,
      cursorHeight: 15.0,
      cursorColor: AppColors.cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: AppColors.blue),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.stroke),
        ),
        labelText: labelText,
        labelStyle: TextStyles.b1.copyWith(color: AppColors.greyText),
      ),
    );
  }

  String? _emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return tr('validator.empty');
    }
    return null;
  }
}
