import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/custom_rich_text.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/opt_textformfield.dart';
import 'package:flutter/material.dart';

class SignupOtpWidgets {
  //!  Verify number text and otp sent to number
  Widget buildOtpVerificationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verify Number',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'OTP sent to ',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: '+91 93622 53463',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              //! Space between text and locker icon
              SizedBox(width: 10),

              Image.asset('assets/locker_image.png', height: 40, width: 40),
            ],
          ),
        ],
      ),
    );
  }

  //! Otp text field , Timer text and Resend text
  Widget buildOtpfield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: customRichText('Enter OTP'),
          ),
        ),
        OtpBoxFields(onCompleted: (p0) {}),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: customRichText('Resend in ', ' 00:46'),
          ),
        ),
      ],
    );
  }

  Widget buildChangemobileNumber() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Text(
        'Change your mobile Number',
        style: const TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildExpandedSpacer({double height = 40}) {
    return Expanded(child: SizedBox(height: height));
  }
}
