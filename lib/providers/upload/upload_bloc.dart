import 'dart:developer';
import 'dart:io';

import 'package:fleet_wise/core/utils/image_picker_helper.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:fleet_wise/services/upload_document_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'upload_event.dart';
import 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadService uploadService = UploadService();
  final SecureStorageService secureStorageService = SecureStorageService();

  UploadBloc() : super(UploadInitial()) {
    on<UploadDocumentEvent>(_onUploadFile);
  }
  // ! Uploading adhar , Pan ets
  Future<void> _onUploadFile(
    UploadDocumentEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(
      UploadLoading(
        uploadedDocs: state.uploadedDocs,
        currentlyUploading: event.attribute,
      ),
    );

    try {
      //!access token fetching
      String? accessToken = await secureStorageService.getAccessToken();

      //! image picking from gallery
      log('image uplaoding');
      File? imageFile = await pickImage();
      //! uploading image
      if (accessToken == null || accessToken.isEmpty) {
        emit(UploadFailure('Access token not found. Please verify again.'));
        return;
      }
      if (imageFile == null) {
        emit(UploadFailure('Image not found. Please try again.'));
        return;
      }
      log('image file path: ${imageFile.path}');
      final result = await uploadService.uploadFile(
        file: imageFile,
        attribute: event.attribute,
        accessToken: accessToken,
      );

      if (result) {
        log('success');
        final updatedMap = Map<String, bool>.from(state.uploadedDocs)
          ..[event.attribute] = true;
        emit(UploadSuccess(uploadedDocs: updatedMap));
      } else {
        log('failed');
        emit(UploadFailure('Failed to upload ${event.attribute}'));
      }
    } catch (e) {
      emit(UploadFailure('Error: $e', uploadedDocs: state.uploadedDocs));
    }
  }
}
