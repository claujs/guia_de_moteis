import 'package:equatable/equatable.dart';
import 'guia_de_moteis.dart';

class GuiasDeMoteisResponse extends Equatable {
  final List<GuiaDeMoteis> guias;

  const GuiasDeMoteisResponse({
    required this.guias,
  });

  @override
  List<Object?> get props => [guias];
}
