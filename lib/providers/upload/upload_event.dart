import 'package:equatable/equatable.dart';

abstract class UploadEvent extends Equatable {}

class UploadDocumentEvent extends UploadEvent {
  final String attribute;

  UploadDocumentEvent({required this.attribute});

  @override
  List<Object> get props => [attribute];
}
