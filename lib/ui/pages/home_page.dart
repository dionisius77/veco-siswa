import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_bloc.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_event.dart';
import 'package:veco_siswa/blocs/notifBloc/notif_state.dart';
import 'package:veco_siswa/models/models.dart';
import 'package:veco_siswa/repositories/notif_repository.dart';
import 'package:veco_siswa/repositories/user_repository.dart';
import 'package:veco_siswa/ui/pages/jadwal_page.dart';
import 'package:veco_siswa/ui/pages/kbm_page.dart';
import 'package:veco_siswa/ui/pages/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:veco_siswa/ui/pages/settings_page.dart';

import 'landing_nilai_page.dart';
// import 'package:veco_siswa/ui/widgets/notification.dart';

class HomePageParent extends StatelessWidget {
  final FirebaseUser user;
  final UserRepository userRepository;
  final NotifRepository notifRepository = NotifRepository();
  final User userDetail;

  HomePageParent(
      {@required this.user,
      @required this.userDetail,
      @required this.userRepository});

  @override
  Widget build(BuildContext context) {
    // return HomePage(
    //     user: user, userDetail: userDetail, userRepository: userRepository);
    return BlocProvider(
      create: (context) => NotifBloc(notifRepository: notifRepository),
      child: HomePage(
          user: user, userDetail: userDetail, userRepository: userRepository),
    );
  }
}

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  final UserRepository userRepository;
  final User userDetail;

  HomePage(
      {@required this.user,
      @required this.userDetail,
      @required this.userRepository});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HomePageBloc homePageBloc;
  int currentTab = 0;

  LandingPage landingPage;
  SettingsPageParent settingsPage;
  JadwalPage jadwalPage;
  KBMPage kbmPage;
  LandingNilai landingNilai;
  List<Widget> pages;
  Widget currentPage;
  List<String> pagesName;
  bool open = false;
  NotifRepository notifRepository = NotifRepository();

  @override
  void initState() {
    landingNilai = LandingNilai(userdetail: widget.userDetail);
    landingPage = LandingPage(widget.user);
    jadwalPage = JadwalPage(userDetail: widget.userDetail);
    settingsPage = SettingsPageParent(
        user: widget.user, userRepository: widget.userRepository);
    kbmPage = KBMPage(userDetail: widget.userDetail);

    pages = [landingPage, jadwalPage, kbmPage, landingNilai, settingsPage];
    pagesName = ['Home', 'Jadwal', 'KBM', 'Nilai', 'Settings'];

    currentPage = landingPage;
    BlocProvider.of<NotifBloc>(context)
        .add(FetchNotification(widget.userDetail.email));
    super.initState();
  }

  Widget titleHeader(int clickedTab) {
    return TitlePage(
      title: pagesName[clickedTab],
    );
  }

  int getTotalUnread(listNotif) {
    var opened = listNotif.where((e) => !e.opened);
    return opened.length;
  }

  void processNotif(Notif notif) {
    switch (notif.notifId) {
      case 11:
        setState(() {
          currentTab = 1;
          currentPage = pages[1];
          open = false;
        });
        return BlocProvider.of<NotifBloc>(context).add(EditNotif(notif.uniqueId));
      case 12:
        setState(() {
          currentTab = 2;
          currentPage = pages[2];
          open = false;
        });
        return BlocProvider.of<NotifBloc>(context).add(EditNotif(notif.uniqueId));
      case 13:
        setState(() {
          currentTab = 3;
          currentPage = pages[3];
          open = false;
        });
        return BlocProvider.of<NotifBloc>(context).add(EditNotif(notif.uniqueId));
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // homePageBloc = BlocProvider.of<HomePageBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SafeArea(
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Color(0xFFABF0eE),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "VeCo School",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Stack(
                                children: <Widget>[
                                  IconButton(
                                    color: Color(0xFFEE8572),
                                    iconSize: 30,
                                    icon: Icon(Icons.notifications),
                                    onPressed: () {
                                      setState(() {
                                        open = !open;
                                      });
                                    },
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 18,
                                        minHeight: 18,
                                      ),
                                      child: BlocBuilder<NotifBloc, NotifState>(
                                        builder: (context, state) {
                                          int totalNotif = 0;
                                          if (state is NotifLoadedState) {
                                            var opened = getTotalUnread(
                                                state.notifications);
                                            totalNotif = opened;
                                          }
                                          return Text(
                                            totalNotif.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      color: Colors.white,
                      height: size.height * .90,
                      child: currentPage,
                    ),
                  ],
                ),
              ),
              BlocBuilder<NotifBloc, NotifState>(
                builder: (context, state) {
                  var notifs;
                  if (state is NotifLoadedState) {
                    notifs = state.notifications;
                  }
                  return Positioned(
                    top: 40,
                    right: 20,
                    child: IgnorePointer(
                      ignoring: !open,
                      child: AnimatedOpacity(
                        opacity: open ? 1 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset:
                                    Offset(-5, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          height: size.height * .5,
                          width: size.width * .8,
                          child: notifs != null && notifs.length != 0
                              ? ListView(children: buildListNotif(notifs))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text('Tidak ada pemberitahuan'),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.library_add,
            color: Colors.black54,
          ),
          backgroundColor: Color(0xFFABF0eE),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFEE8572),
          currentIndex: currentTab,
          selectedIconTheme: IconThemeData(color: Colors.pink[100]),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              currentTab = index;
              currentPage = pages[index];
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home', style: TextStyle(color: Colors.white)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Jadwal', style: TextStyle(color: Colors.white)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              title: Text('KBM', style: TextStyle(color: Colors.white)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_shared),
              title: Text('Nilai', style: TextStyle(color: Colors.white)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildListNotif(notifs) {
    List<Widget> returned = [];
    var reversed = notifs.reversed;
    for (var notif in reversed) {
      returned.add(
        Container(
          color: notif.opened ? Colors.white : Colors.yellow[50],
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(notif.title),
            subtitle: Text(notif.message),
            trailing: notif.hasAction
                ? Icon(Icons.keyboard_arrow_right)
                : Container(),
            dense: true,
            onTap: () => processNotif(notif),
          ),
        ),
      );
    }
    return returned;
  }
}

class TitlePage extends StatelessWidget {
  final String title;
  TitlePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(fontSize: 24, color: Colors.pinkAccent));
  }
}
