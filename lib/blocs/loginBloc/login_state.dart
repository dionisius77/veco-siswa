import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';
import 'package:veco_siswa/models/user.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => null;
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => null;
}

class LoginSuccessState extends LoginState {

  final FirebaseUser user;
  final User userDetail;

  LoginSuccessState(this.user, this.userDetail);

  @override
  List<Object> get props => [user, userDetail];
}

class LoginFailState extends LoginState {

  final String message;

  LoginFailState(this.message);

  @override
  List<Object> get props => [message];
}