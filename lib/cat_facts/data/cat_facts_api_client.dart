import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CatFactRequestFailure implements Exception {
  final String message;
  CatFactRequestFailure([this.message = '']);
}

class CatFactsApiClient {
  CatFactsApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'meowfacts.herokuapp.com';

  final http.Client _httpClient;

  Future<Either<CatFactRequestFailure, CatFactsDTO>> fetchFacts(
      int count) async {
    try {
      final request = Uri.https(_baseUrl, '', {'count': count.toString()});
      final response = await _httpClient.get(request);

      if (response.statusCode != 200) {
        return Left(
            CatFactRequestFailure('response code was ${response.statusCode}'));
      }

      final json = jsonDecode(response.body) as Map;
      var results =
          List<String>.from(json["data"].map((item) => item.toString()));

      return Right(CatFactsDTO.fromJson(results));
    } catch (e) {
      return Left(CatFactRequestFailure('exception thrown: $e'));
    }
  }
}

class CatFactsDTO {
  final List<String> facts;

  CatFactsDTO({required this.facts});

  factory CatFactsDTO.fromJson(List<String> data) {
    return CatFactsDTO(facts: data);
  }
}
