import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:apps/feautures/auth/forgot_password_page.dart'; // Ajusta el import

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ForgotPasswordPage Widget Test', () {
    late MockFirebaseAuth mockAuth;

    setUp(() {
      mockAuth = MockFirebaseAuth();
    });

    testWidgets('Se renderizan los elementos principales', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ForgotPasswordPage(auth: mockAuth)),
      );

      expect(find.text('Recuperar contraseña'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.lock_reset), findsOneWidget);
      expect(find.textContaining('Ingrese su correo'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Muestra mensaje de error si el correo es inválido', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ForgotPasswordPage(auth: mockAuth)),
      );

      await tester.enterText(find.byType(TextFormField), 'correo_invalido');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Ingrese un correo válido'), findsOneWidget);
    });

    testWidgets('No muestra error si el correo es válido y se simula envío', (WidgetTester tester) async {
      final mockUser = MockUser(email: 'test@example.com');
      final auth = MockFirebaseAuth(mockUser: mockUser);

      await tester.pumpWidget(
        MaterialApp(home: ForgotPasswordPage(auth: auth)),
      );

      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      expect(find.textContaining('Se ha enviado un enlace'), findsOneWidget);
    });

    testWidgets('Navega hacia atrás cuando se presiona el botón de texto', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => ForgotPasswordPage(auth: mockAuth),
            ),
          ),
        ),
      );

      await tester.tap(find.text('¿Ya la recordaste? Inicia sesión'));
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPasswordPage), findsNothing);
    });
  });

}
