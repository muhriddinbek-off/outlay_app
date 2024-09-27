import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashBuildable with _$SplashBuildable {
  const factory SplashBuildable({
    @Default(false) bool onBoarded,
  }) = _SplashBuildable;
}

@freezed
class SplashListenable with _$SplashListenable {
  const factory SplashListenable({SplashEffect? effect}) = _SplashListenable;
}

enum SplashEffect { home, login, onBoarding }
