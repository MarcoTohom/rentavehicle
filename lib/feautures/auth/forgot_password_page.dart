import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final FirebaseAuth auth;
  ForgotPasswordPage({super.key, FirebaseAuth? auth})
      : auth = auth ?? FirebaseAuth.instance;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>{
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _message = '';
  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      await widget.auth.sendPasswordResetEmail(email: _emailController.text.trim());

      setState(() {
        _message =
        'Se ha enviado un enlace de recuperación a ${_emailController.text.trim()}';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _message = 'No existe una cuenta con ese correo.';
        } else if (e.code == 'invalid-email') {
          _message = 'Correo inválido.';
        } else {
          _message = 'Ocurrió un error. Intenta de nuevo.';
        }
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña'),),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.lock_reset, size: 80, color: Colors.amber),
                const SizedBox(height: 20),
                const Text(
                  'Ingrese su correo electrónico para enviar un enlace de recuperación.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'Ingrese un correo válido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _sendPasswordResetEmail,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Enviar enlace de recuperación'),
                ),
                const SizedBox(height: 20),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(
                      color: _message.contains('error') ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('¿Ya la recordaste? Inicia sesión'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}