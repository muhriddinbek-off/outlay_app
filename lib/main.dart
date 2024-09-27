import 'package:outlay/common/colors/app_theme.dart';
import 'package:outlay/common/di/injection.dart';
import 'package:outlay/common/router/app_router.dart';
import 'package:outlay/common/widgets/display/display_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('uz', 'UZ'),
        Locale('en', 'EN'),
      ],
      path: 'assets/locales',
      fallbackLocale: const Locale('uz', 'UZ'),
      startLocale: const Locale('uz', 'UZ'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appThemeDark = AppTheme(mode: ThemeMode.dark);
    final appThemeLight = AppTheme(mode: ThemeMode.light);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return DisplayWidget(
          child: MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Bookimed',
            routerConfig: getIt<AppRouter>().config(),
            theme: appThemeLight.lightTheme,
            darkTheme: appThemeDark.darkTheme,
          ),
        );
      },
    );
  }
}
