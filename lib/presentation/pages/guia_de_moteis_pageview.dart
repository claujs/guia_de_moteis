import 'package:flutter/material.dart';
import 'package:guia_moteis/core/constants/app_resizer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'package:guia_moteis/core/constants/app_strings.dart';

class GuiaDeMoteisPageView extends StatefulWidget {
  final List<Widget> pages;
  final PageController? controller;

  const GuiaDeMoteisPageView({
    super.key,
    required this.pages,
    this.controller,
  });

  @override
  State<GuiaDeMoteisPageView> createState() => _GuiaDeMoteisPageViewState();
}

class _GuiaDeMoteisPageViewState extends State<GuiaDeMoteisPageView> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PageController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pages.isEmpty) {
      return Container(
        height: AppResizer.dynamicHeightFromContext(context, 0.20),
        decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            AppStrings.noImages,
            style: AppTextStyles.body,
          ),
        ),
      );
    }

    return SizedBox(
      height: AppResizer.dynamicHeightFromContext(context, 0.35),
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: widget.pages[index],
          );
        },
      ),
    );
  }
}
