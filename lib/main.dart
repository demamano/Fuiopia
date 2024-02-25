import 'package:dbclient/dbclient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuiopia/app_view.dart';
import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/data/repository/category_repository/firebase_category_repo.dart';
import 'package:fuiopia/firebase_options.dart';
import 'package:fuiopia/presentation/common_blocs/common_bloc.dart';

import 'presentation/common_blocs/simple_bloc_observer.dart';

final dbClient = DbClient();
final firebaseCategoryRepository = FirebaseCategoryRepository(dbClient);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // firebaseCategoryRepository.createCategories();
  runApp(const MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return const AppView();
            },
          );
        },
      ),
    );
  }
}
