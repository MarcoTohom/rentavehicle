import 'package:apps/feautures/home/init_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('InitPage muestra contenido correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const InitPage(),
      ),
    );

    expect(find.text('Bienvenido a Mi App'), findsOneWidget);
    expect(find.text('Bienvenido'), findsOneWidget);
    expect(find.textContaining('Explora'), findsOneWidget);
    expect(find.byIcon(Icons.directions_bike), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Registrarse'), findsOneWidget);
  });

  testWidgets('Botón "Iniciar Sesión" navega a /login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const InitPage(),
        routes: {
          '/login': (context) => const Scaffold(body: Text('Login Page')),
        },
      ),
    );

    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Login Page'), findsOneWidget);
  });

  testWidgets('Botón "Registrarse" navega a /register', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const InitPage(),
        routes: {
          '/register': (context) => const Scaffold(body: Text('Register Page')),
        },
      ),
    );

    await tester.tap(find.text('Registrarse'));
    await tester.pumpAndSettle();

    expect(find.text('Register Page'), findsOneWidget);
  });
}
