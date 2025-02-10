import 'package:equatable/equatable.dart';

class ItemSuite extends Equatable {
  final String nome;

  const ItemSuite({required this.nome});

  @override
  List<Object?> get props => [nome];
}

class CategoriaItem extends Equatable {
  final String nome;
  final String icone;

  const CategoriaItem({
    required this.nome,
    required this.icone,
  });

  @override
  List<Object?> get props => [nome, icone];
}

class Periodo extends Equatable {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final Desconto? desconto;

  const Periodo({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  @override
  List<Object?> get props =>
      [tempoFormatado, tempo, valor, valorTotal, temCortesia, desconto];
}

class Desconto extends Equatable {
  final double desconto;

  const Desconto({required this.desconto});

  @override
  List<Object?> get props => [desconto];
}

class Suite extends Equatable {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<ItemSuite> itens;
  final List<CategoriaItem> categoriaItens;
  final List<Periodo> periodos;

  const Suite({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  @override
  List<Object?> get props => [
        nome,
        qtd,
        exibirQtdDisponiveis,
        fotos,
        itens,
        categoriaItens,
        periodos,
      ];
}
