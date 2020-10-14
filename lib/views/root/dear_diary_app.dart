import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/theme/theme.dart';
import 'package:training_app/views/home_page/home_provider.dart';
import 'package:training_app/views/root/root_page/root_state.dart';
import 'root_page/root_bloc.dart';

class DearDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootBloc(context),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  final loadingScreen = Scaffold(
    body: Center(
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'DearDiary',
      home: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          if (state.init) {
            return HomeProvider();
          }
          return loadingScreen;
        },
      ),
    );
  }
}
