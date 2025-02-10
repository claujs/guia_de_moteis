import '../../domain/entities/guia_de_moteis_response.dart';
import 'guia_de_moteis_model.dart';

class GuiasDeMoteisResponseModel extends GuiasDeMoteisResponse {
  const GuiasDeMoteisResponseModel({
    required List<GuiaDeMoteisModel> super.guias,
  });

  factory GuiasDeMoteisResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final moteisList = data['moteis'] as List<dynamic>? ?? [];

    return GuiasDeMoteisResponseModel(
      guias: moteisList
          .map((guiaJson) => GuiaDeMoteisModel.fromJson(guiaJson))
          .toList(),
    );
  }
}
