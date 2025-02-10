// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/guia_de_moteis_page.dart';
import '../../core/inject/inject.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Inicializa o GetIt
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Moteis',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GuiaDeMoteisListPage(),
    );
  }
}
