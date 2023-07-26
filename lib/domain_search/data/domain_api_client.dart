import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class DomainSearchFailure implements Exception {
  final String message;

  DomainSearchFailure([this.message = '']);
}

class DomainApiClient {
  final Client _httpClient = Client();
  final String _baseUrl = 'api.domainsdb.info';

  Future<Either<DomainSearchFailure, DomainSearchResultsDTO>> search(
      String query) async {
    try {
      final request =
          Uri.https(_baseUrl, 'v1/domains/search', {'domain': query});
      final response = await _httpClient.get(request);

      if (response.statusCode != 200) {
        return Left(
            DomainSearchFailure("Request failed, code=${response.statusCode}"));
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = DomainSearchResultsDTO.fromJson(json);

      return Right(data);
    } catch (e) {
      return Left(DomainSearchFailure(e.toString()));
    }
  }
}

class DomainSearchResultsDTO {
  final List<DomainDTO> domains;

  DomainSearchResultsDTO({required this.domains});

  factory DomainSearchResultsDTO.fromJson(Map<String, dynamic> json) {
    var domainsList = json['domains'];

    var results = <DomainDTO>[];
    domainsList.forEach((item) {
      var result = DomainDTO.fromJson(item);
      results.add(result);
    });

    return DomainSearchResultsDTO(domains: results);
  }
}

class DomainDTO {
  final String domain;
  final bool isDead;

  DomainDTO({required this.domain, required this.isDead});

  factory DomainDTO.fromJson(Map<String, dynamic> json) {
    return DomainDTO(
        domain: json['domain'],
        isDead: bool.fromEnvironment(json['isDead'], defaultValue: true));
  }
}
