import 'package:veco_siswa/blocs/authBloc/auth_event.dart';
import 'package:veco_siswa/blocs/authBloc/auth_state.dart';
import 'package:veco_siswa/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;

  AuthBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        var isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          var user = await userRepository.getCurrentUser();
          var userDetail = await userRepository.getUserDetail(user.email);
          if(userDetail != null){
            await userRepository.signOut();
            yield AuthenticatedState(user, userDetail);
          } else {
            yield UnauthenticatedState();
          }
        } else {
          yield UnauthenticatedState();
        }
      } catch (e) {
        yield UnauthenticatedState();
      }
    }
  }
}
