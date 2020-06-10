import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/nilaiBloc/nilai_bloc.dart';
import 'package:veco_siswa/blocs/nilaiBloc/nilai_event.dart';
import 'package:veco_siswa/blocs/nilaiBloc/nilai_state.dart';
import 'package:veco_siswa/models/models.dart';
import 'package:veco_siswa/repositories/nilai_repository.dart';
import 'package:veco_siswa/ui/pages/detail_nilai_page.dart';

class LandingNilai extends StatelessWidget {
  final NilaiRepository nilaiRepository = NilaiRepository();
  final User userdetail;

  LandingNilai({@required this.userdetail});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NilaiBloc(nilaiRepository: nilaiRepository),
      child: LandingNilaiWithState(
        userDetail: userdetail,
      ),
    );
  }
}

class LandingNilaiWithState extends StatefulWidget {
  final User userDetail;
  LandingNilaiWithState({@required this.userDetail});

  @override
  _LandingNilaiState createState() => _LandingNilaiState();
}

class _LandingNilaiState extends State<LandingNilaiWithState> {
  NilaiBloc nilaiBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nilaiBloc = BlocProvider.of<NilaiBloc>(context);
    return Container(
      child: BlocBuilder<NilaiBloc, NilaiState>(
        builder: (context, state) {
          var returned;
          if (state is NilaiInitialState) {
            nilaiBloc.add(OnInitNilai(nik: widget.userDetail.nik));
            returned = Container();
          } else if (state is NilaiLoadingState) {
            returned = Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NilaiSuccessState) {
            returned = ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: buildList(state.kelas, state.listMapel, context)),
                ),
              ],
            );
          } else if (state is NilaiFailureState) {
            returned = Container(
              child: Center(
                child: Text(state.errorMessage),
              ),
            );
          }
          return returned;
        },
      ),
    );
  }

  List<Widget> buildList(String kelas, List list, context) {
    List<Widget> returned = [];
    for (var item in list) {
      returned.add(
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
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
            title: Text(
              item,
              style: TextStyle(
                fontSize: 23,
                fontFamily: "Cartoonist",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailNilaiPage(
                  mapel: item,
                  userDetail: widget.userDetail,
                  kelas: kelas,
                );
              }));
            },
          ),
        ),
      );
    }
    return returned;
  }
}
