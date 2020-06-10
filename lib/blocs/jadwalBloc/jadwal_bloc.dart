import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:veco_siswa/blocs/jadwalBloc/jadwal_event.dart';
import 'package:veco_siswa/blocs/jadwalBloc/jadwal_state.dart';
import 'package:veco_siswa/repositories/jadwal_repository.dart';

class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  JadwalRepository jadwalRepository;
  JadwalBloc({@required JadwalRepository jadwalRepository}){
    this.jadwalRepository = jadwalRepository;
  }
  @override
  JadwalState get initialState => JadwalInitialState();

  @override
  Stream<JadwalState> mapEventToState(JadwalEvent event) async* {
    if (event is OnInitJadwal) {
      yield JadwalOnLoadingState();
      try {
        var resultJadwal = await jadwalRepository.getJadwal(event.nik);
        yield JadwalSuccessState(resultJadwal);
      } catch (e) {
        yield JadwalFailureState();
      }
    }
  }
}
