import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' as httpParser;

class ImageService {
  String apikey = 'b08646ce96a8c07288745a78964024d5';
  String baseUrl = 'https://api.imgbb.com/1/upload?key=';
  Future<String> uploadImage(File base) async {
    Uri url = Uri.parse("${baseUrl}${apikey}");

    Dio dioObj = new Dio();

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(base.path,
          filename: base.path.split('/').last,
          contentType: httpParser.MediaType('image', '*')),
      'type': 'image/*'
    });

    Response response = await dioObj.post(
      url.toString(),
      data: formData,
      options: Options(headers: {"Content-type": "image/*"}),
    );
    return response.data['data']['url'];
    return "";
  }

  getImage() {}
}
