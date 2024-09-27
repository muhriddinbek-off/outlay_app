import 'package:outlay/common/base/base_cubit.dart';
import 'package:outlay/domain/model/storage/storage.dart';
import 'package:outlay/domain/repo/start_repo.dart';
import 'package:outlay/features/start/splash/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashCubit extends BaseCubit<SplashBuildable, SplashListenable> {
  SplashCubit(this._repo, this.storage) : super(const SplashBuildable()) {
    getOnBoarded();
    nextInitialPage();
  }

  final Storage storage;

  final StartRepo _repo;

  void nextInitialPage() {
    debugPrint('TOKEN: ${storage.token.call() ?? ''}');
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final token = storage.token.call() ?? '';
        if (token.isEmpty) {
          if (buildable.onBoarded) {
            invoke(const SplashListenable(effect: SplashEffect.login));
          } else {
            invoke(const SplashListenable(effect: SplashEffect.onBoarding));
          }
        } else {
          invoke(const SplashListenable(effect: SplashEffect.home));
        }
      },
    );
  }

  void getOnBoarded() {
    final result = _repo.getOnboarded();
    build((buildable) => buildable.copyWith(onBoarded: result));
  }
}
