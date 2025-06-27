import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserModel {
  final String id;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final String dpi;
  final String contrasenaHash;

  // Constructor para creación (hash en tiempo real)
  UserModel({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.dpi,
    required String contrasena,
  }) : contrasenaHash = _hashPassword(contrasena);

  // Constructor para lectura desde Firestore (ya viene con hash)
  factory UserModel._fromData({
    required String id,
    required String nombres,
    required String apellidos,
    required String correo,
    required String telefono,
    required String dpi,
    required String contrasenaHash,
  }) {
    return UserModel._internal(
      id: id,
      nombres: nombres,
      apellidos: apellidos,
      correo: correo,
      telefono: telefono,
      dpi: dpi,
      contrasenaHash: contrasenaHash,
    );
  }

  // Interno para evitar repetir lógica
  const UserModel._internal({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.dpi,
    required this.contrasenaHash,
  });

  static String _hashPassword(String contrasena) {
    final bytes = utf8.encode(contrasena);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'correo': correo,
      'telefono': telefono,
      'dpi': dpi,
      'contraseñaHash': contrasenaHash,
    };
  }

  factory UserModel.fromFirestore(String idDoc, Map<String, dynamic> map) {
    return UserModel._fromData(
      id: idDoc,
      nombres: map['nombres'] ?? '',
      apellidos: map['apellidos'] ?? '',
      correo: map['correo'] ?? '',
      telefono: map['telefono'] ?? '',
      dpi: map['dpi'] ?? '',
      contrasenaHash: map['contraseñaHash'] ?? '',
    );
  }
}
