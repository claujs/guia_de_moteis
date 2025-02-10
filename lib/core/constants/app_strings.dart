class AppStrings {
  AppStrings._(); // evita instanciar a classe

  static const String errorLoadingPhotos = 'Sem fotos';
  static const String noImages = 'Sem imagem';
  static const String appTitle = 'Guia de moteis';
  static const String verTodos = 'ver todos'; // nova constante
  static const String itens = 'Itens'; // nova constante
  static const String principaisItens = 'principais itens'; // nova constante
  static const String temTambem = 'tem também'; // nova constante
  static const String avaliacoes = 'avaliações';
  static const String erroBuscarDados =
      'Erro ao buscar dados'; // nova constante

  static String additionalQuantity(int quantity) =>
      'Só mais $quantity pelo app';
}
