import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/custom_button.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';

class SignupNameWidgets {
  //! header text and profile image
  Widget buildHeaderAndProfileImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'What shall we call you?',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  text: 'Enter full name as on your ',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Aadhar Card',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ! Right profile image
        Image.asset('assets/profile_image.png', height: 48, width: 48),
      ],
    );
  }

  // ! Full name text and Name field
  Widget buildNameTextAndNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customRichText('Your Full Name', '*'),
        CustomTextFormField(
          controller: TextEditingController(),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
      ],
    );
  }

  //! Submit button
  buildSubmitButton() {
    return customButton(
      text: 'SUBMIT',
      onPressed: () {},
      buttonColor: AppColors.stroke,
      textColor: AppColors.grey,
    );
  }

  // ! Custom SizedBox for height
  buildSizedBoxHight(double height) {
    return SizedBox(height: height);
  }

  //! build space between widgets
  buildSpacer() {
    return const Spacer();
  }
}
