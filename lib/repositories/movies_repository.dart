import 'dart:convert';

import 'package:core/custom_exceptions.dart';
import 'package:datasource/base_repository.dart';
import 'package:datasource/network/api_call_type.dart';
import 'package:flutter_popular/db/db_provider.dart';
import 'package:flutter_popular/models/movie_search_response.dart';
import 'package:flutter_popular/models/top_250_movies_response.dart';

import '../keys.dart';

class MoviesRepository extends BaseRepository {
  static const _errorMessage = "errorMessage";

  @override
  handleApiError(apiResponse) {
    if (apiResponse[_errorMessage].toString().isNotEmpty) {
      throw ApiErrorException(apiResponse[_errorMessage]);
    }
  }

  Future<Top250MoviesResponse> getTop250Movies({bool mustFetch = false}) async {
    final apiResponse = await fetchData(
        mustFetch, ApiCallType.get, "Top250Movies/${Keys.imdbApiKey}", null);
    return Top250MoviesResponse.fromJson(apiResponse);
  }

  Future<MovieSearchResponse> searchMovies(String? searchParam) async {
    // not implementing offline feature for search
    final apiResponse = await fetchLiveData(ApiCallType.get,
        "SearchMovie/${Keys.imdbApiKey}/$searchParam", null);
    return MovieSearchResponse.fromJson(apiResponse);
  }

  @override
  getLocalData(requestModel) async {
    // use request model when it is needed in the query
    var data = await OfflineDataHelper.getInstance(OfflineDataType.movies).getData();
    return data;
  }

  @override
  saveDataLocally(requestModel, responseData) {
    // use request model when it is needed in the query
    OfflineDataHelper.getInstance(OfflineDataType.movies).insertData(json.encode(responseData).replaceAll("'", "")); // removing ' as it creates problem with SQL
  }
}
