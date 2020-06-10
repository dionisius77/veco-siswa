import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonPressed extends LoginEvent {
  final String email, password;

  LoginButtonPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
