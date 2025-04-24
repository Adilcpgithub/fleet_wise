import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/features/signup/presentation/widgets/signup_phone_no_widgets.dart';
import 'package:flutter/material.dart';

class SignupPhoneNo extends StatelessWidget {
  const SignupPhoneNo({super.key});
  @override
  Widget build(BuildContext context) {
    SignupPhoneWidgets signupPhoneWidgets = SignupPhoneWidgets();
    final TextEditingController phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 50,
            ),

            child: IntrinsicHeight(
              child: Column(
                children: [
                  signupPhoneWidgets.topSideImage(),
                  const Spacer(),
                  signupPhoneWidgets.buildLoginSection(
                    phoneController,
                    context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
