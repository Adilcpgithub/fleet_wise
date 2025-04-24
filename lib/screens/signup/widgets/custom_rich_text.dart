import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget customRichText(String firsrText, [String? secondText]) {
  return Text.rich(
    TextSpan(
      text: firsrText,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: secondText ?? '*',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      ],
    ),
  );
}
