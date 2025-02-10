import 'package:equatable/equatable.dart';

import 'suite.dart';

class GuiaDeMoteis extends Equatable {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final int qtdAvaliacoes;
  final double media;

  // Caso tenha suites:
  final List<Suite>? suites;

  const GuiaDeMoteis({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.media,
    required this.qtdAvaliacoes,
    this.suites,
  });

  @override
  List<Object?> get props => [fantasia, logo, bairro, distancia, qtdFavoritos];
}
