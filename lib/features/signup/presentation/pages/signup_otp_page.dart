import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/custom_rich_text.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/opt_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupOtpPage extends StatelessWidget {
  const SignupOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //!  Verify number text and otp sent to number
                  Padding(
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
                                style: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontSize: 14,
                                ),
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

                            Image.asset(
                              'assets/locker_image.png',
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox(height: 40)),
              //! Otp text field , Timer text and Resend text
              Column(
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
              ),

              Expanded(child: const SizedBox(height: 50)),
              Padding(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
