import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/domain/entities/suite.dart';
import 'package:guia_moteis/presentation/widgets/guia_de_moteis_suite_slides.dart';

void main() {
  const suiteName = 'Suite Responsive';
  const photoUrl = 'https://test.com/image.jpg';
  const quantity = 3;
  final items = <CategoriaItem>[]; // empty list of CategoriaItem type

  group("GuiaDeMoteisSuitePhotoSlides Responsividade", () {
    testWidgets("Adapta corretamente em tela pequena", (tester) async {
      const sizeSmall = Size(320, 480);
      tester.view.physicalSize = sizeSmall;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GuiaDeMoteisSuitePhotoSlides(
            suiteName: suiteName,
            photoUrl: photoUrl,
            quantity: quantity,
            items: items,
            exibirQtdDisponiveis: true,
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
          body: GuiaDeMoteisSuitePhotoSlides(
            suiteName: suiteName,
            photoUrl: photoUrl,
            quantity: quantity,
            items: items,
            exibirQtdDisponiveis: true,
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
      const iosSize = Size(375, 812); // dimensões típicas do iPhone X
      tester.view.physicalSize = iosSize;
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GuiaDeMoteisSuitePhotoSlides(
              suiteName: suiteName,
              photoUrl: photoUrl,
              quantity: quantity,
              items: items,
              exibirQtdDisponiveis: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(suiteName), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
    });
  });
}
