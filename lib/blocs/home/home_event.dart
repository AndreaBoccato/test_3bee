part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class RequestData extends HomeEvent {
  final bool showLoader;

  const RequestData({
    this.showLoader = true,
  });

  @override
  List<Object?> get props => [showLoader];
}
