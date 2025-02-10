import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_text_styles.dart';
import 'package:guia_moteis/core/constants/app_strings.dart';

import '../../core/constants/app_colors.dart';

class GuiaDeMoteisRating extends StatelessWidget {
  final double rating;
  final int reviewsCount;

  const GuiaDeMoteisRating({
    super.key,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    final stars = [
      ...List.generate(fullStars,
          (_) => const Icon(Icons.star, color: AppColors.amber, size: 16)),
      if (hasHalfStar)
        const Icon(Icons.star_half, color: AppColors.amber, size: 16),
      ...List.generate(
        emptyStars,
        (_) => const Icon(Icons.star_border, color: AppColors.amber, size: 16),
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: stars),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '$reviewsCount ${AppStrings.avaliacoes}',
            style: AppTextStyles.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
