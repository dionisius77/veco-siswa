import 'package:equatable/equatable.dart';

abstract class DetailNilaiEvent extends Equatable {}

class GetDataNilai extends DetailNilaiEvent {
  final String kelas, nik, mapel;
  GetDataNilai({this.kelas, this.nik, this.mapel});
  @override
  List<Object> get props => [nik, kelas, mapel];
}