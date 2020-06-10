import 'package:flutter/material.dart';

class CardMading extends StatelessWidget {
  final String imageUrl, nama, email, avatar;
  final int likes, comments;
  final String defaultAvatar =
      'https://firebasestorage.googleapis.com/v0/b/veco-school.appspot.com/o/profilePicture%2FdefaultAvatar.jpg?alt=media&token=b4c989c2-df50-42af-a352-991e0469c74a';

  CardMading(
      {@required this.imageUrl,
      @required this.nama,
      @required this.email,
      @required this.comments,
      @required this.likes,
      @required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: Image.network(
                          avatar != null ? avatar : defaultAvatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            nama,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 175,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 25,
                            ),
                            SizedBox(width: 4),
                            Text(
                              likes.toString(),
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.black,
                              size: 25,
                            ),
                            SizedBox(width: 4),
                            Text(
                              comments.toString(),
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
