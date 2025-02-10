import 'package:guia_moteis/domain/entities/suite.dart'; // se necessário para CategoriaItem

class SuitePhotoSlide {
  final String suiteName;
  final String photoUrl;
  final int quantity;
  final List<CategoriaItem> items;

  const SuitePhotoSlide({
    required this.suiteName,
    required this.photoUrl,
    required this.quantity,
    required this.items,
  });
}
