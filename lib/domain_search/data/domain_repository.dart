import 'package:test_bloc_app/domain_search/data/domain_api_client.dart';
import 'package:test_bloc_app/domain_search/models/domain_serach_results_model.dart';

class DomainRepository {
  DomainRepository._() : _apiClient = DomainApiClient();

  final DomainApiClient _apiClient;

  static final DomainRepository _instance = DomainRepository._();

  factory DomainRepository() => _instance;

  Future<DomainSearchResultsModel> search(String query) async {
    final results = await _apiClient.search(query);

    return results.fold((error) {
      return DomainSearchResultsModel(error: error.message);
    }, (dto) {
      final domains = dto.domains
          .map((e) => DomainModel(
                domain: e.domain,
                isDead: e.isDead,
              ))
          .toList();

      return DomainSearchResultsModel(domains: domains);
    });
  }
}
