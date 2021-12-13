import 'package:datasource/network/api_call_type.dart';
import 'package:flutter_popular/models/movie_search_response.dart';
import 'package:flutter_popular/models/top_250_movies_response.dart';

import '../app_repository.dart';
import '../keys.dart';

class MoviesRepository {
  MoviesRepository() {
    _repository = AppRepository();
  }

  late AppRepository _repository;

  Future<Top250MoviesResponse> getTop250Movies() async {
    final apiResponse = await _repository.fetchData(ApiCallType.get, "Top250Movies/${Keys.imdbApiKey}", null);
    return Top250MoviesResponse.fromJson(apiResponse);
  }

  Future<MovieSearchResponse> searchMovies(String searchParam) async {
    final apiResponse = await _repository.fetchData(ApiCallType.get, "SearchMovie/${Keys.imdbApiKey}/$searchParam", null);
    return MovieSearchResponse.fromJson(apiResponse);
  }
}
