import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:veco_siswa/blocs/kbmBloc/kbm_bloc.dart';
import 'package:veco_siswa/blocs/kbmBloc/kbm_event.dart';
import 'package:veco_siswa/blocs/kbmBloc/kbm_state.dart';
import 'package:veco_siswa/models/models.dart';
import 'package:veco_siswa/repositories/kbm_repository.dart';

class KBMPage extends StatelessWidget {
  final KBMRepository kbmRepository = KBMRepository();
  final User userDetail;

  KBMPage({@required this.userDetail});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KBMBloc(kbmRepository: kbmRepository),
      child: KBMPageContainer(
        userDetail: userDetail,
      ),
    );
  }
}

class KBMPageContainer extends StatefulWidget {
  final User userDetail;
  const KBMPageContainer({@required this.userDetail});

  @override
  _KBMPageState createState() => _KBMPageState();
}

class _KBMPageState extends State<KBMPageContainer> {
  KBMBloc _kbmBloc;

  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
  }

  List _selectedEvents;
  DateTime _selectedDay;

  Map<DateTime, List> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _kbmBloc = BlocProvider.of<KBMBloc>(context);
    return BlocBuilder<KBMBloc, KBMState>(
      builder: (context, state) {
        var returned;
        if (state is KBMInitState) {
          _kbmBloc.add(CallKBM(widget.userDetail.nik));
          returned = Container();
        } else if (state is KBMOnLoadingState) {
          returned = Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is KBMFailureState) {
          returned = Center(
            child: Text(state.errorMessage),
          );
        } else if (state is KBMSuccessState) {
          _events = state.kbm;
          returned = buildCalendar();
        }
        return returned;
      },
    );
  }

  Container buildCalendar() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Calendar(
              startOnMonday: true,
              weekDays: [
                "Senin",
                "Selasa",
                "Rabu",
                "Kamis",
                "Jumat",
                "Sabtu",
                "Minggu"
              ],
              events: _events,
              onRangeSelected: (range) =>
                  print("Range is ${range.from}, ${range.to}"),
              onDateSelected: (date) => _handleNewDate(date),
              isExpandable: false,
              isExpanded: true,
              eventDoneColor: Colors.green,
              selectedColor: Colors.brown[100],
              todayColor: Colors.yellow,
              eventColor: Colors.grey,
              dayOfWeekStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          _buildEventList(),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString()),
            onTap: () {},
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}
