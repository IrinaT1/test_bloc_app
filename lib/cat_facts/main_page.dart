import 'package:flutter/material.dart';
import 'package:test_bloc_app/cat_facts/ui/cats_widget.dart';
import 'package:test_bloc_app/domain_search/ui/search_presenter.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.fact_check)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
            title: const Text('Bloc Demo App'),
          ),
          body: const TabBarView(
            children: [
              CatsPresenter(),
              SearchPresenter(),
            ],
          ),
        ),
      ),
    );
  }
}
