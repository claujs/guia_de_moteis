import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/error/exception.dart';
import 'package:guia_moteis/core/error/failures.dart';
import 'package:guia_moteis/data/datasources/guia_de_moteis_remote_datasource.dart';
import 'package:guia_moteis/data/models/guias_de_moteis_response_model.dart';
import 'package:guia_moteis/data/repositories/guia_de_moteis_repository_impl.dart';

// Fake para simular sucesso no datasource
class FakeRemoteDatasourceSuccess implements GuiaDeMoteisRemoteDataSource {
  @override
  Future<GuiasDeMoteisResponseModel> getGuiasDeMoteis() async {
    // ...crie um JSON válido conforme seu modelo...
    return GuiasDeMoteisResponseModel.fromJson({"key": "value"});
  }
}

class FakeRemoteDatasourceFailure implements GuiaDeMoteisRemoteDataSource {
  @override
  Future<GuiasDeMoteisResponseModel> getGuiasDeMoteis() async {
    throw ServerException(message: "Fake error");
  }
}

void main() {
  group("GuiaDeMoteisRepositoryImpl", () {
    test(
        "Retorna Right(GuiasDeMoteisResponseModel) quando o remote datasource tem sucesso",
        () async {
      final datasource = FakeRemoteDatasourceSuccess();
      final repository =
          GuiaDeMoteisRepositoryImpl(remoteDataSource: datasource);

      final result = await repository.getGuiasDeMoteis();
      expect(result.isRight(), true);
      result.fold(
        (_) {},
        (model) {
          expect(model, isA<GuiasDeMoteisResponseModel>());
        },
      );
    });

    test(
        "Retorna Left(ServerFailure) quando o remote datasource lança ServerException",
        () async {
      final datasource = FakeRemoteDatasourceFailure();
      final repository =
          GuiaDeMoteisRepositoryImpl(remoteDataSource: datasource);

      final result = await repository.getGuiasDeMoteis();
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
        },
        (_) => fail("Deveria ter retornado uma falha"),
      );
    });
  });
}
