import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatisthis/model/request/auth_request.dart';
import 'package:whatisthis/model/response/auth_response.dart';
import 'package:whatisthis/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Future<SignResponse> signUp(SignUpRequest request) async {
    try {
      final authResponse = await _supabaseClient.auth.signUp(
        email: request.email,
        password: request.password,
      );

      if (authResponse.user != null) {
        await _supabaseClient.from('users').insert({
          'user_id': authResponse.user!.id,
          'user_name': request.userName,
          'user_email': request.email,
          'user_password': request.password
        });

        return SignResponse.success(authResponse.user!.id);
      }
      return SignResponse.error('회원가입 실패');
    } catch (e) {
      return SignResponse.error(e.toString());
    }
  }

  @override
  Future<SignResponse> signIn(SignInRequest request) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: request.email,
        password: request.password,
      );

      if (response.user != null) {
        return SignResponse.success(response.user!.id);
      }
      return SignResponse.error('로그인 실패');
    } catch (e) {
      return SignResponse.error(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;
}
