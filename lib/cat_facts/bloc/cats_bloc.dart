import 'dart:async';

import 'package:test_bloc_app/cat_facts/data/cat_facts_repository.dart';
import 'package:test_bloc_app/cat_facts/models/cat_fact_model.dart';

class CatsBloc {
  CatsBloc() {
    _catsStreamController.onListen = fetchCatsData;
  }

  final StreamController<CatFactModel?> _catsStreamController =
      StreamController.broadcast();

  Stream<CatFactModel?> get catsViewModelStream => _catsStreamController.stream;

  Future<void> fetchCatsData() async {
    final repository = CatFactsRepository();

    _catsStreamController.add(null);
    await Future.delayed(const Duration(milliseconds: 300));
    final model = await repository.getCatFacts(10);
    if (model.error.isNotEmpty) {
      _catsStreamController.addError(model.error);
    } else {
      _catsStreamController.add(model);
    }
  }

  void dispose() {
    _catsStreamController.close();
  }
}
