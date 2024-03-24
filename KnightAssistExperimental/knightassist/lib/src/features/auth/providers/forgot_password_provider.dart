import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/core/core.dart';

import '../../../global/states/forgot_password_state.codegen.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordProvider extends StateNotifier<ForgotPasswordState> {
  final _otpDigits = ['0', '0', '0', '0'];
  final AuthRepository _authRepository;
  String? _email;

  ForgotPasswordProvider({
    required AuthRepository authRepository,
    required ForgotPasswordState initialState,
  })  : _authRepository = authRepository,
        super(initialState);

  String get _otpCode => _otpDigits.fold('', (otp, digit) => '$otp$digit');

  void setOtpDigit(int i, String digit) {
    _otpDigits[i] = digit;
  }

  Future<void> requestOtpCode(String email) async {
    final lastState = state;
    state = const ForgotPasswordState.loading(loading: 'Verifying user email');
    try {
      final data = {'email': email};
      final result = await _authRepository.forgotPassword(data: data);
      _email = email;
      state = ForgotPasswordState.otp(otpSentMessage: result);
    } on CustomException catch (e) {
      state = ForgotPasswordState.failed(
        reason: e.message,
        lastState: lastState,
      );
    }
  }

  void retryForgotPassword(ForgotPasswordState lastState) {
    state = lastState;
  }
}
