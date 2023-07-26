import 'dart:async';

import 'package:test_bloc_app/cat_facts/data/cat_facts_api_client.dart';
import 'package:test_bloc_app/cat_facts/models/cat_fact_model.dart';

class CatFactsRepository {
  CatFactsRepository._() : _apiClient = CatFactsApiClient();

  static final CatFactsRepository _instance = CatFactsRepository._();

  factory CatFactsRepository() {
    return _instance;
  }

  final CatFactsApiClient _apiClient;

  Future<CatFactModel> getCatFacts(int count) async {
    final data = await _apiClient.fetchFacts(count);

    final model = data.fold(
      (error) => CatFactModel(facts: [], error: error.message),
      (dto) => CatFactModel(facts: dto.facts),
    );
    return model;
  }
}
