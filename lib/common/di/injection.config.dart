// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:outlay/common/di/app_module.dart' as _i43;
import 'package:outlay/common/di/network_module.dart' as _i516;
import 'package:outlay/common/widgets/display/display.dart' as _i277;
import 'package:outlay/common/widgets/display/display_impl.dart' as _i316;
import 'package:outlay/data/auth_data/auth_api.dart' as _i803;
import 'package:outlay/data/auth_data/auth_repo_impl.dart' as _i176;
import 'package:outlay/data/start_repo_impl.dart' as _i128;
import 'package:outlay/domain/auth/auth_repo.dart' as _i856;
import 'package:outlay/domain/model/auth_interceptor/auth_interceptor.dart'
    as _i770;
import 'package:outlay/domain/model/storage/storage.dart' as _i10;
import 'package:outlay/domain/repo/start_repo.dart' as _i48;
import 'package:outlay/features/start/splash/cubit/splash_cubit.dart' as _i714;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i974.Logger>(() => appModule.logger);
    gh.lazySingleton<_i770.LocaleProvider>(() => _i770.LocaleProvider());
    await gh.lazySingletonAsync<_i10.Storage>(
      () => _i10.Storage.create(),
      preResolve: true,
    );
    gh.singleton<_i277.Display>(() => _i316.DisplayImpl());
    gh.lazySingleton<_i770.AuthInterceptor>(() => _i770.AuthInterceptor(
          gh<_i10.Storage>(),
          gh<_i770.LocaleProvider>(),
        ));
    gh.factory<_i48.StartRepo>(() => _i128.StartRepoImpl(gh<_i10.Storage>()));
    gh.factory<_i714.SplashCubit>(() => _i714.SplashCubit(
          gh<_i48.StartRepo>(),
          gh<_i10.Storage>(),
        ));
    gh.factory<_i361.Dio>(() => networkModule.dio(gh<_i770.AuthInterceptor>()));
    gh.factory<_i803.AuthApi>(() => _i803.AuthApi(gh<_i361.Dio>()));
    gh.factory<_i856.AuthRepository>(() => _i176.AuthRepoImpl(
          gh<_i803.AuthApi>(),
          gh<_i10.Storage>(),
        ));
    return this;
  }
}

class _$AppModule extends _i43.AppModule {}

class _$NetworkModule extends _i516.NetworkModule {}
