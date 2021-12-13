import 'package:equatable/equatable.dart';

abstract class DataState {}

abstract class DataEquitableState extends Equatable implements DataState {}

class InitialState extends DataEquitableState {
  @override
  List<Object> get props => [];
}

class LoadingState extends DataEquitableState {
  LoadingState(this.loadingMessage);

  final String? loadingMessage;

  @override
  List<String?> get props => [loadingMessage];
}

class LoadedState<T> extends DataEquitableState {
  final String? message;
  final T? data;

  LoadedState(this.message, this.data);

  @override
  List<T?> get props => [data];
}

class ErrorState extends DataEquitableState {
  ErrorState(this.errorMessage);

  final String? errorMessage;

  @override
  List<String?> get props => [errorMessage];
}

class ErrorPromptState extends DataState {
  ErrorPromptState(this.errorMessage);

  final String? errorMessage;
}
