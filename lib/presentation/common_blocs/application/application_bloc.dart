// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:fuiopia/presentation/common_blocs/common_bloc.dart';
// import 'package:fuiopia/presentation/common_blocs/application/bloc.dart';
// import 'package:fuiopia/presentation/common_blocs/auth/auth_event.dart';
// import 'package:fuiopia/presentation/common_blocs/language/bloc.dart';
// import 'package:fuiopia/data/local/pref.dart';
// import 'package:fuiopia/configs/application.dart';
// import 'package:flutter/material.dart';

// class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
//   final Application application = Application();

//   ApplicationBloc() : super(ApplicationInitial());

//   @override
//   Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
//     if (event is SetupApplication) {
//       /// Setup SharedPreferences
//       await application.setPreferences();

//       /// Get old settings
//       final oldLanguage = LocalPref.getString("language");

//       if (oldLanguage != null) {
//         CommonBloc.languageBloc.add(LanguageChanged(Locale(oldLanguage)));
//       }

//       /// Authentication begin check
//       CommonBloc.authencationBloc.add(AuthenticationStarted());

//       yield ApplicationCompleted();
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fuiopia/presentation/common_blocs/common_bloc.dart';
import 'package:fuiopia/presentation/common_blocs/application/bloc.dart';
import 'package:fuiopia/presentation/common_blocs/auth/auth_event.dart';
import 'package:fuiopia/presentation/common_blocs/language/bloc.dart';
import 'package:fuiopia/data/local/pref.dart';
import 'package:fuiopia/configs/application.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final Application application = Application();

  ApplicationBloc() : super(ApplicationInitial()) {
    on<SetupApplication>(_onSetupApplication);
  }

  Future<void> _onSetupApplication(
    SetupApplication event,
    Emitter<ApplicationState> emit,
  ) async {
    // Setup SharedPreferences
    await application.setPreferences();

    // Get old settings
    final oldLanguage = LocalPref.getString("language");

    if (oldLanguage != null) {
      CommonBloc.languageBloc.add(LanguageChanged(Locale(oldLanguage)));
    }

    // Authentication begin check
    CommonBloc.authencationBloc.add(AuthenticationStarted());

    emit(ApplicationCompleted());
  }
}

