import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _dpiController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes procesar el registro
      final nombres = _nombresController.text;
      final apellidos = _apellidosController.text;
      final email = _emailController.text;
      final telefono = _telefonoController.text;
      final dpi = _dpiController.text;
      final password = _passwordController.text;

      // Por ejemplo:
      print('Registrando usuario: $nombres $apellidos ($email)');
      // Aquí puedes conectar con Firebase o tu backend
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombresController,
                decoration: const InputDecoration(labelText: 'Nombres'),
                validator: (value) => value!.isEmpty ? 'Ingrese sus nombres' : null,
              ),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) => value!.isEmpty ? 'Ingrese sus apellidos' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value != null && value.contains('@') ? null : 'Correo inválido',
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value!.length < 8 ? 'Teléfono inválido' : null,
              ),
              TextFormField(
                controller: _dpiController,
                decoration: const InputDecoration(labelText: 'DPI'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.length != 13 ? 'El DPI debe tener 13 dígitos' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) =>
                value!.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Verificar Contraseña'),
                obscureText: true,
                validator: (value) =>
                value != _passwordController.text ? 'Las contraseñas no coinciden' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
