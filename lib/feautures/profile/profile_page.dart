import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:apps/model/user_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<UserModel?> _fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final query = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return UserModel.fromFirestore(doc.id, doc.data());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<UserModel?>(
        future: _fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No se encontraron datos del perfil.'));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Icon(Icons.account_circle, size: 100, color: Colors.blueGrey),
                const SizedBox(height: 16),
                _buildInfoTile('Nombres', user.nombres),
                _buildInfoTile('Apellidos', user.apellidos),
                _buildInfoTile('Correo', user.correo),
                _buildInfoTile('Teléfono', user.telefono),
                _buildInfoTile('DPI', user.dpi),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
        leading: const Icon(Icons.info_outline),
      ),
    );
  }
}
