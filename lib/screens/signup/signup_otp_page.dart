import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/auth/auth_state.dart';
import 'package:fleet_wise/screens/signup/signup_name_page.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';
import 'package:fleet_wise/screens/signup/widgets/signup_otp_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupOtpPage extends StatelessWidget {
  final String phoneNumber;
  final String requestId;
  const SignupOtpPage({
    super.key,
    required this.phoneNumber,
    required this.requestId,
  });

  @override
  Widget build(BuildContext context) {
    final signupOtpWidgets = SignupOtpWidgets();
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthVerified) {
              if (state.authData.exists) {
                CustomNavigation.push(context, SignupNamePage());
              } else {
                CustomNavigation.push(context, SignupPhoneNo());
              }
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
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
                signupOtpWidgets.buildOtpfield(
                  context: context,
                  phoneNumber: phoneNumber,
                  requestId: requestId,
                ),
                signupOtpWidgets.buildExpandedSpacer(height: 50),
                signupOtpWidgets.buildChangemobileNumber(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
