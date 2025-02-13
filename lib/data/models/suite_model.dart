import '../../domain/entities/suite.dart';

class DescontoModel extends Desconto {
  const DescontoModel({required super.desconto});

  factory DescontoModel.fromJson(Map<String, dynamic> json) {
    return DescontoModel(
      desconto: (json['desconto'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class PeriodoModel extends Periodo {
  const PeriodoModel({
    required super.tempoFormatado,
    required super.tempo,
    required super.valor,
    required super.valorTotal,
    required super.temCortesia,
    super.desconto,
  });

  factory PeriodoModel.fromJson(Map<String, dynamic> json) {
    final descontoJson = json['desconto'] as Map<String, dynamic>?;

    return PeriodoModel(
      tempoFormatado: json['tempoFormatado'] ?? '',
      tempo: json['tempo'] ?? '',
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
      valorTotal: (json['valorTotal'] as num?)?.toDouble() ?? 0.0,
      temCortesia: json['temCortesia'] ?? false,
      desconto:
          descontoJson != null ? DescontoModel.fromJson(descontoJson) : null,
    );
  }
}

class ItemSuiteModel extends ItemSuite {
  const ItemSuiteModel({required super.nome});

  factory ItemSuiteModel.fromJson(Map<String, dynamic> json) {
    return ItemSuiteModel(
      nome: json['nome'] ?? '',
    );
  }
}

class CategoriaItemModel extends CategoriaItem {
  const CategoriaItemModel({
    required super.nome,
    required super.icone,
  });

  factory CategoriaItemModel.fromJson(Map<String, dynamic> json) {
    return CategoriaItemModel(
      nome: json['nome'] ?? '',
      icone: json['icone'] ?? '',
    );
  }
}

class SuiteModel extends Suite {
  const SuiteModel({
    required super.nome,
    required super.qtd,
    required super.exibirQtdDisponiveis,
    required super.fotos,
    required super.itens,
    required super.categoriaItens,
    required super.periodos,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    // 1) Parse "fotos" (lista de strings)
    final fotosList = (json['fotos'] as List<dynamic>? ?? [])
        .map((f) => f.toString())
        .toList();

    // 2) Parse "itens" (array de objetos c/ "nome")
    final itensList = (json['itens'] as List<dynamic>? ?? [])
        .map((i) => ItemSuiteModel.fromJson(i))
        .toList();

    // 3) Parse "categoriaItens"
    final categoriaItensList = (json['categoriaItens'] as List<dynamic>? ?? [])
        .map((cat) => CategoriaItemModel.fromJson(cat))
        .toList();

    // 4) Parse "periodos"
    final periodosList = (json['periodos'] as List<dynamic>? ?? [])
        .map((p) => PeriodoModel.fromJson(p))
        .toList();

    return SuiteModel(
      nome: json['nome'] ?? '',
      qtd: json['qtd'] ?? 0,
      exibirQtdDisponiveis: json['exibirQtdDisponiveis'] ?? false,
      fotos: fotosList,
      itens: itensList,
      categoriaItens: categoriaItensList,
      periodos: periodosList,
    );
  }
}
