import 'dart:io';

import '../repositories/images_repository.dart';

class ImagesProvider {
  final ImagesRepository _imagesRepository;

  ImagesProvider(this._imagesRepository);

  Future<String> retrieveImage({
    required int type,
    required String id,
  }) async {
    final queryParams = <String, Object>{
      'id': id,
      'typeOfImage': type,
    };
    return await _imagesRepository.fetch(queryParameters: queryParams);
  }

  Future<String> storeImage({
    required int type,
    required String id,
    required File file,
  }) async {
    final data = <String, Object>{
      'typeOfImage': type,
      'id': id,
    };
    return await _imagesRepository.store(data: data, file: file);
  }

  Future<String> deleteImage({
    required String id,
    required int type,
  }) async {
    final data = <String, Object>{
      'id': id,
      'typeOfImage': type,
    };
    return await _imagesRepository.delete(data: data);
  }
}
