import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../db/app_database.dart';
import '../network/dio_factory.dart';
import '../../features/schedule/data/datasources/schedule_remote_data_source.dart';
import '../../features/schedule/data/repositories/schedule_repository_impl.dart';
import '../../features/schedule/domain/repositories/schedule_repository.dart';
import '../../features/schedule/presentation/cubit/schedule_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/standings/data/datasources/standings_remote_data_source.dart';
import '../../features/standings/data/repositories/standings_repository_impl.dart';
import '../../features/standings/domain/repositories/standings_repository.dart';
import '../../features/standings/presentation/cubit/standings_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<AppDatabase>()) return;

  // Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // HTTP clients (named — two Dio instances)
  final dioFactory = DioFactory();
  getIt.registerLazySingleton<Dio>(
    () => dioFactory.jolpica(),
    instanceName: DioFactory.jolpicaName,
  );
  getIt.registerLazySingleton<Dio>(
    () => dioFactory.openF1(),
    instanceName: DioFactory.openF1Name,
  );

  // Schedule feature
  getIt.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSource(
      getIt<Dio>(instanceName: DioFactory.jolpicaName),
    ),
  );
  getIt.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(
      remote: getIt<ScheduleRemoteDataSource>(),
      db: getIt<AppDatabase>(),
    ),
  );
  getIt.registerFactory<ScheduleCubit>(
    () => ScheduleCubit(getIt<ScheduleRepository>()),
  );

  // Home feature
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<ScheduleRepository>()),
  );

  // Standings feature
  getIt.registerLazySingleton<StandingsRemoteDataSource>(
    () => StandingsRemoteDataSource(
      getIt<Dio>(instanceName: DioFactory.jolpicaName),
    ),
  );
  getIt.registerLazySingleton<StandingsRepository>(
    () => StandingsRepositoryImpl(
      getIt<StandingsRemoteDataSource>(),
      getIt<AppDatabase>(),
    ),
  );
  getIt.registerFactory<StandingsCubit>(
    () => StandingsCubit(getIt<StandingsRepository>()),
  );
}
