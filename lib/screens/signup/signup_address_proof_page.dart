import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/screens/signup/widgets/signup_address_proof_widgets.dart';
import 'package:flutter/material.dart';

class SignupAddressProofPage extends StatefulWidget {
  final String name;
  const SignupAddressProofPage({super.key, required this.name});

  @override
  State<SignupAddressProofPage> createState() => _SignupAddressProofPageState();
}

class _SignupAddressProofPageState extends State<SignupAddressProofPage> {
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
                  signupAddressProofWidgets.buildHeaderTextAndSkipButton(
                    widget.name,
                    context,
                  ),
                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets.buildPanTextAndTextField(context),
                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets
                      .buildAadhaarCardFrontTextAndTextField(context),

                  signupAddressProofWidgets.sizedBoxheight(20),
                  signupAddressProofWidgets.buildAadharCardBackTextAndTextField(
                    context,
                  ),
                  signupAddressProofWidgets.buildspacer(),
                  signupAddressProofWidgets.buildSubmitButton(context),
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
