import 'package:equatable/equatable.dart';

abstract class JadwalEvent extends Equatable {}

class OnInitJadwal extends JadwalEvent {
  final String nik;
  OnInitJadwal({this.nik});
  @override
  List<Object> get props => [nik];
}