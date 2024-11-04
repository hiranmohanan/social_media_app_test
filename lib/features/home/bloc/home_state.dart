part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final QuoteSet quotes;

  HomeSuccessState({
    required this.quotes,
  });
}

class HomeFailureState extends HomeState {
  final String errorMessage;

  HomeFailureState({
    required this.errorMessage,
  });
}

class AuthLogoutSuccess extends HomeState {}
