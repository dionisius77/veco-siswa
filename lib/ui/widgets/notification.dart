import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_bloc.dart';
// import 'package:veco_siswa/blocs/notifBloc/notif_event.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_state.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {Key key, @required this.open, @required this.size, @required this.email})
      : super(key: key);
  final bool open;
  final Size size;
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifBloc, NotifState>(
      builder: (context, state) {
        if (state is NotifLoadingState) {
          // BlocProvider.of<NotifBloc>(context).add(FetchNotification(email));
          print(state);
        }
        final notifs = (state as NotifLoadedState).notifications;
        List<Widget> listNotif;
        if(notifs != null) {
          notifs.map((notif) => 
            listNotif.add(
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(notif.title),
                subtitle: Text(notif.message),
                onTap: () {},
              ),
            )
          );
        }
        print(notifs);
        return Positioned(
          top: 40,
          right: 20,
          child: IgnorePointer(
            ignoring: !open,
            child: AnimatedOpacity(
              opacity: open ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(-5, 5), // changes position of shadow
                    ),
                  ],
                ),
                height: size.height * .5,
                width: size.width * .8,
                child: ListView(
                    children: listNotif,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
