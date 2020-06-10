import 'package:meta/meta.dart';
import '../entities/entites.dart';

@immutable
class Notif {
  final String title, message, uniqueId;
  final bool hasAction, opened;
  final int notifId;
  // final DateTime createdAt;

  Notif({this.title, this.message, this.hasAction, this.opened,
      this.notifId, this.uniqueId
      // this.createdAt
      });

  static Notif fromEntity(NotifEntity entity) {
    return Notif(
      title: entity.title,
      message: entity.message,
      hasAction: entity.hasAction,
      opened: entity.opened,
      notifId: entity.notifId,
      uniqueId: entity.uniqueId
      // createdAt: entity.createdAt,
    );
  }
}