import 'package:equatable/equatable.dart';
import 'package:veco_siswa/models/models.dart';

abstract class NotifEvent extends Equatable {}

class FetchNotification extends NotifEvent {
  // final List<Map> notifications;
  // final int totalNotif;
  final String email;
  FetchNotification(this.email);

  @override
  List<Object> get props => [email];
}

class UpdateNotif extends NotifEvent {
  final List<Notif> notifications;
  final int totalNotif;
  UpdateNotif(this.notifications, this.totalNotif);

  @override
  List<Object> get props => [notifications, totalNotif];
}

class EditNotif extends NotifEvent {
  final String idNotif;
  EditNotif(this.idNotif);

  @override
  List<Object> get props => [idNotif];
}