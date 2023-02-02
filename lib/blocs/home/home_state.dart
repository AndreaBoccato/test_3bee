part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final int page;

  const HomeState({
    this.isLoading = false,
    this.page = 1,
  });

  HomeState copyWith({
    bool? isLoading,
    int? page,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [isLoading, page];
}
