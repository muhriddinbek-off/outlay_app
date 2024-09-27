import 'package:outlay/domain/model/storage/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends QueuedInterceptor {
  final Storage _storage;
  final LocaleProvider _localeProvider;

  AuthInterceptor(this._storage, this._localeProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final String? token = _storage.token.call();
    if (token != null) {
      options.headers.addAll({
        'Authorization': 'Bearer $token',
        "Accept-languae": _localeProvider.getLocale().languageCode,
      });
    }
    handler.next(options);
  }
}

@lazySingleton
class LocaleProvider {
  Locale _locale = const Locale('uz', 'UZ');

  Locale getLocale() => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
  }

  String getLanguageCode() {
    print("Changed also here: ${_locale.languageCode}");
    return _locale.languageCode;
  }
}
