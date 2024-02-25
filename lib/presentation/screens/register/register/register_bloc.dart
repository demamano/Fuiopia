// import 'package:fuiopia/data/models/models.dart';
// import 'package:fuiopia/data/repository/app_repository.dart';

// import 'package:fuiopia/data/repository/repository.dart';
// import 'package:fuiopia/presentation/screens/register/register/bloc.dart';
// import 'package:fuiopia/utils/validator.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:bloc/bloc.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final AuthRepository _authRepository = AppRepository.authRepository;

//   RegisterBloc() : super(RegisterState.empty());

//   @override
//   Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
//       Stream<RegisterEvent> events, transitionFn) {
//     var debounceStream = events
//         .where((event) =>
//             event is EmailChanged ||
//             event is PasswordChanged ||
//             event is ConfirmPasswordChanged)
//         .debounceTime(Duration(milliseconds: 300));
//     var nonDebounceStream = events.where((event) =>
//         event is! EmailChanged &&
//         event is! PasswordChanged &&
//         event is! ConfirmPasswordChanged);
//     return super.transformEvents(
//         nonDebounceStream.mergeWith([debounceStream]), transitionFn);
//   }

//   @override
//   Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
//     if (event is EmailChanged) {
//       yield* _mapEmailChangedToState(event.email);
//     } else if (event is PasswordChanged) {
//       yield* _mapPasswordChangedToState(event.password);
//     } else if (event is ConfirmPasswordChanged) {
//       yield* _mapConfirmPasswordChangedToState(
//         event.password,
//         event.confirmPassword,
//       );
//     } else if (event is Submitted) {
//       yield* _mapFormSubmittedToState(
//         event.newUser,
//         event.password,
//         event.confirmPassword,
//       );
//     }
//   }

//   /// Map from email changed event => states
//   Stream<RegisterState> _mapEmailChangedToState(String email) async* {
//     yield state.update(
//       isEmailValid: UtilValidators.isValidEmail(email),
//     );
//   }

//   /// Map from password changed event => states
//   Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
//     var isPasswordValid = UtilValidators.isValidPassword(password);

//     yield state.update(isPasswordValid: isPasswordValid);
//   }

//   /// Map from confirmed password changed event => states
//   Stream<RegisterState> _mapConfirmPasswordChangedToState(
//     String password,
//     String confirmPassword,
//   ) async* {
//     var isConfirmPasswordValid =
//         UtilValidators.isValidPassword(confirmPassword);
//     var isMatched = true;

//     if (password.isNotEmpty) {
//       isMatched = password == confirmPassword;
//     }

//     yield state.update(
//       isConfirmPasswordValid: isConfirmPasswordValid && isMatched,
//     );
//   }

//   /// Map from submit event => states
//   Stream<RegisterState> _mapFormSubmittedToState(
//     UserModel newUser,
//     String password,
//     String confirmPassword,
//   ) async* {
//     try {
//       yield RegisterState.loading();
//       await _authRepository.signUp(newUser, password);

//       bool isLoggedIn = _authRepository.isLoggedIn();
//       if (isLoggedIn) {
//         yield RegisterState.success();
//       } else {
//         final message = _authRepository.authException;
//         yield RegisterState.failure(message);
//       }
//     } catch (e) {
//       yield RegisterState.failure("Register Failure");
//     }
//   }
// }

import 'package:fuiopia/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repository/repository.dart';
import 'bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository = AppRepository.authRepository;

  RegisterBloc() : super(RegisterState.empty()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<Submitted>(_onSubmitted);
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.update(
      isEmailValid: UtilValidators.isValidEmail(event.email),
    ));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.update(
      isPasswordValid: UtilValidators.isValidPassword(event.password),
    ));
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final isPasswordValid = UtilValidators.isValidPassword(event.password);
    final isMatched = event.password == event.confirmPassword;
    emit(state.update(
      isConfirmPasswordValid: isPasswordValid && isMatched,
    ));
  }

  Future<void> _onSubmitted(
    Submitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterState.loading());
    try {
      await _authRepository.signUp(event.newUser, event.password);
      final isLoggedIn = _authRepository.isLoggedIn();
      if (isLoggedIn) {
        emit(RegisterState.success());
      } else {
        final message = _authRepository.authException;
        emit(RegisterState.failure(message));
      }
    } catch (e) {
      emit(RegisterState.failure("Register Failure"));
    }
  }
}
