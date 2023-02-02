part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ApiariesResponse? apiariesResponse;
  final bool isLoading;
  final int page;

  const HomeState({
    this.apiariesResponse,
    this.isLoading = false,
    this.page = 1,
  });

  HomeState copyWith({
    ApiariesResponse? apiariesResponse,
    bool? isLoading,
    int? page,
  }) {
    return HomeState(
      apiariesResponse: apiariesResponse ?? this.apiariesResponse,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [apiariesResponse, isLoading, page];
}
