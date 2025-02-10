import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/error/exception.dart';
import 'package:guia_moteis/data/datasources/guia_de_moteis_remote_datasource.dart';
import 'package:guia_moteis/data/models/guias_de_moteis_response_model.dart';

// Fake adapter para simular respostas do Dio
class FakeDioAdapter implements HttpClientAdapter {
  final Response<dynamic> response;
  final bool simulateError;

  FakeDioAdapter({required this.response, this.simulateError = false});

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>>? requestStream, Future? cancelFuture) async {
    if (simulateError) {
      throw DioException(requestOptions: options, error: 'Fake error');
    }
    return ResponseBody.fromString(
      jsonEncode(response.data),
      response.statusCode!,
      headers: response.headers.map,
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late Dio dio;
  late GuiaDeMoteisRemoteDataSourceImpl datasource;

  setUp(() {
    dio = Dio();
    datasource = GuiaDeMoteisRemoteDataSourceImpl(dio: dio);
  });

  group("Teste da Camada Remote Datasource", () {
    test("Retorna GuiasDeMoteisResponseModel para status 200", () async {
      final fakeJson = {"key": "value"}; // substitua pelo JSON válido esperado
      final fakeResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: fakeJson,
        headers: Headers.fromMap({
          "content-type": ["application/json"]
        }),
      );
      dio.httpClientAdapter = FakeDioAdapter(response: fakeResponse);

      final result = await datasource.getGuiasDeMoteis();
      expect(result, isA<GuiasDeMoteisResponseModel>());
    });

    test("Lança ServerException para respostas com status diferente de 200",
        () async {
      final fakeResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
        data: {"error": "Not Found"},
        headers: Headers.fromMap({
          "content-type": ["application/json"]
        }),
      );
      dio.httpClientAdapter = FakeDioAdapter(response: fakeResponse);

      expect(datasource.getGuiasDeMoteis(), throwsA(isA<ServerException>()));
    });

    test("Lança ServerException quando DioException ocorre", () async {
      dio.httpClientAdapter = FakeDioAdapter(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: {"message": "Error"},
            headers: Headers.fromMap({
              "content-type": ["application/json"]
            }),
          ),
          simulateError: true);

      expect(datasource.getGuiasDeMoteis(), throwsA(isA<ServerException>()));
    });
  });
}
