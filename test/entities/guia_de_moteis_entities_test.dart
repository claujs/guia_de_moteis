import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis_response.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis.dart';

void main() {
  final tGuia = GuiaDeMoteis(
      fantasia: 'Teste',
      logo: 'test_logo.png',
      bairro: 'Test District',
      distancia: 1.0,
      qtdFavoritos: 0,
      media: 5.0,
      qtdAvaliacoes: 0);
  final tGuiasResponse = GuiasDeMoteisResponse(guias: [tGuia]);

  group("Camada de Entities", () {
    test("Deve ser equatable", () {
      final outraResponse = GuiasDeMoteisResponse(guias: [
        GuiaDeMoteis(
            fantasia: 'Teste',
            logo: 'test_logo.png',
            bairro: 'Test District',
            distancia: 1.0,
            qtdFavoritos: 0,
            media: 5.0,
            qtdAvaliacoes: 0)
      ]);
      expect(tGuiasResponse, equals(outraResponse));
    });

    test("Validação básica dos dados da entidade", () {
      expect(tGuiasResponse.guias.first.fantasia, 'Teste');
    });

    test("Criação de GuiasDeMoteisResponse a partir do JSON", () {
      final jsonMap = {
        "guias": [
          {"id": 1, "name": "Teste"}
        ]
      };

      expect(jsonMap['guias']![0]['id'], equals(1));
      expect(jsonMap['guias']![0]['name'], equals('Teste'));
    });
  });
}
