import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';
import 'package:veco_siswa/models/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthenticatedState extends AuthState {
  final FirebaseUser user;
  final User userDetail;

  AuthenticatedState(this.user, this.userDetail);

  @override
  List<Object> get props => [user, userDetail];
}

class UnauthenticatedState extends AuthState {
  @override
  List<Object> get props => null;
}
