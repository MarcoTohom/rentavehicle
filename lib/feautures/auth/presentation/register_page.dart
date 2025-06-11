import 'package:apps/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final nombres = _nombresController.text.trim();
      final apellidos = _apellidosController.text.trim();
      final email = _emailController.text.trim();
      final telefono = _telefonoController.text.trim();
      final dpi = _dpiController.text.trim();
      final password = _passwordController.text.trim();

      try {
        // Verificar si el DPI ya está registrado como ID de documento
        final existingDoc = await _firestore.collection('users').doc(dpi).get();
        if (existingDoc.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('El DPI ya está registrado.')),
          );
          return;
        }

        // Crear usuario en Firebase Auth
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Crear instancia de UserModel
        final newUser = UserModel(
          id: userCredential.user!.uid,
          nombres: nombres,
          apellidos: apellidos,
          correo: email,
          telefono: telefono,
          dpi: dpi,
          contrasena: password,
        );

        // Guardar los datos en Firestore con el DPI como ID de documento
        await _firestore.collection('users').doc(dpi).set({
          ...newUser.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );

        Navigator.pushNamed(context, '/home');

      } on FirebaseAuthException catch (e) {
        String errorMsg = 'Ocurrió un error';
        if (e.code == 'email-already-in-use') {
          errorMsg = 'El correo ya está en uso.';
        } else if (e.code == 'weak-password') {
          errorMsg = 'La contraseña es muy débil.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
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
                validator: (value) => value!.length < 8 ? 'Teléfono inválido' : null,
              ),
              TextFormField(
                controller: _dpiController,
                decoration: const InputDecoration(labelText: 'DPI'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length != 13 ? 'El DPI debe tener 13 dígitos' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
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
