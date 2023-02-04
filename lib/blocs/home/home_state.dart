part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ApiariesResponse? apiariesResponse;
  final bool isLoading;
  final bool isFetching;
  final bool showLoader;
  final bool hasMore;
  final int pageToRequest;
  final RequestStatus requestStatus;

  const HomeState({
    this.apiariesResponse,
    this.isLoading = true,
    this.isFetching = false,
    this.showLoader = true,
    this.hasMore = true,
    this.pageToRequest = 1,
    this.requestStatus = RequestStatus.idle,
  });

  HomeState copyWith({
    ApiariesResponse? apiariesResponse,
    bool? isLoading,
    bool? isFetching,
    bool? showLoader,
    bool? hasMore,
    int? pageToRequest,
    RequestStatus? requestStatus,
  }) {
    return HomeState(
      apiariesResponse: apiariesResponse ?? this.apiariesResponse,
      isLoading: isLoading ?? this.isLoading,
      isFetching: isFetching ?? this.isFetching,
      showLoader: showLoader ?? this.showLoader,
      hasMore: hasMore ?? this.hasMore,
      pageToRequest: pageToRequest ?? this.pageToRequest,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [
        apiariesResponse,
        isLoading,
        isFetching,
        hasMore,
        pageToRequest,
        requestStatus,
      ];
}
