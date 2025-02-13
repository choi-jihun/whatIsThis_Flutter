import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/model/request/auth_request.dart';
import 'package:whatisthis/state/auth_state.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends AutoDisposeAsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    return AuthInitial();
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final request = SignInRequest(email: email, password: password);
      final response = await ref.read(authRepositoryProvider).signIn(request);
      if (response.success) {
        state = AsyncValue.data(AuthSuccess());
      } else {
        state = AsyncValue.data(AuthError(response.error ?? '로그인 실패'));
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
