import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/domain/entities/guia_de_moteis.dart';
import 'package:guia_moteis/domain/entities/suite.dart';
import 'package:guia_moteis/presentation/widgets/guia_de_moteis_card.dart'; // ajuste se necessário

void main() {
  // Cria objetos dummy para os testes
  final dummySuite = Suite(
    nome: 'Suite Luxo', // alterado de 'Suite Test'
    fotos: ['https://test.com/image.jpg'],
    qtd: 1,
    categoriaItens: [],
    periodos: [],
    exibirQtdDisponiveis: false,
    itens: [],
  );
  final dummyGuia = GuiaDeMoteis(
    fantasia: 'Guia Teste',
    logo: 'https://test.com/logo.png',
    bairro: 'Bairro Teste',
    distancia: 1.0,
    qtdFavoritos: 0,
    media: 5.0,
    qtdAvaliacoes: 0,
    suites: [dummySuite],
  );

  group("GuiaDeMoteisCard Widget", () {
    testWidgets("Se adapta corretamente em tela pequena", (tester) async {
      const sizeSmall = Size(320, 480);
      tester.view.physicalSize = sizeSmall;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GuiaDeMoteisCard(
            guia: dummyGuia,
            globalRating: 5.0,
            globalReviews: 10,
            quantity: 1,
            items: [
              CategoriaItem(nome: 'item1', icone: 'icon1'),
              CategoriaItem(nome: 'item2', icone: 'icon2'),
            ],
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Valida se o texto do guia está presente
      expect(find.text('Guia Teste'), findsWidgets);
      // Valida a renderização do Card e elementos-chave
      expect(find.byType(PageView), findsOneWidget);

      // Limpa o valor alterado
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });

    testWidgets("Se adapta corretamente em tela grande", (tester) async {
      const sizeLarge = Size(1080, 1920);
      tester.view.physicalSize = sizeLarge;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GuiaDeMoteisCard(
            guia: dummyGuia,
            globalRating: 5.0,
            globalReviews: 10,
            quantity: 1,
            items: [],
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Verifica se os elementos do card se adaptam e estão presentes
      expect(find.text('Guia Teste'), findsWidgets);
      expect(find.byType(PageView), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });
  });

  const suiteName = 'Suite Luxo';

  group("GuiaDeMoteisCard Responsividade", () {
    testWidgets("Adapta corretamente em tela pequena", (tester) async {
      const sizeSmall = Size(320, 480);
      tester.view.physicalSize = sizeSmall;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GuiaDeMoteisCard(
            guia: dummyGuia,
            globalRating: 5.0,
            globalReviews: 10,
            quantity: 1,
            items: [
              CategoriaItem(nome: 'item1', icone: 'icon1'),
              CategoriaItem(nome: 'item2', icone: 'icon2'),
            ],
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text(suiteName), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });

    testWidgets("Adapta corretamente em tela grande", (tester) async {
      const sizeLarge = Size(1080, 1920);
      tester.view.physicalSize = sizeLarge;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GuiaDeMoteisCard(
            guia: dummyGuia,
            globalRating: 5.0,
            globalReviews: 10,
            quantity: 1,
            items: [
              CategoriaItem(nome: 'item1', icone: 'icon1'),
              CategoriaItem(nome: 'item2', icone: 'icon2'),
            ],
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text(suiteName), findsOneWidget);
      // ...adicione asserts para verificar adaptações específicas em telas grandes...

      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });

    testWidgets("Adapta corretamente em dispositivo iOS", (tester) async {
      const iosSize = Size(375, 812);
      tester.view.physicalSize = iosSize;
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GuiaDeMoteisCard(
            guia: dummyGuia,
            globalRating: 5.0,
            globalReviews: 10,
            quantity: 1,
            items: [
              CategoriaItem(nome: 'item1', icone: 'icon1'),
              CategoriaItem(nome: 'item2', icone: 'icon2'),
            ],
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text(suiteName), findsOneWidget);
      // ...adicione asserts específicos para o layout iOS, se necessário...

      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });
  });
}
