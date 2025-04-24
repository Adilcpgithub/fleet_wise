import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPhoneWidgets {
  // ! Top side image
  Widget buildTopSideImage() {
    return Align(
      alignment: Alignment.topRight,
      child: SvgPicture.asset('assets/vector.svg', width: 444, height: 164),
    );
  }

  //! // ! Main login form section (logo, phone field, terms, button)
  Widget buildLoginSection(
    TextEditingController phoneController,
    BuildContext context,
  ) {
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
              AppLocalizations.of(context)!.loginTitle,
              style: TextStyle(color: AppColors.grey),
            ),
          ),
        ),
        //! Phone number input field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextFormField(
            controller: phoneController,
            prefixIcon: Text(
              '+91',
              style: const TextStyle(color: AppColors.grey, fontSize: 16),
            ),
            keyboardType: TextInputType.phone,
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
              TextSpan(text: AppLocalizations.of(context)!.termsAgreementIntro),

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: customButton(
            text: 'Get OTP',
            onPressed: () {},
            buttonColor: AppColors.stroke,
            textColor: Colors.grey,
          ),
        ),
        // ! Bottom spacing
        const SizedBox(height: 20),
      ],
    );
  }

  //! build space between widgets
  buildSpacer() {
    return const Spacer();
  }
}
