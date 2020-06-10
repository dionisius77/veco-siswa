import 'package:equatable/equatable.dart';

abstract class NilaiState extends Equatable {}

class NilaiInitialState extends NilaiState {
  @override
  List<Object> get props => [];
}

class NilaiLoadingState extends NilaiState {
  @override
  List<Object> get props => [];
}

class NilaiSuccessState extends NilaiState {
  final List listMapel;
  final String kelas;

  NilaiSuccessState(this.listMapel, this.kelas);
  @override
  List<Object> get props => [listMapel, kelas];
}

class NilaiFailureState extends NilaiState {
  final String errorMessage;

  NilaiFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
