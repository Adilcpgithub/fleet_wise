import 'dart:developer';

import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:fleet_wise/core/widgets/toast_message_custom.dart';
import 'package:fleet_wise/providers/name_update_cubit/name_update_cubit.dart';
import 'package:fleet_wise/providers/name_update_cubit/name_update_state.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_button.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupNameWidgets {
  //! header text and profile image
  Widget buildHeaderAndProfileImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'What shall we call you?',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  text: 'Enter full name as on your ',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Aadhar Card',
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

        // ! Right profile image
        Image.asset('assets/profile_image.png', height: 48, width: 48),
      ],
    );
  }

  // ! Full name text and Name field
  Widget buildNameTextAndNameField({
    required TextEditingController nameController,
    required GlobalKey<FormState> formKey,
  }) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customRichText('Your Full Name', '*'),
          CustomTextFormField(
            // formkey: formKey,
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              if (value.length < 3) {
                return 'Name must be at least 3 characters';
              }
              if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                return 'Name should only contain letters and spaces';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  //! Submit button
  buildSubmitButton({
    required BuildContext context,
    required TextEditingController nameController,
    required GlobalKey<FormState> formKey,
  }) {
    return BlocBuilder<NameUpdateCubit, NameUpdateState>(
      builder: (context, state) {
        bool isLoading = false;
        if (state is NameUpdateLoading) {
          isLoading = true;
        }

        return customButton(
          text: 'SUBMIT',
          onPressed: () async {
            final name = nameController.text.trim();
            log('your name is $name');

            if (formKey.currentState!.validate()) {
              if (name.isNotEmpty) {
                log('Name is not empty, saving...');
                context.read<NameUpdateCubit>().updateName(name);
              } else {
                log('Name is empty');
              }
            } else {
              log('Form validation failed.');
              customToastMessage(
                "Please enter a valid name",
                AppColors.white,
                AppColors.black,
              );
            }
          },
          buttonColor: AppColors.stroke,
          textColor: AppColors.grey,
          circleAvatar:
              isLoading
                  ? const CircularProgressIndicator(color: AppColors.grey)
                  : null,
        );
      },
    );
  }

  // ! Custom SizedBox for height
  buildSizedBoxHight(double height) {
    return SizedBox(height: height);
  }

  //! build space between widgets
  buildSpacer() {
    return const Spacer();
  }
}
