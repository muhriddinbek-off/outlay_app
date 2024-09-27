import 'package:outlay/common/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<Response> register({
    required String email,
    required String name,
    required String password,
  }) {
    final body = {
      "email": email,
      "firstName": 'shaxzod',
      "lastName": "burhonov",
      "password": password,
      "prePassword": password
    };

    return _dio.post("/api/v1/auth/sign-up", data: body);
  }
  Future<Response> sendOtp({required String email}) {
    return _dio.post(
      '${Constants.apiEmailVerify}$email',
    );
  }
  Future<Response> otpVerify({
    required String otpText,
    required String email,
  }) {
    return _dio.post(
      Constants.apiOtpVerify,
      data: {
        "email": email,
        "otp": otpText,
      },
    );
  }
  Future<Response> userLogin(
      {required String email, required String password}) {
    return _dio.post(Constants.apiLogin, data: {
      "username": email,
      "password": password,
    });
  }
}

