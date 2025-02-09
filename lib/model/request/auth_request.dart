class SignUpRequest {
  final String email;
  final String password;
  final String userName;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.userName,
  });
}

class SignInRequest {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });
}
