import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../db/app_database.dart';
import '../network/dio_factory.dart';
import '../../features/schedule/data/datasources/schedule_remote_data_source.dart';
import '../../features/schedule/data/repositories/schedule_repository_impl.dart';
import '../../features/schedule/domain/repositories/schedule_repository.dart';
import '../../features/schedule/presentation/cubit/schedule_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/results/data/datasources/results_remote_data_source.dart';
import '../../features/results/data/repositories/results_repository_impl.dart';
import '../../features/results/domain/repositories/results_repository.dart';
import '../../features/results/presentation/cubit/results_cubit.dart';
import '../../features/driver/presentation/cubit/driver_cubit.dart';
import '../../features/constructor/presentation/cubit/constructor_cubit.dart';
import '../../features/standings/data/datasources/standings_remote_data_source.dart';
import '../../features/standings/data/repositories/standings_repository_impl.dart';
import '../../features/standings/domain/repositories/standings_repository.dart';
import '../../features/standings/presentation/cubit/chart_cubit.dart';
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
    () => HomeCubit(
      getIt<ScheduleRepository>(),
      getIt<StandingsRepository>(),
    ),
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
  getIt.registerFactory<ChartCubit>(
    () => ChartCubit(
      getIt<StandingsRepository>(),
      getIt<ScheduleRepository>(),
    ),
  );

  // Results feature
  getIt.registerLazySingleton<ResultsRemoteDataSource>(
    () => ResultsRemoteDataSource(
      getIt<Dio>(instanceName: DioFactory.jolpicaName),
    ),
  );
  getIt.registerLazySingleton<ResultsRepository>(
    () => ResultsRepositoryImpl(
      getIt<ResultsRemoteDataSource>(),
      getIt<AppDatabase>(),
    ),
  );
  getIt.registerFactory<ResultsCubit>(
    () => ResultsCubit(getIt<ResultsRepository>()),
  );
  getIt.registerFactory<DriverCubit>(
    () => DriverCubit(
      getIt<StandingsRepository>(),
      getIt<ScheduleRepository>(),
      getIt<ResultsRepository>(),
    ),
  );
  getIt.registerFactory<ConstructorCubit>(
    () => ConstructorCubit(
      getIt<StandingsRepository>(),
      getIt<ScheduleRepository>(),
      getIt<ResultsRepository>(),
    ),
  );
}
