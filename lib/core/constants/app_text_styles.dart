import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_colors.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.black);

  static const TextStyle subtitle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.grey800);

  static const TextStyle body = TextStyle(fontSize: 16, color: AppColors.black);

  static const TextStyle caption =
      TextStyle(fontSize: 12, color: AppColors.grey600);

  static const TextStyle normal =
      TextStyle(fontSize: 14, color: AppColors.grey600);

  static const TextStyle button = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white);

  static const TextStyle input =
      TextStyle(fontSize: 16, color: AppColors.black);

  static const TextStyle error = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.red);

  static const TextStyle warning = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.red);

  static const TextStyle success = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green);

  static const TextStyle appTitle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white);
}
