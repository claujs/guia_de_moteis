import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/data/models/guias_de_moteis_response_model.dart';

void main() {
  group("GuiasDeMoteisResponseModel", () {
    final jsonMap = {
      "data": {
        "guias": [
          {
            "fantasia": "Guia Teste",
            "logo": "test_logo.png",
            "bairro": "Test District",
            "distancia": 1.0,
            "qtdFavoritos": 0,
            "media": 5.0,
            "qtdAvaliacoes": 0,
            "suites": [
              {
                "qtd": 1,
                "categoriaItens": ["item1", "item2"],
              }
            ]
          }
        ]
      }
    };

    test("deve ser uma subclasse de GuiasDeMoteisResponse", () {
      final response = GuiasDeMoteisResponseModel.fromJson(jsonMap);
      expect(response, isA<GuiasDeMoteisResponseModel>());
    });
  });
}
