import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotifEntity extends Equatable {
  final String title, message, uniqueId;
  final bool hasAction, opened;
  final int notifId;
  // final DateTime createdAt;

  NotifEntity(this.title, this.message, this.hasAction, this.opened,
      this.notifId, this.uniqueId
      // this.createdAt
      );

  static NotifEntity fromSnapshot(DocumentSnapshot snap) {
    return NotifEntity(
      snap.data['title'],
      snap.data['message'],
      snap.data['hasAction'],
      snap.data['opened'],
      snap.data['notifId'],
      snap.documentID,
      // snap.data['createdAt'],
    );
  }

  @override
  List<Object> get props =>
      [title, message, hasAction, opened, notifId,
      // createdAt
      ];
}
