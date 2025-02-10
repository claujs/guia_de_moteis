import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_resizer.dart';
import 'package:guia_moteis/core/constants/app_text_styles.dart';
import 'package:skeletonizer/skeletonizer.dart'; // novo import

import '../../core/constants/app_strings.dart';
import '../../domain/entities/suite.dart'; // Importa a definição de SuitePhotoSlide

class GuiaDeMoteisSuitePhotoSlides extends StatelessWidget {
  final String suiteName;
  final String photoUrl;
  final int quantity;
  final List<CategoriaItem> items;
  final bool exibirQtdDisponiveis; // nova propriedade

  const GuiaDeMoteisSuitePhotoSlides({
    super.key,
    required this.suiteName,
    required this.photoUrl,
    required this.quantity,
    required this.items,
    required this.exibirQtdDisponiveis, // inicializa a nova propriedade
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: AppResizer.dynamicHeightFromContext(context, 0.22),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              photoUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Skeleton.leaf(
                  child: Container(
                    height: AppResizer.dynamicHeightFromContext(context, 0.22),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          suiteName,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
        if (exibirQtdDisponiveis)
          Text(
            AppStrings.additionalQuantity(quantity),
            style: AppTextStyles.warning,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
