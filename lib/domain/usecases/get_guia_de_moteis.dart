import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/guia_de_moteis_response.dart';
import '../repositories/guia_de_moteis_repository.dart';

class GetGuiasDeMoteis {
  final GuiaDeMoteisRepository repository;

  GetGuiasDeMoteis(this.repository);

  Future<Either<Failure, GuiasDeMoteisResponse>> call() async {
    return await repository.getGuiasDeMoteis();
  }
}
