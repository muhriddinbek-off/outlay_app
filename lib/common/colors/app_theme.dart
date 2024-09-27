import 'package:outlay/common/colors/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';

@immutable
final class AppTheme {
  /// {@macro app_theme}
  AppTheme({required this.mode})
      : darkTheme = ThemeData(
          brightness: Brightness.dark,
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),
        lightTheme = ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          fontFamily: "Urbanist",
          colorScheme: lightColorScheme,
          primaryColor: AppColors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(color: Colors.white),
          inputDecorationTheme: null,
        );

  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData lightTheme;

  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme &&
          runtimeType == other.runtimeType &&
          mode == other.mode;

  @override
  int get hashCode => mode.hashCode;
}
