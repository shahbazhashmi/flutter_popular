import 'package:core/custom_exceptions.dart';
import 'package:datasource/states/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popular/models/movie.dart';
import 'package:flutter_popular/repositories/movies_repository.dart';

class MoviesCubit extends Cubit<DataState> {
  MoviesCubit({required this.repository}) : super(InitialState());

  final MoviesRepository repository;

  void getTop250Movies() async {
    try {
      emit(LoadingState("Loading..."));
      final movieSearchResponse = await repository.getTop250Movies();
      if (movieSearchResponse.items == null || movieSearchResponse.items!.isEmpty) {
        throw DataNotFoundException("data not found");
      }
      emit(LoadedState<List<Movie>>("success", movieSearchResponse.items));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void searchMovies(String searchParam) async {
    try {
      emit(LoadingState("Loading..."));
      final movieSearchResponse = await repository.searchMovies(searchParam);
      if (movieSearchResponse.results == null || movieSearchResponse.results!.isEmpty) {
        throw DataNotFoundException("data not found");
      }
      emit(LoadedState<List<Movie>>("success", movieSearchResponse.results));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
