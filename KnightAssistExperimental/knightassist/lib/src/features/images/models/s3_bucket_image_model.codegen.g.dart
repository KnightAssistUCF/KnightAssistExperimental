// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_bucket_image_model.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$S3BucketImageModelImpl _$$S3BucketImageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$S3BucketImageModelImpl(
      type: json['type'] as String,
      url: json['url'] as String,
      imageName: json['imageName'] as String,
    );

Map<String, dynamic> _$$S3BucketImageModelImplToJson(
        _$S3BucketImageModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'imageName': instance.imageName,
    };
