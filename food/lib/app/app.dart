import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app/bloc/bloc.dart';
import 'package:food/app/bloc/bloc_event.dart';
import 'package:food/app/pages/main_page/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc()..add(InitializeCategories())..add(InitializeDishes()),
      child: MaterialApp(
        title: 'Test food app',
        theme: ThemeData(
            textTheme: Typography.blackCupertino
        ),
        home: const MainPage(),
      ),
    );
  }
}