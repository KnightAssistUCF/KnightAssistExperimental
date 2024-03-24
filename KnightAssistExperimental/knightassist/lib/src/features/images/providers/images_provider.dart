import 'package:knightassist/src/features/images/models/s3_bucket_image_model.codegen.dart';
import 'package:knightassist/src/features/images/repositories/images_repository.dart';

class ImagesProvider {
  final ImagesRepository _imagesRepository;

  ImagesProvider(this._imagesRepository);

  Future<S3BucketImageModel> getImage({
    required String id,
    required int type,
  }) async {
    final queryParams = <String, Object>{
      'id': id,
      'typeOfImage': type,
    };
    return await _imagesRepository.fetch(queryParameters: queryParams);
  }

  // TODO: Add file handling to store image
  Future<String> storeImage({
    required String id,
  }) async {
    final data = <String, Object>{
      'id': id,
    };
    return await _imagesRepository.store(data: data);
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
