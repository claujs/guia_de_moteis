import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:guia_moteis/core/error/failures.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis_response.dart';
import 'package:guia_moteis/domain/repositories/guia_de_moteis_repository.dart';
import 'package:guia_moteis/domain/usecases/get_guia_de_moteis.dart';

class MockGuiaDeMoteisRepository implements GuiaDeMoteisRepository {
  bool shouldFail = false;

  @override
  Future<Either<Failure, GuiasDeMoteisResponse>> getGuiasDeMoteis() async {
    if (shouldFail) {
      return Left(ServerFailure());
    }

    final fakeResponse = GuiasDeMoteisResponse(
      guias: [
        GuiaDeMoteis(
          logo: "test_logo.png",
          bairro: "Bairro 1",
          distancia: 1.5,
          fantasia: "Fantasia 1",
          qtdFavoritos: 0,
          media: 4.5,
          qtdAvaliacoes: 10,
        )
      ],
    );
    return Right(fakeResponse);
  }
}

void main() {
  group("GetGuiasDeMoteis UseCase", () {
    late GetGuiasDeMoteis usecase;
    late MockGuiaDeMoteisRepository mockRepository;

    setUp(() {
      mockRepository = MockGuiaDeMoteisRepository();
      usecase = GetGuiasDeMoteis(mockRepository);
    });

    test("deve retornar sucesso quando o repositório retornar dados válidos",
        () async {
      final result = await usecase();

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Não deveria retornar falha'),
        (response) {
          expect(response.guias, isNotEmpty);
          expect(response.guias.first.fantasia, equals("Fantasia 1"));
          expect(response.guias.first.logo, equals("test_logo.png"));
          expect(response.guias.first.distancia, equals(1.5));
        },
      );
    });

    test("deve retornar ServerFailure quando o repositório falhar", () async {
      mockRepository.shouldFail = true;

      final result = await usecase();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (response) => fail('Não deveria retornar sucesso'),
      );
    });
  });
}
