import 'package:equatable/equatable.dart';

abstract class KBMState extends Equatable {}

class KBMInitState extends KBMState {
  @override
  List<Object> get props => null;
}

class KBMOnLoadingState extends KBMState {
  @override
  List<Object> get props => null;
}

class KBMSuccessState extends KBMState {
  final Map kbm;

  KBMSuccessState(this.kbm);
  @override
  List<Object> get props => [kbm];
}

class KBMFailureState extends KBMState {
  final String errorMessage;

  KBMFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}