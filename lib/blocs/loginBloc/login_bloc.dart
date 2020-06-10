import 'package:veco_siswa/blocs/loginBloc/login_event.dart';
import 'package:veco_siswa/blocs/loginBloc/login_state.dart';
import 'package:veco_siswa/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      try {
        var user = await userRepository.signInEmailAndPassword(
            event.email, event.password);
        var userDetail = await userRepository.getUserDetail(event.email);
        if (userDetail != null) {
          if (userDetail.role == 'student') {
            yield LoginSuccessState(user, userDetail);
          } else {
            await userRepository.signOut();
            yield LoginFailState("ERROR_USER_NOT_FOUND");
          }
        } else {
          await userRepository.signOut();
          yield LoginFailState("ERROR_USER_NOT_FOUND");
        }
      } catch (e) {
        yield LoginFailState(e.toString());
      }
    }
  }
}
