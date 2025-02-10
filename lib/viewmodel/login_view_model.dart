import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/model/request/auth_request.dart';
import 'package:whatisthis/repository/auth_repository.dart';
import 'package:whatisthis/state/auth_state.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AuthState>((ref) {
  return LoginViewModel(ref.watch(authRepositoryProvider));
});

class LoginViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  LoginViewModel(this._repository) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    state = AuthLoading();
    try {
      final request = SignInRequest(email: email, password: password);
      final response = await _repository.signIn(request);
      if (response.success) {
        state = AuthSuccess();
      } else {
        state = AuthError(response.error ?? '로그인 실패');
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
