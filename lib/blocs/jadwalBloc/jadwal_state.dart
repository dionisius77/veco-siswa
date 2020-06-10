import 'package:equatable/equatable.dart';

abstract class JadwalState extends Equatable {}

class JadwalInitialState extends JadwalState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class JadwalOnLoadingState extends JadwalState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class JadwalSuccessState extends JadwalState {
  final Map jadwal;
  
  JadwalSuccessState(this.jadwal);
  @override
  List<Object> get props => [jadwal];
}

class JadwalFailureState extends JadwalState {
  @override
  List<String> get props => ['fail'];
}
