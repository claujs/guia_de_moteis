// lib/data/models/guia_de_moteis_model.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/guia_de_moteis.dart';
import 'suite_model.dart';

class GuiaDeMoteisModel extends GuiaDeMoteis with EquatableMixin {
  const GuiaDeMoteisModel({
    required super.fantasia,
    required super.logo,
    required super.bairro,
    required super.distancia,
    required super.qtdFavoritos,
    required super.media,
    required super.qtdAvaliacoes,
    super.suites,
  });

  factory GuiaDeMoteisModel.fromJson(Map<String, dynamic> json) {
    final suitesList = json['suites'] as List<dynamic>? ?? [];

    return GuiaDeMoteisModel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: (json['distancia'] as num?)?.toDouble() ?? 0.0,
      qtdFavoritos: json['qtdFavoritos'] ?? 0,
      media: (json['media'] as num?)?.toDouble() ?? 0.0,
      qtdAvaliacoes: json['qtdAvaliacoes'] ?? 0,
      suites: suitesList
          .map((s) => SuiteModel.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}
