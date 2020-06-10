import 'package:equatable/equatable.dart';

abstract class KBMEvent extends Equatable {}

class CallKBM extends KBMEvent {
  final String nik;
  CallKBM(this.nik);
  @override
  List<Object> get props => [nik];
}
