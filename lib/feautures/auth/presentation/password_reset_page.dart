import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _message = 'No estás autenticado.';
        });
        return;
      }

      await user.updatePassword(_passwordController.text.trim());
      await user.reload();

      setState(() {
        _message = 'La contraseña ha sido actualizada correctamente.';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'requires-recent-login') {
          _message = 'Por seguridad, vuelve a iniciar sesión para cambiar tu contraseña.';
        } else {
          _message = 'Ocurrió un error: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _message = 'Ocurrió un error inesperado. Intenta de nuevo.';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restablecer Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Colors.amber),
                const SizedBox(height: 20),
                const Text(
                  'Ingresa tu nueva contraseña.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Nueva contraseña',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar contraseña',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _resetPassword,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Actualizar contraseña'),
                ),
                const SizedBox(height: 20),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(
                      color: _message.contains('error') || _message.contains('Error') || _message.contains('Ocurrió')
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Volver al inicio de sesión'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
