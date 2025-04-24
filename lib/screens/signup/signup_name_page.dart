import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/screens/signup/widgets/signup_name_widgets.dart';
import 'package:flutter/material.dart';

class SignupNamePage extends StatelessWidget {
  const SignupNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupNameWidgets = SignupNameWidgets();
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                signupNameWidgets.buildHeaderAndProfileImage(),
                signupNameWidgets.buildSizedBoxHight(60),
                signupNameWidgets.buildNameTextAndNameField(),
                signupNameWidgets.buildSpacer(),
                signupNameWidgets.buildSubmitButton(),
                signupNameWidgets.buildSizedBoxHight(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
