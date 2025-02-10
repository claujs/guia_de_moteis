import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_moteis/core/constants/app_colors.dart';
import 'presentation/pages/guia_de_moteis_page.dart';
import '../../core/inject/inject.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Moteis',
      theme: ThemeData(primarySwatch: AppColors.red as MaterialColor),
      home: const GuiaDeMoteisListPage(),
    );
  }
}
