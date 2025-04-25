import 'dart:developer';

import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/auth/auth_state.dart';
import 'package:fleet_wise/screens/signup/signup_otp_page.dart';
import 'package:fleet_wise/screens/signup/widgets/signup_phone_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPhoneNo extends StatelessWidget {
  const SignupPhoneNo({super.key});
  @override
  Widget build(BuildContext context) {
    final signupPhoneWidgets = SignupPhoneWidgets();
    final TextEditingController phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is OtpSent) {
                log(state.requestId.toString());
                CustomNavigation.push(
                  context,
                  SignupOtpPage(
                    phoneNumber: phoneController.text,
                    requestId: state.requestId,
                  ),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 50,
              ),

              child: IntrinsicHeight(
                child: Column(
                  children: [
                    signupPhoneWidgets.buildTopSideImage(),
                    signupPhoneWidgets.buildSpacer(),
                    signupPhoneWidgets.buildOtpVefiySection(
                      phoneController,
                      context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
