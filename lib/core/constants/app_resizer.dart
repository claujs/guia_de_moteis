import 'package:flutter/widgets.dart';

class AppResizer {
  final BuildContext context;

  AppResizer(this.context);

  double dynamicWidth(double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  double dynamicHeight(double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  static double dynamicWidthFromContext(
      BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static double dynamicHeightFromContext(
      BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
}
