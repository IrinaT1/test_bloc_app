import 'dart:async';

import 'package:test_bloc_app/domain_search/data/domain_repository.dart';
import 'package:test_bloc_app/domain_search/models/domain_serach_results_model.dart';

class SearchBloc {
  SearchBloc() {
    _searchController.onListen = () {
      _searchController.add(DomainSearchResultsModel());
    };
  }

  final StreamController<DomainSearchResultsModel?> _searchController =
      StreamController.broadcast();

  Stream<DomainSearchResultsModel?> get searchResults =>
      _searchController.stream;

  Future<void> search(String query) async {
    final repo = DomainRepository();

    _searchController.add(null);

    final resultModel = await repo.search(query);
    if (resultModel.error.isNotEmpty) {
      _searchController.addError(resultModel.error);
    } else {
      _searchController.add(resultModel);
    }
  }

  void dispose() => _searchController.close();
}
