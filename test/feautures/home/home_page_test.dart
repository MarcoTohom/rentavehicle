import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apps/feautures/home/home_page.dart';

void main() {
  testWidgets('HomePage muestra los elementos principales', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomePage()),
    );

    // Verifica que el AppBar y texto de bienvenida existan
    expect(find.text('Bienvenido'), findsOneWidget);
    expect(find.text('¡Hola! Estas son tus opciones:'), findsOneWidget);

    // Verifica que los elementos del menú estén presentes
    expect(find.text('Reservar Bicicleta'), findsOneWidget);
    expect(find.text('Historial de Reservas'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);

    // Verifica que el botón logout (ícono) exista
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  testWidgets('Botón logout navega a /init con pushReplacementNamed', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const HomePage(),
        routes: {
          '/init': (context) => const Scaffold(body: Text('Pantalla Init')),
        },
      ),
    );

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    // Verifica que se haya navegado a /init
    expect(find.text('Pantalla Init'), findsOneWidget);
  });
}
