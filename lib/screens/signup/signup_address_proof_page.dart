import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/screens/signup/widgets/signup_address_proof_widgets.dart';
import 'package:flutter/material.dart';

class SignupAddressProofPage extends StatelessWidget {
  const SignupAddressProofPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupAddressProofWidgets = SignupAddressProofWidgets();
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets.buildProgressbar(),
                  signupAddressProofWidgets.sizedBoxheight(6),
                  signupAddressProofWidgets.buildHeaderTextAndSkipButton(),
                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets.buildPanTextAndTextField(),
                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets
                      .buildAadhaarCardFrontTextAndTextField(),

                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets
                      .buildAadharCardBackTextAndTextField(),
                  signupAddressProofWidgets.buildspacer(),
                  signupAddressProofWidgets.buildSubmitButton(),
                  signupAddressProofWidgets.sizedBoxheight(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
