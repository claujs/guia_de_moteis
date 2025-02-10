import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_colors.dart';
import 'package:guia_moteis/core/constants/app_strings.dart';
import 'package:guia_moteis/core/constants/app_text_styles.dart';

class GuiaDeMoteisBody extends StatelessWidget {
  final Widget child;
  const GuiaDeMoteisBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle, style: AppTextStyles.appTitle),
        elevation: 2,
        backgroundColor: AppColors.red,
      ),
      body: child,
    );
  }
}
