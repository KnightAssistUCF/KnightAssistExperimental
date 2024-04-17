import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/core/core.dart';
import 'package:knightassist/src/features/qr/providers/qr_provider.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';

import '../repositories/images_repository.dart';

final imageStateProvider = StateProvider<FutureState<String>>((ref) {
  return const FutureState.idle();
});

class ImagesProvider {
  final ImagesRepository _imagesRepository;
  final Ref _ref;

  ImagesProvider({
    required ImagesRepository imagesRepository,
    required Ref ref,
  })  : _imagesRepository = imagesRepository,
        _ref = ref,
        super();

  Future<String> retrieveImage({
    required String type,
    required String id,
  }) async {
    final queryParams = <String, Object>{
      'typeOfImage': type,
      'id': id,
    };
    return await _imagesRepository.fetch(queryParameters: queryParams);
  }

  Future<void> storeImage({
    required String type,
    required String id,
    required File file,
  }) async {
    final data = <String, Object>{
      'typeOfImage': type,
      'id': id,
      'file': await MultipartFile.fromFile(file.path),
    };
    final imageStateProv = _ref.read(qrStateProvider.notifier);
    imageStateProv.state = const FutureState.idle();

    await Future<void>.delayed(const Duration(milliseconds: 100)).then((_) {
      imageStateProv.state = const FutureState.loading();
    });

    try {
      final response = _imagesRepository.store(data: data);
      imageStateProv.state = FutureState.data(data: response);
    } on CustomException catch (e) {
      imageStateProv.state = FutureState.failed(reason: e.message);
    }
  }

  Future<String> deleteImage({
    required String type,
    required String id,
  }) async {
    final data = <String, Object>{
      'typeOfImage': type,
      'id': id,
    };
    return await _imagesRepository.delete(data: data);
  }
}
