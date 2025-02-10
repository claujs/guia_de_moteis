import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_colors.dart';
import 'package:guia_moteis/core/constants/app_text_styles.dart';
import 'package:guia_moteis/domain/entities/suite.dart';
import 'package:intl/intl.dart'; // formatação de moeda

class GuiaDeMoteisPeriodos extends StatelessWidget {
  final Suite suite;
  const GuiaDeMoteisPeriodos({super.key, required this.suite});

  @override
  Widget build(BuildContext context) {
    final periodos = suite.periodos;
    return Column(
      children: periodos.map((p) => GuiaDeMoteisPeriodo(periodo: p)).toList(),
    );
  }
}

class GuiaDeMoteisPeriodo extends StatelessWidget {
  final dynamic periodo;
  const GuiaDeMoteisPeriodo({super.key, required this.periodo});

  double _calculateFinalPrice(double valorTotal, double discount) {
    return discount > 0 ? valorTotal * (1 - (discount / 100)) : valorTotal;
  }

  @override
  Widget build(BuildContext context) {
    final double discountValue = periodo.desconto?.desconto ?? 0;
    final int discountRounded = discountValue.round();
    final currencyFormatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final double finalPrice =
        _calculateFinalPrice(periodo.valorTotal, discountValue);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(periodo.tempoFormatado, style: AppTextStyles.subtitle),
                const SizedBox(height: 4),
                discountValue > 0
                    ? Row(
                        children: [
                          Text(
                            currencyFormatter.format(periodo.valorTotal),
                            style: AppTextStyles.subtitle.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currencyFormatter.format(finalPrice),
                            style: AppTextStyles.subtitle,
                          ),
                        ],
                      )
                    : Text(
                        currencyFormatter.format(finalPrice),
                        style: AppTextStyles.subtitle,
                      ),
              ],
            ),
            Row(
              children: [
                if (discountValue > 0)
                  Chip(
                    label: Text(
                      '$discountRounded% OFF',
                      style: AppTextStyles.subtitle
                          .copyWith(color: AppColors.green),
                    ),
                    backgroundColor: Colors.transparent,
                    shape: const StadiumBorder(
                      side: BorderSide(color: AppColors.green),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.right_chevron, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
