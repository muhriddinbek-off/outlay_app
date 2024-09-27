import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlay/common/base/base_page.dart';
import 'package:outlay/common/colors/app_colors.dart';
import 'package:outlay/common/extensions/text_extensions.dart';
import 'package:outlay/features/start/splash/cubit/splash_cubit.dart';
import 'package:outlay/features/start/splash/cubit/splash_state.dart';
import 'package:outlay/gen/assets.gen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage
    extends BasePage<SplashCubit, SplashBuildable, SplashListenable> {
  const SplashPage({super.key});

  @override
  void listener(BuildContext context, SplashListenable state) {
    switch (state.effect) {
      case SplashEffect.onBoarding:
        // context.router.replace(OnBoardingRoute());
        break;
      case SplashEffect.login:
      // context.router.replace(LoginRoute());
      case SplashEffect.home:
      // context.router.replace(HomeRoute());
      case null:
        break;
    }
  }

  @override
  Widget builder(BuildContext context, SplashBuildable state) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.icons.splash.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: 'OUTLAY'.s(54.sp).c(AppColors.white),
        ),
      ),
    );
  }
}
