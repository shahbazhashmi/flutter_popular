class Movie {
  Movie({
    String? id,
    String? rank,
    String? title,
    String? fullTitle,
    String? year,
    String? image,
    String? crew,
    String? imDbRating,
    String? imDbRatingCount,
    String? description,
    String? resultType,
  }) {
    _id = id;
    _rank = rank;
    _title = title;
    _fullTitle = fullTitle;
    _year = year;
    _image = image;
    _crew = crew;
    _imDbRating = imDbRating;
    _imDbRatingCount = imDbRatingCount;
    _description = description;
    _resultType = resultType;
  }

  Movie.fromJson(dynamic json) {
    _id = json['id'];
    _rank = json['rank'];
    _title = json['title'];
    _fullTitle = json['fullTitle'];
    _year = json['year'];
    _image = json['image'];
    _crew = json['crew'];
    _imDbRating = json['imDbRating'];
    _imDbRatingCount = json['imDbRatingCount'];
    _description = json['description'];
    _resultType = json['resultType'];
  }
  String? _id;
  String? _rank;
  String? _title;
  String? _fullTitle;
  String? _year;
  String? _image;
  String? _crew;
  String? _imDbRating;
  String? _imDbRatingCount;
  String? _description;
  String? _resultType;

  String? get id => _id;
  String? get rank => _rank;
  String? get title => _title;
  String? get fullTitle => _fullTitle;
  String? get year => _year;
  String? get image => _image;
  String? get crew => _crew;
  String? get imDbRating => _imDbRating;
  String? get imDbRatingCount => _imDbRatingCount;
  String? get resultType => _resultType;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['rank'] = _rank;
    map['title'] = _title;
    map['fullTitle'] = _fullTitle;
    map['year'] = _year;
    map['image'] = _image;
    map['crew'] = _crew;
    map['imDbRating'] = _imDbRating;
    map['imDbRatingCount'] = _imDbRatingCount;
    map['resultType'] = _resultType;
    map['description'] = _description;
    return map;
  }
}
