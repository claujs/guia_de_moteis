import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/guia_de_moteis_response.dart';

abstract class GuiaDeMoteisRepository {
  Future<Either<Failure, GuiasDeMoteisResponse>> getGuiasDeMoteis();
}
