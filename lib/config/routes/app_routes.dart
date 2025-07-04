import 'package:apps/feautures/auth/forgot_password_page.dart';
import 'package:apps/feautures/auth/login_page.dart';
import 'package:apps/feautures/auth/password_reset_page.dart';
import 'package:apps/feautures/auth/register_page.dart';
import 'package:apps/feautures/home/home_page.dart';
import 'package:apps/feautures/home/init_page.dart';
import 'package:apps/feautures/profile/profile_page.dart';

class AppRoutes {
  static final routes = {
    '/init': (context) => const InitPage(),
    '/home': (context) => const HomePage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/recovery': (context) => ForgotPasswordPage(),
    '/reset': (context) => const PasswordResetPage(),
    '/profile': (context) => const ProfilePage()
  };
}
