import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_button.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';

class SignupAddressProofWidgets {
  // ! progress bar
  Widget buildProgressbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: 0.6,
          backgroundColor: Colors.grey[300],
          color: AppColors.grey,
          minHeight: 6,
        ),
      ),
    );
  }

  // ! Header Text and Skip Button
  Widget buildHeaderTextAndSkipButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Identity & Address proof of owner',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Raman Ji, get started with document upload!',
                style: TextStyle(color: AppColors.lightGrey, fontSize: 14),
              ),
            ],
          ),
        ),
        // ! Skip Button
        Container(
          height: 38,
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey, width: 0.5),
            borderRadius: BorderRadius.circular(25.0),
            color: AppColors.stroke,
          ),
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(color: AppColors.lightGrey),
            ),
          ),
        ),
      ],
    );
  }

  //! Pan Card Text And TextField
  buildPanTextAndTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: customRichText('PAN Card'),
        ),
        CustomTextFormField(
          readOnly: true,
          suffixIcon: Padding(
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
        ),
      ],
    );
  }

  //! Aadhaar Card Text And TextField
  Widget buildAadhaarCardFrontTextAndTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: customRichText('Aadhaar Card Front'),
        ),
        CustomTextFormField(
          readOnly: true,
          suffixIcon: Padding(
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
        ),
      ],
    );
  }

  // ! Aadhaar Card Back Text And TextField
  Widget buildAadharCardBackTextAndTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: customRichText('Aadhaar Card Back'),
        ),
        CustomTextFormField(
          readOnly: true,
          suffixIcon: Padding(
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
        ),
      ],
    );
  }

  //! Submit Button
  Widget buildSubmitButton() {
    return customButton(
      text: 'SUBMIT',
      onPressed: () {},
      buttonColor: AppColors.black,
      textColor: AppColors.white,
    );
  }

  //! SizedBox height
  Widget sizedBoxheight(double height) {
    return SizedBox(height: height);
  }

  //! Spacer
  Widget buildspacer() {
    return const Spacer();
  }
}
