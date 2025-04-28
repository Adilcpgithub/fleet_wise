import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/toast_message_custom.dart';
import 'package:fleet_wise/providers/name_update_cubit/name_update_cubit.dart';
import 'package:fleet_wise/providers/name_update_cubit/name_update_state.dart';
import 'package:fleet_wise/screens/signup/signup_address_proof_page.dart';
import 'package:fleet_wise/screens/signup/widgets/signup_name_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupNamePage extends StatefulWidget {
  const SignupNamePage({super.key});

  @override
  State<SignupNamePage> createState() => _SignupNamePageState();
}

class _SignupNamePageState extends State<SignupNamePage> {
  final TextEditingController nameController = TextEditingController();
  final signupNameWidgets = SignupNameWidgets();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: SafeArea(
        child: BlocListener<NameUpdateCubit, NameUpdateState>(
          listener: (context, state) {
            if (state is NameUpdateSuccess) {
              customToastMessage(
                "Name updated successfully",
                AppColors.white,
                AppColors.black,
              );
              CustomNavigation.push(
                context,
                SignupAddressProofPage(name: nameController.text),
              );
            } else if (state is NameUpdateError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Error: ${state.error}")));
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  signupNameWidgets.buildSizedBoxHight(20),
                  signupNameWidgets.buildHeaderAndProfileImage(),
                  signupNameWidgets.buildSizedBoxHight(60),
                  signupNameWidgets.buildNameTextAndNameField(
                    nameController: nameController,
                    formKey: formKey,
                  ),

                  signupNameWidgets.buildSpacer(),
                  signupNameWidgets.buildSubmitButton(
                    context: context,
                    nameController: nameController,
                    formKey: formKey,
                  ),
                  signupNameWidgets.buildSizedBoxHight(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
