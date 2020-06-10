import 'package:equatable/equatable.dart';
import 'package:veco_siswa/models/models.dart';

abstract class NotifState extends Equatable {}

class NotifLoadingState extends NotifState {
  @override
  List<Object> get props => null;
}

class NotifLoadedState extends NotifState {
  final List<Notif> notifications;
  final int totalNotif;

  NotifLoadedState(this.notifications, this.totalNotif);

  @override
  List<Object> get props => [notifications, totalNotif];
}