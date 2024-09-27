import 'package:outlay/data/auth_data/auth_api.dart';
import 'package:outlay/domain/auth/auth_repo.dart';
import 'package:outlay/domain/model/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepoImpl extends AuthRepository {
  final AuthApi _api;
  final Storage storage;

  AuthRepoImpl(
    this._api,
    this.storage,
  );

  @override
  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async {
    await _api.register(email: email, name: name, password: password);
  }

  @override
  Future<void> sentOtp({required String email}) async {
    await _api.sendOtp(email: email);
  }

  @override
  Future<void> verifyOtp(
      {required String email, required String otpText}) async {
    await _api.otpVerify(otpText: otpText, email: email);
  }

  @override
  Future<void> userLogin(
      {required String email, required String password}) async {
    final res = await _api.userLogin(email: email, password: password);

    await storage.token.set(res.data['data']['accessToken']);

    debugPrint('TOKEN: ${storage.token.call() ?? ''}');
  }


}
