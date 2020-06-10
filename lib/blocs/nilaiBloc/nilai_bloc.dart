import 'package:meta/meta.dart';
import 'package:veco_siswa/repositories/nilai_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veco_siswa/blocs/nilaiBloc/nilai_event.dart';
import 'package:veco_siswa/blocs/nilaiBloc/nilai_state.dart';


class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiRepository nilaiRepository;
  NilaiBloc({@required NilaiRepository nilaiRepository}){
    this.nilaiRepository = nilaiRepository;
  }
  @override
  NilaiState get initialState => NilaiInitialState();

  @override
  Stream<NilaiState> mapEventToState(
    NilaiEvent event,
  ) async* {
    if(event is OnInitNilai){
      yield NilaiLoadingState();
      try {
        var resultMapel = await nilaiRepository.getListMapel(event.nik);
        if(resultMapel['isExists']){
          yield NilaiSuccessState(resultMapel['listMapel'], resultMapel['kelas']);
        } else {
          yield NilaiFailureState(resultMapel['message']);
        }
      } catch (e) {
      }
    }
  }
}
