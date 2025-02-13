import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/model/request/auth_request.dart';
import 'package:whatisthis/state/auth_state.dart';

part 'signup_view_model.g.dart';

@riverpod
class SignupViewModel extends AutoDisposeAsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    return AuthInitial();
  }

  Future<void> signUp(String email, String password, String userName) async {
    state = const AsyncValue.loading();
    try {
      final request = SignUpRequest(
        email: email,
        password: password,
        userName: userName,
      );
      final response = await ref.read(authRepositoryProvider).signUp(request);
      if (response.success) {
        state = AsyncValue.data(AuthSuccess());
      } else {
        state = AsyncValue.data(AuthError(response.error ?? '회원가입 실패'));
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
