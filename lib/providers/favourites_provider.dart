import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/movie.dart';

class FavouritesState {
  FavouritesState(this.favouriteMovies);

  // since we don't get same instance of movie object on API call (including search)
  // creating a hashmap to store favourite movies
  final HashMap<String, Movie> favouriteMovies;
}

final favouritesProvider = StateNotifierProvider((ref) {
  return FavouritesNotifier();
});

class FavouritesNotifier extends StateNotifier<FavouritesState> {
  FavouritesNotifier() : super(FavouritesState(HashMap<String, Movie>()));

  void addRemoveMovie(Movie movie) {
    if (state.favouriteMovies.containsKey(movie.id)) {
      state.favouriteMovies.remove(movie.id);
    } else {
      state.favouriteMovies[movie.id!] = movie;
    }
    state = FavouritesState(HashMap.from(state.favouriteMovies));
  }
}
