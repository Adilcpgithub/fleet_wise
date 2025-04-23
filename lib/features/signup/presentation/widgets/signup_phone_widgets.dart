import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignupPhoneWidgets {
  // ! Top side image
  Widget topSideImage() {
    return Align(
      alignment: Alignment.topRight,
      child: SvgPicture.asset('assets/vector.svg', width: 444, height: 164),
    );
  }

  //! // ! Main login form section (logo, phone field, terms, button)
  Widget buildLoginSection(TextEditingController phoneController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        //! App Name with logo
        Image.asset('assets/CompanyName.png', height: 160),
        // ! Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login or register',
              style: TextStyle(color: AppColors.grey),
            ),
          ),
        ),
        //! Phone number input field
        CustomPhoneField(
          controller: phoneController,
          prefixIcon: Text(
            '+91',
            style: const TextStyle(color: AppColors.grey, fontSize: 16),
          ),
        ),

        //! Space between textfield and button
        const SizedBox(height: 50),

        //! Terms and condition text
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            children: [
              const TextSpan(text: 'by continuing, you agree to our\n'),

              TextSpan(
                text: 'Terms of Use',
                style: const TextStyle(
                  decoration: TextDecoration.underline,

                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const TextSpan(text: ' and '),

              TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(
                  decoration: TextDecoration.underline,

                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        //! Space between terms and condition  Opt button
        const SizedBox(height: 30),
        //! Get Otp Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),

          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.stroke,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Get OTP',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // ! Bottom spacing
        const SizedBox(height: 20),
      ],
    );
  }
}
