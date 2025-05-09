import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required VoidCallback onPressed,
  required Color buttonColor,
  required Color textColor,
  Widget? circleAvatar,
}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child:
          circleAvatar ??
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
  );
}
