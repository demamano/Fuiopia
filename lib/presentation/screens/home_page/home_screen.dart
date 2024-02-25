import 'package:fuiopia/presentation/screens/home_page/bloc/bloc.dart';
import 'package:fuiopia/presentation/screens/home_page/widgets/home_body.dart';
import 'package:fuiopia/presentation/screens/home_page/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<HomeBloc>(context).add(RefreshHome());
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    SliverPersistentHeader(
                      delegate: HomePersistentHeader(),
                      pinned: true,
                    ),
                    const HomeBody(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
