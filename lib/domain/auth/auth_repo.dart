abstract class AuthRepository {
  Future<void> register({
    required String email,
    required String name,
    required String password,
  });

  Future<void> sentOtp({
    required String email,
  });
  Future<void> verifyOtp({
    required String email,
    required String otpText,
  });
  Future<void> userLogin({
    required String email,
    required String password,
  });
}
