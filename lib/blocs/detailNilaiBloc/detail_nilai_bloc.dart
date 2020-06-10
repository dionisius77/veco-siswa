import 'package:meta/meta.dart';
import 'package:veco_siswa/blocs/detailNilaiBloc/detail_nilai_state.dart';
import 'package:veco_siswa/blocs/detailNilaiBloc/detail_nilai_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/repositories/nilai_repository.dart';

class DetailNilaiBloc extends Bloc<DetailNilaiEvent, DetailNilaiState> {
  NilaiRepository nilaiRepository;
  DetailNilaiBloc({@required NilaiRepository nilaiRepository}) {
    this.nilaiRepository = nilaiRepository;
  }

  @override
  DetailNilaiState get initialState => DetailNilaiInitialState();

  @override
  Stream<DetailNilaiState> mapEventToState(
    DetailNilaiEvent event,
  ) async* {
    if (event is GetDataNilai) {
      yield DetailNilaiLoadingState();
      try {
        var resultNilai = await nilaiRepository.getListNilai(
            event.nik, event.mapel, event.kelas);
        if (resultNilai['isExists']) {
          yield DetailNilaiSuccessState(resultNilai['listNilai']);
        } else {
          yield DetailNilaiFailureState(resultNilai['message']);
        }
      } catch (e) {
        yield DetailNilaiFailureState('Terjadi kesalahan saat mengambil data');
      }
    }
  }
}
