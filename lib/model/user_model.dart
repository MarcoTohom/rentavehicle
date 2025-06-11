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

  UserModel({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.dpi,
    required String contrasena,
  }) : contrasenaHash = _hashPassword(contrasena);

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

  factory UserModel.fromMap(Map<String, dynamic> map) {
  return UserModel(
  id: map['id'] ?? '',
  nombres: map['nombres'] ?? '',
  apellidos: map['apellidos'] ?? '',
  correo: map['correo'] ?? '',
  telefono: map['telefono'] ?? '',
  dpi: map['dpi'] ?? '',
  contrasena: '', // No se necesita, ya que ya viene cifrada
  );
  }
}
