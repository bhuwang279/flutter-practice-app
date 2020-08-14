import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/graphql_conf.dart';
import 'core/network/network_info.dart';
import 'core/utils/validators.dart';
import 'features/login/data/datasources/login_local_data_scource.dart';
import 'features/login/data/datasources/login_remote_data_source.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/get_mobile_number_and_token.dart';
import 'features/login/presentation/bloc/login_bloc.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //! Features - Login
  // Bloc

  sl.registerFactory(
      () => LoginBloc(getMobileNumberAndToken: sl(), validator: sl()));

  // Usecases

  sl.registerLazySingleton(() => GetMobileNumberAndToken(sl()));

  // Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
      remoteDataSource: sl(), localDataScource: sl(), networkInfo: sl()));

  // Data Sources

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LoginLocalDataScource>(
      () => LoginLocalDataScourceImpl(sharedPreferences: sl()));
  //! Core
  sl.registerLazySingleton(() => Validator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => CustomGraphQLClient());
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
