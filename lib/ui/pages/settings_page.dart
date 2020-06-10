import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/homeBloc/home_page_bloc.dart';
import 'package:veco_siswa/blocs/homeBloc/home_page_event.dart';
import 'package:veco_siswa/blocs/homeBloc/home_page_state.dart';
import 'package:veco_siswa/repositories/user_repository.dart';
import 'package:veco_siswa/ui/pages/login_page.dart';

class SettingsPageParent extends StatelessWidget {
  final FirebaseUser user;
  final UserRepository userRepository;

  SettingsPageParent({@required this.user, @required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(userRepository: userRepository),
      child: SettingsPage(user),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final FirebaseUser user;

  SettingsPage(this.user);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserRepository userRepository = UserRepository();
  HomePageBloc homePageBloc;
  String imageUrl = '';

  @override
  void initState() {
    imageUrl = widget.user.photoUrl;
    super.initState();
  }

  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPageParent(userRepository: userRepository);
    }));
  }

  @override
  Widget build(BuildContext context) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is LogOutSuccessState) {
            navigateToSignInPage(context);
          }
        },
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/profilePicture%2FYszjxVynytRo4ZeG73ozkEnYbMi2?alt=media&token=de75729e-28b5-4e7e-86d7-aaad214657eb',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: DraggableScrollableSheet(
                minChildSize: 0.22,
                initialChildSize: 0.22,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: (size.height * .83)),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: 32,
                              right: 32,
                              top: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/profilePicture%2FYszjxVynytRo4ZeG73ozkEnYbMi2?alt=media&token=de75729e-28b5-4e7e-86d7-aaad214657eb',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nama",
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontFamily: "Roboto",
                                              fontSize: 36,
                                              fontWeight: FontWeight.w700)),
                                      Text(widget.user.email,
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontFamily: "Roboto",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.pinkAccent,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4,
                            margin:
                                EdgeInsets.only(top: 40, left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.lock_outline,
                                    color: Colors.pinkAccent,
                                  ),
                                  title: Text("Ganti Password"),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.exit_to_app,
                                    color: Colors.pinkAccent,
                                  ),
                                  title: Text("Logout"),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () => homePageBloc.add(LogOutEvent()),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
