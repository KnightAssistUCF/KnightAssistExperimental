import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';

part 's3_bucket_image_model.codegen.freezed.dart';
part 's3_bucket_image_model.codegen.g.dart';

@freezed
class S3BucketImageModel with _$S3BucketImageModel {
  const factory S3BucketImageModel({
    required String type,
    required String url,
    required String imageName,
  }) = _S3BucketImageModel;

  factory S3BucketImageModel.fromJson(JSON json) =>
      _$S3BucketImageModelFromJson(json);
}
