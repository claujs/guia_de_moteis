import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/constants/app_strings.dart';
import 'package:guia_moteis/core/error/failures.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis_response.dart';
import 'package:guia_moteis/domain/usecases/get_guia_de_moteis.dart';
import 'package:guia_moteis/presentation/providers/guia_de_moteis_provider.dart';

// Fake para simular resposta de sucesso
class FakeSuccessUseCase implements GetGuiasDeMoteis {
  @override
  Future<Either<Failure, GuiasDeMoteisResponse>> call() async {
    // Simula uma resposta de sucesso; adapte conforme a implementação real
    final response = GuiasDeMoteisResponse(guias: [
      GuiaDeMoteis(
        logo: "test_logo.png",
        bairro: "Bairro 1",
        distancia: 1.5,
        fantasia: "Fantasia 1",
        qtdFavoritos: 0,
        media: 4.5,
        qtdAvaliacoes: 10,
      )
    ]);
    return Right(response);
  }

  @override
  get repository => throw UnimplementedError();
}

// Fake para simular resposta de erro
class FakeFailureUseCase implements GetGuiasDeMoteis {
  @override
  Future<Either<Failure, GuiasDeMoteisResponse>> call() async {
    return Left(ServerFailure());
  }

  @override
  get repository => throw UnimplementedError();
}

void main() {
  group('GuiaDeMoteisNotifier', () {
    test('Deve atualizar estado com sucesso', () async {
      final fakeUseCase = FakeSuccessUseCase();
      final notifier = GuiaDeMoteisNotifier(getGuiasUseCase: fakeUseCase);
      // Aguarda a finalização da chamada assíncrona
      await Future.delayed(Duration.zero);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.data, isNotNull);
      expect(notifier.state.error, isNull);
    });

    test('Deve atualizar estado com erro', () async {
      final fakeUseCase = FakeFailureUseCase();
      final notifier = GuiaDeMoteisNotifier(getGuiasUseCase: fakeUseCase);
      await Future.delayed(Duration.zero);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.error, AppStrings.erroBuscarDados);
    });
  });
}
