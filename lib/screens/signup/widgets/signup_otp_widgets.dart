import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/auth/auth_event.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_rich_text.dart';
import 'package:fleet_wise/screens/signup/widgets/opt_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupOtpWidgets {
  //!  Verify number text and otp sent to number
  Widget buildOtpVerificationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Verify number',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
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
              ],
            ),
          ),

          //! Right locker image
          Image.asset('assets/locker_image.png', height: 48, width: 48),
        ],
      ),
    );
  }

  //! Otp text field , Timer text and Resend text
  Widget buildOtpfield({
    required BuildContext context,
    required String phoneNumber,
    required String requestId,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: customRichText('Enter OTP'),
          ),
        ),
        //! Otp text fields
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: OtpBoxFields(
            onCompleted: (otp) {
              if (otp.length == 6) {
                context.read<AuthBloc>().add(
                  VerifyOtpEvent(
                    otp: otp,
                    phoneNumber: phoneNumber,
                    requestId: requestId,
                  ),
                );
              }
            },
          ),
        ),
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

  Widget buildChangemobileNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: GestureDetector(
        onTap: () => CustomNavigation.pushReplacement(context, SignupPhoneNo()),
        child: Text(
          'Change your mobile Number',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildExpandedSpacer({double height = 40}) {
    return Expanded(child: SizedBox(height: height));
  }
}
