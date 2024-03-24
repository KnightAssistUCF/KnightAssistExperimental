import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_state.codegen.freezed.dart';

@freezed
class EditState with _$EditState {
  const factory EditState.unprocessed() = UNPROCESSED;

  const factory EditState.processing() = PROCESSING;

  const factory EditState.successful() = SUCCESSFUL;

  const factory EditState.failed({required String reason}) = FAILED;
}
