import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_event.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_state.dart';
import 'package:veco_siswa/repositories/notif_repository.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  NotifRepository _repository = NotifRepository();
  StreamSubscription _notifSubcription;

  NotifBloc({@required NotifRepository notifRepository})
      : assert(notifRepository != null),
        _repository = notifRepository;

  @override
  NotifState get initialState => NotifLoadingState();

  @override
  Stream<NotifState> mapEventToState(NotifEvent event) async* {
    if (event is FetchNotification) {
      _notifSubcription?.cancel();
      _notifSubcription =
          _repository.getNotification(event.email).listen((notifs) {
        add(UpdateNotif(notifs, notifs.length));
      });
    } else if (event is UpdateNotif) {
      yield NotifLoadedState(event.notifications, event.totalNotif);
    } else if(event is EditNotif){
      await _repository.editNotification(event.idNotif);
    }
  }

  // @override
  // void dispose() {
  //   _notifSubcription?.cancel();
  //   super.dispose();
  // }
}
