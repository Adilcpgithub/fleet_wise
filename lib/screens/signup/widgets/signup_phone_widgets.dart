import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:fleet_wise/core/widgets/toast_message_custom.dart';
import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/auth/auth_event.dart';
import 'package:fleet_wise/providers/auth/auth_state.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget buildOtpVefiySection({
    required TextEditingController phoneController,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //! App Name with logo
          Stack(
            children: [
              Positioned(
                left: 15,
                top: 60,
                child: Image.asset('assets/untitledDesign.png', height: 55),
              ),
              SvgPicture.asset('assets/companyName.svg', height: 180),
            ],
          ),
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
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '+91',
                  style: const TextStyle(color: AppColors.grey, fontSize: 16),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Phone number must be 10 digits';
                }
                return null; // ✅ Valid
              },
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
                TextSpan(
                  text: AppLocalizations.of(context)!.termsAgreementIntro,
                ),

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
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              bool isLoading = false;
              if (state is AuthLoading) {
                isLoading = true;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: customButton(
                  text: 'Get OTP',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        SendOtpEvent(phoneNumber: phoneController.text),
                      );
                    } else {
                      customToastMessage(
                        "Please enter a valid phone number",
                        AppColors.white,
                        AppColors.black,
                      );
                    }
                  },
                  buttonColor: AppColors.stroke,
                  textColor: Colors.grey,
                  circleAvatar:
                      isLoading
                          ? const CircularProgressIndicator(
                            color: AppColors.grey,
                          )
                          : null,
                ),
              );
            },
          ),
          // ! Bottom spacing
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  //! build space between widgets
  buildSpacer() {
    return const Spacer();
  }
}
