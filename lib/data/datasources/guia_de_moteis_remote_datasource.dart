import 'dart:developer';
import 'package:dio/dio.dart';

import '../../core/error/exception.dart';
import '../models/guias_de_moteis_response_model.dart';

abstract class GuiaDeMoteisRemoteDataSource {
  Future<GuiasDeMoteisResponseModel> getGuiasDeMoteis();
}

class GuiaDeMoteisRemoteDataSourceImpl implements GuiaDeMoteisRemoteDataSource {
  final Dio dio;

  GuiaDeMoteisRemoteDataSourceImpl({required this.dio});

  @override
  Future<GuiasDeMoteisResponseModel> getGuiasDeMoteis() async {
    try {
      final response = await dio.get(
        'https://www.jsonkeeper.com/b/1IXK',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        log('Conteúdo retornado: ${response.data}');
        final jsonMap = response.data as Map<String, dynamic>;
        return GuiasDeMoteisResponseModel.fromJson(jsonMap);
      } else {
        throw ServerException();
      }
    } on DioException catch (dioError) {
      log('DioError ao fazer requisição: $dioError');
      throw ServerException();
    } catch (e, stack) {
      log('Erro ao decodificar JSON: $e\n$stack');
      throw ServerException();
    }
  }
}
