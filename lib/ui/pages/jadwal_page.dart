import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/jadwalBloc/jadwal_bloc.dart';
import 'package:veco_siswa/blocs/jadwalBloc/jadwal_event.dart';
import 'package:veco_siswa/blocs/jadwalBloc/jadwal_state.dart';
import 'package:veco_siswa/models/models.dart';
import 'package:veco_siswa/repositories/jadwal_repository.dart';

class JadwalPage extends StatelessWidget {
  final JadwalRepository jadwalRepository = JadwalRepository();
  final User userDetail;

  JadwalPage({@required this.userDetail});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JadwalBloc(jadwalRepository: jadwalRepository),
      child: JadwalPageStateful(
        userDetail: userDetail,
      ),
    );
  }
}

class JadwalPageStateful extends StatefulWidget {
  final User userDetail;
  const JadwalPageStateful({@required this.userDetail});

  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPageStateful> {
  JadwalBloc jadwalBloc;
  @override
  void initState() {
    // jadwalBloc.add(OnInitJadwal(nik: widget.userDetail.nik));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    jadwalBloc = BlocProvider.of<JadwalBloc>(context);
    return Container(
      child: BlocBuilder<JadwalBloc, JadwalState>(
        builder: (context, state) {
          var returned;
          if (state is JadwalInitialState) {
            jadwalBloc.add(OnInitJadwal(nik: widget.userDetail.nik));
            returned = Container();
          } else if (state is JadwalOnLoadingState) {
            returned = buildLoadingUi();
          } else if (state is JadwalSuccessState) {
            returned = buildJadwal(state.jadwal);
          } else if (state is JadwalFailureState) {
            returned = Container();
          }
          return returned;
        },
      ),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  List<Widget> detail(List jadwal) {
    List<Widget> returned = [];
    for (var item in jadwal) {
      if (item != null) {
        returned.add(Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item['matapelajaran'],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Cartoonist",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  item['guru'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Cartoonist",
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    }
    return returned;
  }

  Widget buildJadwal(jadwal) {
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 5),
                      child: Text(
                        "VIII-A 2020",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Cartoonist"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Text(
                        "Goldy Yoshiko Herman",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            fontFamily: "Cartoonist"),
                      ),
                    ),
                  ),
                  Container(height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.pink[100],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Senin',
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: "Cartoonist",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                              ),
                            ),
                            children: detail(jadwal['senin']),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Selasa',
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: "Cartoonist",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                              ),
                            ),
                            children: detail(jadwal['selasa']),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Rabu',
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: "Cartoonist",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                              ),
                            ),
                            children: detail(jadwal['rabu']),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.yellow[100],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Kamis',
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: "Cartoonist",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                              ),
                            ),
                            children: detail(jadwal['kamis']),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'Jumat',
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: "Cartoonist",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                              ),
                            ),
                            children: detail(jadwal['jumat']),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
