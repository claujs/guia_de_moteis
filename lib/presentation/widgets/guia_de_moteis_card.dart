import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_colors.dart';
import 'package:guia_moteis/core/constants/app_resizer.dart';
import 'package:guia_moteis/core/constants/app_strings.dart';
import 'package:guia_moteis/core/constants/app_text_styles.dart';
import 'package:guia_moteis/domain/entities/suite.dart';
import 'package:guia_moteis/presentation/widgets/guia_de_moteis_suite_slides.dart';

import '../../domain/entities/guia_de_moteis.dart';
import 'guia_de_moteis_itens.dart';
import 'guia_de_moteis_periodos.dart'; // novo import para os widgets de período
import 'guia_de_moteis_rating.dart';

class GuiaDeMoteisCard extends StatelessWidget {
  final GuiaDeMoteis guia;
  final double globalRating;
  final int globalReviews;
  final int quantity;
  final List<CategoriaItem> items;

  const GuiaDeMoteisCard({
    super.key,
    required this.guia,
    required this.globalRating,
    required this.globalReviews,
    required this.quantity,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final suites = guia.suites;
    return Visibility(
      visible: suites?.isNotEmpty ?? false,
      replacement: _buildPlaceholderCard(context),
      child: SizedBox(
        height: AppResizer.dynamicHeightFromContext(context, 0.8),
        child: PageView.builder(
          controller: PageController(),
          itemCount: suites!.length,
          itemBuilder: (context, index) {
            final Suite suite = suites[index];
            final bool hasPhoto = suite.fotos.isNotEmpty;
            final List items = suite.categoriaItens;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildInfoCard(context, suite, hasPhoto),
                  _buildSuiteItemsCard(context, suite, items),
                  Visibility(
                    visible: suite.periodos.isNotEmpty,
                    child: GuiaDeMoteisPeriodos(suite: suite),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _buildPlaceholderCard(BuildContext context) => Card(
        margin: const EdgeInsets.all(8),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(guia.fantasia, style: AppTextStyles.title),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      guia.logo,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${guia.bairro} - ${guia.distancia} km',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GuiaDeMoteisRating(
                rating: globalRating,
                reviewsCount: globalReviews,
              ),
              const SizedBox(height: 12),
              Container(
                height: AppResizer.dynamicHeightFromContext(context, 0.2),
                color: AppColors.grey300,
                child: Center(
                  child: Text(
                    AppStrings.errorLoadingPhotos,
                    style: AppTextStyles.body,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _buildInfoCard(BuildContext context, Suite suite, bool hasPhoto) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    guia.logo,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(guia.fantasia, style: AppTextStyles.subtitle),
                      const SizedBox(height: 4),
                      Text(
                        '${guia.bairro} - ${guia.distancia} km',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GuiaDeMoteisRating(
              rating: globalRating,
              reviewsCount: globalReviews,
            ),
            const SizedBox(height: 12),
            hasPhoto
                ? GuiaDeMoteisSuitePhotoSlides(
                    suiteName: suite.nome,
                    photoUrl: suite.fotos.first,
                    quantity: suite.qtd,
                    items: suite.categoriaItens,
                    exibirQtdDisponiveis: suite.exibirQtdDisponiveis,
                  )
                : Container(
                    height: AppResizer.dynamicHeightFromContext(context, 0.2),
                    color: AppColors.grey300,
                    child: Center(
                      child: Text(
                        AppStrings.errorLoadingPhotos,
                        style: AppTextStyles.body,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _buildSuiteItemsCard(BuildContext context, Suite suite, List items) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: AppResizer.dynamicHeightFromContext(context, 0.05),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: (items.length >= 5 ? 5 : items.length) + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, idx) {
              final int totalTiles = (items.length >= 5 ? 5 : items.length) + 1;
              if (idx == totalTiles - 1) {
                return GestureDetector(
                  onTap: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => GuiaDeMoteisItens(suite: suite),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(AppStrings.verTodos, style: AppTextStyles.caption),
                        const Icon(Icons.arrow_drop_down, size: 20),
                      ],
                    ),
                  ),
                );
              } else {
                final dynamic item = items[idx];
                final double iconSize =
                    AppResizer.dynamicHeightFromContext(context, 0.05);
                return Center(
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image.network(
                      item.icone,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
