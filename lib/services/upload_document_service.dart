import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UploadService {
  final String rootUrl =
      'https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test';

  Future<bool> uploadFile({
    required File file,
    required String attribute,
    required String accessToken,
  }) async {
    final uri = Uri.parse('$rootUrl/uploadFile');
    log('message: $uri');
    final request =
        http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = 'Bearer $accessToken'
          ..fields['attribute'] = attribute;
    log('message: $attribute');
    final mimeType =
        lookupMimeType(file.path)?.split('/') ??
        ['application', 'octet-stream'];

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      ),
    );
    log('message: ${file.path}');

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('File uploaded successfully: ${response.body}');
      return true;
    } else {
      log('File upload failed: ${response.statusCode}');
      return false;
    }
  }
}
