import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/model/request/auth_request.dart';
import 'package:whatisthis/repository/auth_repository.dart';
import 'package:whatisthis/state/auth_state.dart';

final signupViewModelProvider =
    StateNotifierProvider<SignupViewModel, AuthState>((ref) {
  return SignupViewModel(ref.watch(authRepositoryProvider));
});

class SignupViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  SignupViewModel(this._repository) : super(AuthInitial());

  Future<void> signUp(String email, String password, String userName) async {
    state = AuthLoading();
    try {
      final request = SignUpRequest(
        email: email,
        password: password,
        userName: userName,
      );
      final response = await _repository.signUp(request);
      if (response.success) {
        state = AuthSuccess();
      } else {
        state = AuthError(response.error ?? '회원가입 실패');
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
