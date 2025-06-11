import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a Mi App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.directions_bike, size: 100, color: Colors.amber),
            const SizedBox( height: 20),
            const Text(
              'Bienvenido',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explora, reserva y pedalea con facilidad. Inicia sesión o crea una cuenta para comenzar.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login'); // '/login'
                },
                child: const Text('Iniciar Sesión'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register'); // '/register'
                },
                child: const Text('Registrarse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
