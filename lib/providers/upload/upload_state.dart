import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  final Map<String, bool> uploadedDocs;
  final String? currentlyUploading;
  const UploadState({this.uploadedDocs = const {}, this.currentlyUploading});
}

class UploadInitial extends UploadState {
  @override
  List<Object> get props => [];
}

class UploadLoading extends UploadState {
  const UploadLoading({super.uploadedDocs, super.currentlyUploading});

  @override
  List<Object?> get props => [super.uploadedDocs, super.currentlyUploading];
}

class UploadSuccess extends UploadState {
  const UploadSuccess({required super.uploadedDocs});

  @override
  List<Object?> get props => [super.uploadedDocs];
}

class UploadFailure extends UploadState {
  final String message;

  const UploadFailure(this.message, {super.uploadedDocs});

  @override
  List<Object> get props => [message, super.uploadedDocs];
}
