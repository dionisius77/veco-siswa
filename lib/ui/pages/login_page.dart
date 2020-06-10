import 'package:veco_siswa/blocs/loginBloc/login_bloc.dart';
import 'package:veco_siswa/blocs/loginBloc/login_event.dart';
import 'package:veco_siswa/blocs/loginBloc/login_state.dart';
import 'package:veco_siswa/models/models.dart';
import 'package:veco_siswa/repositories/user_repository.dart';
import 'package:veco_siswa/ui/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class LoginPageParent extends StatelessWidget {
  final UserRepository userRepository;

  LoginPageParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: LoginPAge(userRepository: userRepository),
    );
  }
}

class LoginPAge extends StatefulWidget {
  final UserRepository userRepository;

  LoginPAge({@required this.userRepository});

  @override
  _LoginPAgeState createState() => _LoginPAgeState();
}

class _LoginPAgeState extends State<LoginPAge> {
  final TextEditingController emailCntrlr = TextEditingController();

  final TextEditingController passCntrlr = TextEditingController();

  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      navigateToHomeScreen(context, state.user, state.userDetail);
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      var returned;
                      if (state is LoginInitialState) {
                        returned = buildInitialUi();
                      } else if (state is LoginLoadingState) {
                        returned = buildLoadingUi();
                      } else if (state is LoginFailState) {
                        returned = buildFailureUi(state.message);
                      } else if (state is LoginSuccessState) {
                        returned = Container();
                      }
                      return returned;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: emailCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: passCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Password",
                  ),
                  // keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15.0),
                  child: RaisedButton(
                    color: Colors.cyan,
                    child: Text("Login"),
                    textColor: Colors.white,
                    onPressed: () {
                      loginBloc.add(
                        LoginButtonPressed(
                          email: emailCntrlr.text,
                          password: passCntrlr.text,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  child: Text(
                    'Lupa password ?',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () => print('clicked lupa password'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInitialUi() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Enter Login Credentials",
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Fail $message",
            style: TextStyle(color: Colors.red),
          ),
        ),
        buildInitialUi(),
      ],
    );
  }

  void navigateToHomeScreen(BuildContext context, FirebaseUser user, User userDetail) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userDetail: userDetail, userRepository: widget.userRepository);
    }));
  }
}
