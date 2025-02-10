// ...conteúdo original do full_screen_itens.dart...
import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_resizer.dart';
import 'package:guia_moteis/core/constants/app_text_styles.dart';
import 'package:guia_moteis/core/constants/app_strings.dart';
import '../../domain/entities/suite.dart';

class GuiaDeMoteisItens extends StatelessWidget {
  final Suite suite;
  const GuiaDeMoteisItens({super.key, required this.suite});

  @override
  Widget build(BuildContext context) {
    final double iconSize = AppResizer.dynamicHeightFromContext(context, 0.03);
    final suiteItens = suite.itens;
    final categoriaItens = suite.categoriaItens;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.itens),
        leading: IconButton(
          icon: const Icon(Icons.arrow_drop_down_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(suite.nome, style: AppTextStyles.title),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(AppStrings.principaisItens,
                      style: AppTextStyles.body),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: categoriaItens.map((item) {
                final double itemWidth =
                    (AppResizer(context).dynamicWidth(1) - 32 - 12) / 2;
                return SizedBox(
                  width: itemWidth,
                  child: Row(
                    children: [
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: Image.network(item.icone, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Text(item.nome,
                            style: AppTextStyles.caption,
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            if (suiteItens.isNotEmpty) ...[
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                        Text(AppStrings.temTambem, style: AppTextStyles.body),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 30),
              Text(suiteItens.map((item) => item.nome).join(', '),
                  style: AppTextStyles.normal),
            ],
          ],
        ),
      ),
    );
  }
}
