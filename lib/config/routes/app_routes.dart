import 'package:apps/feautures/auth/presentation/forgot_password_page.dart';
import 'package:apps/feautures/auth/presentation/login_page.dart';
import 'package:apps/feautures/auth/presentation/register_page.dart';
import 'package:apps/feautures/home/home_page.dart';
import 'package:apps/feautures/home/init_page.dart';

class AppRoutes {
  static final routes = {
    '/init': (context) => const InitPage(),
    '/home': (context) => const HomePage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/recovery': (context) => const ForgotPasswordPage()
  };
}
