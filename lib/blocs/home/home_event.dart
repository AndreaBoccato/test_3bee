part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class RequestData extends HomeEvent {
  final int page;

  const RequestData({
    this.page = 1,
  });

  @override
  List<Object?> get props => [page];
}

class LoadingStatusChanged extends HomeEvent {
  final bool isLoading;

  const LoadingStatusChanged({
    required this.isLoading,
  });

  @override
  List<Object?> get props => [isLoading];
}
