import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  TextInputType? keyboardType;
  final bool readOnly;
  final String? Function(String?)? validator;
  CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      cursorColor: AppColors.lightGrey,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
