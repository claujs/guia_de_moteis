import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/guia_de_moteis_remote_datasource.dart';
import '../../data/repositories/guia_de_moteis_repository_impl.dart';
import '../../domain/repositories/guia_de_moteis_repository.dart';
import '../../domain/usecases/get_guia_de_moteis.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Data Source
  getIt.registerLazySingleton<GuiaDeMoteisRemoteDataSource>(
    () => GuiaDeMoteisRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<GuiaDeMoteisRepository>(
    () => GuiaDeMoteisRepositoryImpl(
      remoteDataSource: getIt<GuiaDeMoteisRemoteDataSource>(),
    ),
  );

  // UseCase
  getIt.registerLazySingleton<GetGuiasDeMoteis>(
    () => GetGuiasDeMoteis(getIt<GuiaDeMoteisRepository>()),
  );
}
