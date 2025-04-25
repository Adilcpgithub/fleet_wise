import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/core/widgets/custom_textform.dart';
import 'package:fleet_wise/core/widgets/toast_message_custom.dart';
import 'package:fleet_wise/providers/upload/upload_bloc.dart';
import 'package:fleet_wise/providers/upload/upload_event.dart';
import 'package:fleet_wise/providers/upload/upload_state.dart';
import 'package:fleet_wise/screens/home/home_page.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_button.dart';
import 'package:fleet_wise/screens/signup/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupAddressProofWidgets {
  // ! progress bar
  Widget buildProgressbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),

      child: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          double progress = (state.uploadedDocs.length * 0.3333);
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: AppColors.grey,
              minHeight: 6,
            ),
          );
        },
      ),
    );
  }

  // ! Header Text and Skip Button
  Widget buildHeaderTextAndSkipButton(String name, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Identity & Address proof of owner',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '$name Ji, get started with document upload!',
                style: TextStyle(color: AppColors.lightGrey, fontSize: 14),
              ),
            ],
          ),
        ),
        // ! Skip Button
        Container(
          height: 38,
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey, width: 0.1),
            borderRadius: BorderRadius.circular(25.0),
            color: AppColors.baseColor,
          ),
          child: TextButton(
            onPressed: () {
              CustomNavigation.pushAndRemoveUntil(context, HomePage());
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: AppColors.lightGrey),
            ),
          ),
        ),
      ],
    );
  }

  //! Pan Card Text And TextField
  buildPanTextAndTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: customRichText('PAN Card'),
        ),
        CustomTextFormField(
          readOnly: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            child: GestureDetector(
              onTap: () {
                context.read<UploadBloc>().add(
                  UploadDocumentEvent(attribute: 'pan_card'),
                );
              },
              child: BlocBuilder<UploadBloc, UploadState>(
                builder: (context, state) {
                  final isUploaded = state.uploadedDocs['pan_card'] ?? false;
                  final bool isLoading =
                      state is UploadLoading &&
                      state.currentlyUploading == 'pan_card';
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.stroke),
                    ),
                    height: 34,
                    width: 92,
                    child: Center(
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                isUploaded ? 'Uploaded' : 'Upload',
                                style: TextStyle(color: AppColors.black),
                              ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  //! Aadhaar Card Text And TextField
  Widget buildAadhaarCardFrontTextAndTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: customRichText('Aadhaar Card Front'),
        ),
        CustomTextFormField(
          readOnly: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            child: GestureDetector(
              onTap: () {
                context.read<UploadBloc>().add(
                  UploadDocumentEvent(attribute: 'aadhar_card'),
                );
              },
              child: BlocBuilder<UploadBloc, UploadState>(
                builder: (context, state) {
                  final isUploaded = state.uploadedDocs['aadhar_card'] ?? false;
                  final bool isLoading =
                      state is UploadLoading &&
                      state.currentlyUploading == 'aadhar_card';

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.stroke),
                    ),
                    height: 34,
                    width: 92,
                    child: Center(
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                isUploaded ? 'Uploaded' : 'Upload',
                                style: TextStyle(color: AppColors.black),
                              ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ! Aadhaar Card Back Text And TextField
  Widget buildAadharCardBackTextAndTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: customRichText('Aadhaar Card Back'),
        ),
        CustomTextFormField(
          readOnly: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            child: GestureDetector(
              onTap: () {
                context.read<UploadBloc>().add(
                  UploadDocumentEvent(attribute: 'aadhar_card_back'),
                );
              },
              child: BlocBuilder<UploadBloc, UploadState>(
                builder: (context, state) {
                  final isUploaded =
                      state.uploadedDocs['aadhar_card_back'] ?? false;
                  final bool isLoading =
                      state is UploadLoading &&
                      state.currentlyUploading == 'aadhar_card_back';
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.stroke),
                    ),
                    height: 34,
                    width: 92,
                    child: Center(
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                isUploaded ? 'Uploaded' : 'Upload',
                                style: TextStyle(color: AppColors.black),
                              ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  //! Submit Button
  Widget buildSubmitButton(BuildContext context) {
    return customButton(
      text: 'SUBMIT',
      onPressed: () {
        if (context.read<UploadBloc>().state.uploadedDocs.length == 3) {
          CustomNavigation.pushAndRemoveUntil(context, HomePage());
        } else {
          customToastMessage(
            "Please upload all documents",
            AppColors.white,
            AppColors.black,
          );
        }
      },
      buttonColor: AppColors.black,
      textColor: AppColors.white,
    );
  }

  //! SizedBox height
  Widget sizedBoxheight(double height) {
    return SizedBox(height: height);
  }

  //! Spacer
  Widget buildspacer() {
    return const Spacer();
  }
}
