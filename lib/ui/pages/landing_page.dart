import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veco_siswa/ui/widgets/card_mading.dart';

class LandingPage extends StatefulWidget {
  final FirebaseUser user;

  LandingPage(this.user);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Stack(
          children: [
            Container(
              height: 275,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFABF0eE),
              child: Image(
                image: AssetImage("images/jadwal.png"),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Welcome to VeCo School",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                        fontFamily: "Geometry",
                      ),
                    ),
                  ),
                  Container(
                    height: 115,
                  ),
                  Container(
                    height: 300,
                    child: PageView(
                      controller:
                          PageController(initialPage: 0, viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CardMading(
                                nama: 'Dionisius Aditya Octa Nugraha',
                                email: 'dionisiusadityaoctanugraha@gmail.com',
                                avatar: widget.user.photoUrl,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/global_image%2Fcikutz.png?alt=media&token=51088d33-7fe5-4765-8011-37ad5e4a4f8f',
                                comments: 20,
                                likes: 40,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CardMading(
                                nama: 'Dionisius Aditya Octa Nugraha',
                                email: 'dionisiusadityaoctanugraha@gmail.com',
                                avatar: widget.user.photoUrl,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/global_image%2Fcikutz.png?alt=media&token=51088d33-7fe5-4765-8011-37ad5e4a4f8f',
                                comments: 20,
                                likes: 40,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CardMading(
                                nama: 'Dionisius Aditya Octa Nugraha',
                                email: 'dionisiusadityaoctanugraha@gmail.com',
                                avatar: widget.user.photoUrl,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/global_image%2Fcikutz.png?alt=media&token=51088d33-7fe5-4765-8011-37ad5e4a4f8f',
                                comments: 20,
                                likes: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.black45,
                    height: 300,
                    child: PageView(
                      controller:
                          PageController(initialPage: 1, viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CardMading(
                                nama: 'Dionisius Aditya Octa Nugraha',
                                email: 'dionisiusadityaoctanugraha@gmail.com',
                                avatar: widget.user.photoUrl,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/global_image%2Fcikutz.png?alt=media&token=51088d33-7fe5-4765-8011-37ad5e4a4f8f',
                                comments: 20,
                                likes: 40,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CardMading(
                                nama: 'Dionisius Aditya Octa Nugraha',
                                email: 'dionisiusadityaoctanugraha@gmail.com',
                                avatar: widget.user.photoUrl,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/global_image%2Fcikutz.png?alt=media&token=51088d33-7fe5-4765-8011-37ad5e4a4f8f',
                                comments: 20,
                                likes: 40,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CardMading(
                                nama: 'Dionisius Aditya Octa Nugraha',
                                email: 'dionisiusadityaoctanugraha@gmail.com',
                                avatar: widget.user.photoUrl,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/global_image%2Fcikutz.png?alt=media&token=51088d33-7fe5-4765-8011-37ad5e4a4f8f',
                                comments: 20,
                                likes: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
