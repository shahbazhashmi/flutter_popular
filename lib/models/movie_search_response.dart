import 'movie.dart';

/// searchType : "Movie"
/// expression : "inception 2010"
/// results : [{"id":"tt1375666","resultType":"Title","image":"https://imdb-api.com/images/original/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_Ratio0.6800_AL_.jpg","title":"Inception","description":"(2010)"},{"id":"tt5295894","resultType":"Title","image":"https://imdb-api.com/images/original/MV5BMjE0NGIwM2EtZjQxZi00ZTE5LWExN2MtNDBlMjY1ZmZkYjU3XkEyXkFqcGdeQXVyNjMwNzk3Mjk@._V1_Ratio0.6800_AL_.jpg","title":"Inception: The Cobol Job","description":"(2010 Video)"},{"id":"tt5295990","resultType":"Title","image":"https://imdb-api.com/images/original/MV5BZGFjOTRiYjgtYjEzMS00ZjQ2LTkzY2YtOGQ0NDI2NTVjOGFmXkEyXkFqcGdeQXVyNDQ5MDYzMTk@._V1_Ratio0.6800_AL_.jpg","title":"Inception: Jump Right Into the Action","description":"(2010 Video)"},{"id":"tt12960252","resultType":"Title","image":"https://imdb-api.com/images/original/nopicture.jpg","title":"Inception Premiere","description":"(2010)"},{"id":"tt1686778","resultType":"Title","image":"https://imdb-api.com/images/original/nopicture.jpg","title":"Inception: 4Movie Premiere Special","description":"(2010 TV Movie)"}]
/// errorMessage : ""

class MovieSearchResponse {
  MovieSearchResponse({
    String? searchType,
    String? expression,
    List<Movie>? results,
    String? errorMessage,
  }) {
    _searchType = searchType;
    _expression = expression;
    _results = results;
    _errorMessage = errorMessage;
  }

  MovieSearchResponse.fromJson(dynamic json) {
    _searchType = json['searchType'];
    _expression = json['expression'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Movie.fromJson(v));
      });
    }
    _errorMessage = json['errorMessage'];
  }
  String? _searchType;
  String? _expression;
  List<Movie>? _results;
  String? _errorMessage;

  String? get searchType => _searchType;
  String? get expression => _expression;
  List<Movie>? get results => _results;
  String? get errorMessage => _errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchType'] = _searchType;
    map['expression'] = _expression;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['errorMessage'] = _errorMessage;
    return map;
  }
}
