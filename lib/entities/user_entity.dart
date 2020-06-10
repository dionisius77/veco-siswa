import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String nis;
  final String nik;
  final bool active;
  final String email;
  final String role;
  
  UserEntity(this.nis, this.nik, this.active, this.email, this.role);

  Map<String, Object> toJson() {
    return {
      'nis': nis,
      'nik': nik,
      'active': active,
      'email': email,
      'role': role
    };
  }

  @override
  String toString() {
    return 'UserEntity { nis: $nis, nik: $nik, active: $active, email: $email, role: $role }';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json['nis'] as String,
      json['nik'] as String,
      json['active'] as bool,
      json['email'] as String,
      json['role'] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.data['nis'].toString(),
      snap.data['nik'].toString(),
      snap.data['active'],
      snap.data['email'],
      snap.data['role'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'nis': nis,
      'nik': nik,
      'active': active,
      'email': email,
      'role': role,
    };
  }

  @override
  List<Object> get props => [nis, nik, active, email, role];
}