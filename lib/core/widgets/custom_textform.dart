import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  Widget? prefixIcon;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  CustomPhoneField({
    super.key,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.lightGrey,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: prefixIcon,
          ),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}
/**
  Padding(
            padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColors.stroke),
              ),
              height: 34,
              width: 92,
              child: Center(
                child: Text('Upload', style: TextStyle(color: AppColors.black)),
              ),
            ),
          ),

**/