import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exception.dart';
import '../../domain/entities/guia_de_moteis_response.dart';
import '../../domain/repositories/guia_de_moteis_repository.dart';
import '../datasources/guia_de_moteis_remote_datasource.dart';

class GuiaDeMoteisRepositoryImpl implements GuiaDeMoteisRepository {
  final GuiaDeMoteisRemoteDataSource remoteDataSource;

  GuiaDeMoteisRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GuiasDeMoteisResponse>> getGuiasDeMoteis() async {
    try {
      final result = await remoteDataSource.getGuiasDeMoteis();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
