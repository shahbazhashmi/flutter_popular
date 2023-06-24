import 'package:bloc_test/bloc_test.dart';
import 'package:datasource/states/data_state.dart';
import 'package:flutter_popular/cubits/movies_cubit.dart';

class MockMoviesCubit extends MockCubit<DataState> implements MoviesCubit {}
