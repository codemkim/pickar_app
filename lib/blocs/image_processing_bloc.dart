import 'package:pickar_app/resources/repositories.dart';

class ImageProcessingBloc {
  final _imageProcessingRepository = ImageProcessingRepository();

  Future<String> getImageCaption(String data) async {
    return await _imageProcessingRepository.getImageCaption(data);
  } 

  Future<String> createConversionImage(dynamic data) async {
    return await _imageProcessingRepository.createConversionImage(data);
  } 

  dispose() {}
}

final imageProcessingBloc = ImageProcessingBloc();