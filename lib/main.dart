import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:veco_siswa/blocs/authBloc/auth_bloc.dart';
import 'package:veco_siswa/blocs/authBloc/auth_state.dart';
import 'package:veco_siswa/repositories/user_repository.dart';
import 'package:veco_siswa/ui/pages/home_page.dart';
import 'package:veco_siswa/ui/pages/login_page.dart';
import 'package:veco_siswa/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authBloc/auth_event.dart';
import 'package:meta/meta.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository userRepository = UserRepository();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        AudioCache player = new AudioCache();
        const notifAudio = "sounds/juntos.mp3";
        player.play(notifAudio);
      },
      // onBackgroundMessage: onBackgroundMessage,
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
    );

    // For testing purposes print the Firebase Messaging token
    _firebaseMessaging.getToken().then((token) {
      print("FirebaseMessaging token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            AuthBloc(userRepository: userRepository)..add(AppStartedEvent()),
        child: Appp(
          userRepository: userRepository,
        ),
      ),
    );
  }
}

class Appp extends StatelessWidget {
  final UserRepository userRepository;

  Appp({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        var returned;
        if (state is AuthInitialState) {
          returned = SplashPage();
        } else if (state is AuthenticatedState) {
          returned = HomePageParent(
              user: state.user,
              userDetail: state.userDetail,
              userRepository: userRepository);
        } else if (state is UnauthenticatedState) {
          returned = LoginPageParent(userRepository: userRepository);
        }
        return returned;
      },
    );
  }
}
