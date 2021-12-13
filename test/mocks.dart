import 'package:bloc_test/bloc_test.dart';
import 'package:datasource/states/data_state.dart';
import 'package:flutter_popular/cubits/movies_cubit.dart';
import 'package:flutter_popular/repositories/movies_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

class MockMoviesCubit extends MockCubit<DataState> implements MoviesCubit {}
