import 'package:meta/meta.dart';
import '../entities/entites.dart';

@immutable
class User {
  final String nis;
  final String nik;
  final bool active;
  final String email;
  final String role;

  User({this.nis, this.nik, this.active, this.email, this.role});

  UserEntity toEntity() {
    return UserEntity(nis, nik, active, email, role);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      nis: entity.nis,
      nik: entity.nik,
      active: entity.active,
      email: entity.email,
      role: entity.role,
    );
  }
}