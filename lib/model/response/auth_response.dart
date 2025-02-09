class SignResponse {
  final String? userId;
  final String? error;
  final bool success;

  SignResponse({
    this.userId,
    this.error,
    this.success = false,
  });

  factory SignResponse.success(String userId) => SignResponse(
        userId: userId,
        success: true,
      );

  factory SignResponse.error(String error) => SignResponse(
        error: error,
        success: false,
      );
}
