import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/signup_otp_widgets.dart';
import 'package:flutter/material.dart';

class SignupOtpPage extends StatelessWidget {
  const SignupOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupOtpWidgets = SignupOtpWidgets();
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
                children: [signupOtpWidgets.buildOtpVerificationHeader()],
              ),
              signupOtpWidgets.buildExpandedSpacer(height: 40),
              signupOtpWidgets.buildOtpfield(),
              signupOtpWidgets.buildExpandedSpacer(height: 50),
              signupOtpWidgets.buildChangemobileNumber(),
            ],
          ),
        ),
      ),
    );
  }
}
