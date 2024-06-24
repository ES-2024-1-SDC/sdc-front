class UsuarioFields {
  final List<String> values = [
    id,
    fullName,
    email,
    password,
    createdAt,
    updateAt
  ];

  static const String id = '_id';
  static const String fullName = 'fullName';
  static const String email = 'email';
  static const String password = '_password';
  static const String createdAt = 'createdAt';
  static const String updateAt = 'updateAt';
}

class Usuario {
  final int id;
  final String? fullName;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Usuario({
    required this.id,
    this.fullName,
    required this.email,
    required this.password,
    required this.createdAt,
    this.updatedAt,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json[UsuarioFields.id] as int,
      fullName: json[UsuarioFields.fullName] as String?,
      email: json[UsuarioFields.email] as String,
      password: json[UsuarioFields.password] as String,
      createdAt: DateTime.parse(json[UsuarioFields.createdAt] as String),
      updatedAt: json[UsuarioFields.updateAt] != null
          ? DateTime.parse(json[UsuarioFields.updateAt] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
      return {
          UsuarioFields.id: id,
          UsuarioFields.fullName: fullName,
          UsuarioFields.email: email,
          UsuarioFields.password: password,
          UsuarioFields.createdAt: createdAt.toIso8601String(),
          UsuarioFields.updateAt: updatedAt?.toIso8601String(),

      };
  }

}
