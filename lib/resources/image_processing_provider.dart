import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ImageProcessingProvider {

  Dio dio = Dio();
  String openAiKey = dotenv.env['OPENAI_API_KEY'] ?? "Default_Value";

  Future<String> getImageCaption(String imagePath) async {

    String base64Image = base64Encode(await File(imagePath).readAsBytes());

    print(openAiKey);

    Map<String, dynamic> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $openAiKey"
    };

    // OpenAI API 요청 본문
    Map<String, dynamic> payload = {
      "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "Excluding the background part of the image, it focuses on the shape of the animal, and the result is made into a json with two shapes: the type of animal and the description of the animal",
            },
            {
              "type": "image_url",
              "image_url": {
                "url": "data:image/jpeg;base64,$base64Image"
              }
            }
          ]
        }
      ],
      "max_tokens": 300
    };

    try {
      final response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        data: jsonEncode(payload),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data["choices"][0]["message"]["content"];
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      print("Error calling OpenAI: $e");
      return "Internal Server Error";
    }
  }

  createConversionImage(data) {}

}
