import 'package:equatable/equatable.dart';

abstract class DetailNilaiState extends Equatable {}

class DetailNilaiInitialState extends DetailNilaiState {
  @override
  List<Object> get props => [];
}

class DetailNilaiLoadingState extends DetailNilaiState {
  @override
  List<Object> get props => [];
}

class DetailNilaiSuccessState extends DetailNilaiState {
  final List listNilai;
  DetailNilaiSuccessState(this.listNilai);
  @override
  List<Object> get props => [listNilai];
}

class DetailNilaiFailureState extends DetailNilaiState {
  final String errorMessage;
  DetailNilaiFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
