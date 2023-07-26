import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_bloc_app/domain_search/bloc/search_bloc.dart';
import 'package:test_bloc_app/domain_search/models/domain_serach_results_model.dart';
import 'package:provider/provider.dart';

class SearchPresenter extends StatelessWidget {
  const SearchPresenter({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SearchBloc>(context, listen: false);
    return StreamBuilder(
      stream: bloc.searchResults,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error.toString()}");
        } else if (snapshot.hasData) {
          return SearchPage(bloc: bloc, model: snapshot.data!);
        } else {
          return const Text("Loading...");
        }
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  final SearchBloc bloc;
  final DomainSearchResultsModel model;
  const SearchPage({required this.model, required this.bloc, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.bloc.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
            onChanged: (query) => _onSearchChanged(query),
          ),
        ),
        SearchResultsWidget(widget.model),
      ],
    );
  }
}

class SearchResultsWidget extends StatelessWidget {
  final DomainSearchResultsModel model;
  const SearchResultsWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.domains.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(model.domains[index].domain),
        ),
      ),
    );
  }
}
