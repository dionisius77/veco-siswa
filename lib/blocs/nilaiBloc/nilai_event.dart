import 'package:equatable/equatable.dart';

abstract class NilaiEvent extends Equatable {}

class OnInitNilai extends NilaiEvent {
  final String nik;
  OnInitNilai({this.nik});
  @override
  List<Object> get props => [nik];
}
