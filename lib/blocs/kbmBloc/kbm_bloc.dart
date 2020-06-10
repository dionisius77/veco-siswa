import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:veco_siswa/blocs/kbmBloc/kbm_event.dart';
import 'package:veco_siswa/blocs/kbmBloc/kbm_state.dart';
import 'package:veco_siswa/repositories/kbm_repository.dart';

class KBMBloc extends Bloc<KBMEvent, KBMState> {
  KBMRepository kbmRepository;
  KBMBloc({@required KBMRepository kbmRepository}) {
    this.kbmRepository = kbmRepository;
  }
  @override
  KBMState get initialState => KBMInitState();

  @override
  Stream<KBMState> mapEventToState(KBMEvent event) async* {
    if (event is CallKBM) {
      yield KBMOnLoadingState();
      Map<DateTime, List> events = new Map();
      try {
        var resultKBM = await kbmRepository.getKBM(event.nik);
        if (resultKBM['hasAssigned'] && resultKBM['isExists']) {
          var rawKbm = resultKBM['listKBM'];
          for(var key in rawKbm.keys){
            events[DateTime.parse(key)] = rawKbm[key];
          }
          yield KBMSuccessState(events);
        } else {
          yield KBMFailureState(resultKBM['message']);
        }
      } catch (e) {
        yield KBMFailureState('Terjadi kesalahan saat mengambil data');
      }
    }
  }
}
