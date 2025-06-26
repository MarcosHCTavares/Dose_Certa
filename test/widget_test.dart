import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dose_certa/main.dart';

void main() {
  testWidgets('DoseCertaApp inicializa e exibe elementos principais', (WidgetTester tester) async {
    // Carrega o widget principal do app
    await tester.pumpWidget(const DoseCertaApp());

    // Aguarda animações e frames
    await tester.pumpAndSettle();

    // Verifica se o título da AppBar está presente (ajuste o texto conforme sua HomeScreen)
    expect(find.text('Medicamentos'), findsOneWidget);

    // Verifica se o FloatingActionButton está presente
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
