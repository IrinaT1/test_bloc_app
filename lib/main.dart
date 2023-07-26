import 'package:flutter/material.dart';
import 'package:test_bloc_app/cat_facts/bloc/cats_bloc.dart';
import 'package:test_bloc_app/cat_facts/main_page.dart';
import 'package:test_bloc_app/domain_search/bloc/search_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            Provider<CatsBloc>(
              create: (context) => CatsBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<SearchBloc>(
              create: (_) => SearchBloc(),
              dispose: (_, bloc) => bloc.dispose(),
            ),
          ],
          child: const MainPage(),
        ));
  }
}
