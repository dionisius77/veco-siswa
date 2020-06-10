import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/detailNilaiBloc/detail_nilai_bloc.dart';
import 'package:veco_siswa/blocs/detailNilaiBloc/detail_nilai_event.dart';
import 'package:veco_siswa/blocs/detailNilaiBloc/detail_nilai_state.dart';
import 'package:veco_siswa/models/models.dart';
import 'package:veco_siswa/repositories/nilai_repository.dart';

class DetailNilaiPage extends StatelessWidget {
  final NilaiRepository nilaiRepository = NilaiRepository();
  final String kelas;
  final String mapel;
  final User userDetail;
  DetailNilaiPage(
      {@required this.mapel, @required this.userDetail, @required this.kelas});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailNilaiBloc(nilaiRepository: nilaiRepository),
        child: DetailNilaiPageWithState(
            mapel: mapel, userDetail: userDetail, kelas: kelas));
  }
}

class DetailNilaiPageWithState extends StatefulWidget {
  final String kelas;
  final String mapel;
  final User userDetail;
  DetailNilaiPageWithState(
      {@required this.mapel, @required this.userDetail, @required this.kelas});

  @override
  _DetailNilaiPageState createState() => _DetailNilaiPageState();
}

class _DetailNilaiPageState extends State<DetailNilaiPageWithState>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  DetailNilaiBloc detailNilaiBloc;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    detailNilaiBloc = BlocProvider.of<DetailNilaiBloc>(context);
    String nik = widget.userDetail.nik;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .065,
              color: Color(0xFFABF0eE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    color: Color(0xFFEE8572),
                    iconSize: 30,
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "VeCo School",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFABF0eE),
              height: MediaQuery.of(context).size.height * .065,
              child: TabBar(
                indicatorColor: Color(0xFFEE8572),
                unselectedLabelColor: Colors.black45,
                labelColor: Colors.black,
                controller: tabController,
                tabs: <Widget>[
                  Center(child: Text('Ulangan harian')),
                  Center(child: Text('Tugas')),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .830,
              color: Colors.white,
              child: BlocBuilder<DetailNilaiBloc, DetailNilaiState>(
                builder: (context, state) {
                  var returned;
                  if (state is DetailNilaiInitialState) {
                    detailNilaiBloc.add(GetDataNilai(
                        kelas: widget.kelas, nik: nik, mapel: widget.mapel));
                    returned = Container();
                  } else if (state is DetailNilaiLoadingState) {
                    returned = Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DetailNilaiSuccessState) {
                    returned = TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  children: buildList(state.listNilai,
                                      widget.mapel, 'Ulangan Harian')),
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  children: buildList(
                                      state.listNilai, widget.mapel, 'Tugas')),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is DetailNilaiFailureState) {
                    returned = Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  return returned;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildList(List rawList, String mapel, String jenis) {
    List<Widget> list = [];
    for (var item in rawList) {
      String kegiatan = item['kegiatan'];
      String title = item['title'];
      if (kegiatan == jenis) {
        list.add(
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: int.parse(item['nilai']) > 60
                  ? Colors.green[200]
                  : Colors.red[200],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              leading: int.parse(item['nilai']) >= 60
                  ? Icon(Icons.check)
                  : Icon(Icons.close),
              title: Text('$kegiatan $mapel $title'),
              trailing: Text(
                item['nilai'],
                style: int.parse(item['nilai']) > 60
                    ? TextStyle(color: Colors.black)
                    : TextStyle(color: Colors.red),
              ),
            ),
          ),
        );
      }
    }
    return list;
  }
}
