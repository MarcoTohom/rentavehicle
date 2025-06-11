import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Acción de cerrar sesión
              Navigator.pushReplacementNamed(context, '/init');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Hola! Estas son tus opciones:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.directions_bike),
              title: const Text('Reservar Bicicleta'),
              onTap: () {
                // Navegar a pantalla de reserva
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial de Reservas'),
              onTap: () {
                // Navegar a historial
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                // Navegar al perfil
              },
            ),
          ],
        ),
      ),
    );
  }
}
