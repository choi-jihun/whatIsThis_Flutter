import 'package:whatisthis/model/request/auth_request.dart';
import 'package:whatisthis/model/response/auth_response.dart';

abstract class AuthRepository {
  Future<SignResponse> signUp(SignUpRequest request);
  Future<SignResponse> signIn(SignInRequest request);
  Future<void> signOut();
}
