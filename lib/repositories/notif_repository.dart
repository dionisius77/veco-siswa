import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veco_siswa/entities/entites.dart';
import 'package:veco_siswa/models/models.dart';

class NotifRepository {
  Firestore firestore;

  NotifRepository() {
    this.firestore = Firestore.instance;
  }
  // final notifCollection = Firestore.instance.collection('notification');

  Stream<List<Notif>> getNotification(String email) {
    var sevenDaysBefore =
        new DateTime.now().add(new Duration(days: -5));
    return firestore
        .collection('notification')
        .where("createdAt", isGreaterThanOrEqualTo: sevenDaysBefore)
        .where("for", isEqualTo: email)
        .snapshots().map((snapshot){
          return snapshot.documents
            .map((doc) => Notif.fromEntity(NotifEntity.fromSnapshot(doc))).toList();
        });
  }

  Future<void> editNotification(String idNotif) {
    return firestore.collection('notification').document(idNotif).updateData({"opened": true});
  }
}
