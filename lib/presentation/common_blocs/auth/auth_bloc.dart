// import 'package:bloc/bloc.dart';
// import 'package:fuiopia/data/repository/repository.dart';
// import 'package:fuiopia/presentation/common_blocs/auth/auth_event.dart';

// import 'auth_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final AuthRepository _authRepository = AppRepository.authRepository;

//   AuthenticationBloc() : super(Uninitialized());

//   @override
//   Stream<AuthenticationState> mapEventToState(
//       AuthenticationEvent event) async* {
//     if (event is AuthenticationStarted) {
//       yield* _mapAppStartedToState();
//     } else if (event is LoggedIn) {
//       yield* _mapLoggedInToState();
//     } else if (event is LoggedOut) {
//       yield* _mapLoggedOutToState();
//     }
//   }

//   Stream<AuthenticationState> _mapAppStartedToState() async* {
//     try {
//       bool isLoggedIn = _authRepository.isLoggedIn();

//       //For display splash screen
//       await Future.delayed(const Duration(seconds: 3));

//       if (isLoggedIn) {
//         // Get current user
//         final loggedFirebaseUser = _authRepository.loggedFirebaseUser;
//         yield Authenticated(loggedFirebaseUser);
//       } else {
//         yield Unauthenticated();
//       }
//     } catch (_) {
//       yield Unauthenticated();
//     }
//   }

//   Stream<AuthenticationState> _mapLoggedInToState() async* {
//     yield Authenticated(_authRepository.loggedFirebaseUser);
//   }

//   Stream<AuthenticationState> _mapLoggedOutToState() async* {
//     yield Unauthenticated();
//     _authRepository.logOut();
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:fuiopia/data/repository/repository.dart';
import 'package:fuiopia/presentation/common_blocs/auth/auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = AppRepository.authRepository;

  AuthenticationBloc() : super(Uninitialized()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAuthenticationStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      //For display splash screen
      await Future.delayed(const Duration(seconds: 3));
      if (isLoggedIn) {
        final loggedFirebaseUser = _authRepository.loggedFirebaseUser;
        emit(Authenticated(loggedFirebaseUser));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoggedIn(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(Authenticated(_authRepository.loggedFirebaseUser));
  }

  Future<void> _onLoggedOut(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    _authRepository.logOut();
    emit(Unauthenticated());
  }
}
