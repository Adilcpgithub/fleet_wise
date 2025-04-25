import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();

  try {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null; // User canceled the picker
    }
  } catch (e) {
    throw Exception('Error picking image: $e');
  }
}
