import 'dart:core';

import 'package:datasource/states/data_state.dart';
import 'package:flutter_popular/cubits/movies_cubit.dart';
import 'package:flutter_popular/models/movie.dart';
import 'package:flutter_popular/models/movie_search_response.dart';
import 'package:flutter_popular/models/top_250_movies_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  late MockMoviesRepository moviesRepository;
  late MoviesCubit moviesCubit;

  final top250MoviesResponse = Top250MoviesResponse(errorMessage: 'success', items: [
    Movie(title: 'Avatar', description: 'mock movie'),
    Movie(title: 'Inception', description: 'mock movie'),
  ]);
  final movieSearchResponse = MovieSearchResponse(errorMessage: 'success', results: [
    Movie(title: 'The Dark Knight', description: 'mock movie'),
    Movie(title: 'Man Of Steel', description: 'mock movie'),
  ]);

  setUp(() {
    moviesRepository = MockMoviesRepository();
    moviesCubit = MoviesCubit(repository: moviesRepository);
    when(() => moviesRepository.getTop250Movies()).thenAnswer(
      (_) async => top250MoviesResponse,
    );
    when(() => moviesRepository.searchMovies(any())).thenAnswer(
      (_) async => movieSearchResponse,
    );
  });

  test('test getTop250Movies() => Emits movies when repository answer correctly', () async {
    moviesCubit.getTop250Movies();
    await expectLater(
      moviesCubit.stream,
      emits(LoadedState('mock response', top250MoviesResponse.items)),
    );
  });

  test('test searchMovies() => Emits movies when repository answer correctly', () async {
    moviesCubit.searchMovies('test movie');
    await expectLater(
      moviesCubit.stream,
      emits(LoadedState('mock response', movieSearchResponse.results)),
    );
  });
}
