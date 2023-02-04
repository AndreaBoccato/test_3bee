import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3bee/core/enums/request_status.dart';
import 'package:test_3bee/core/instance_locator.dart';
import 'package:test_3bee/models/responses/apiaries_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<RequestData>(_onRequestData);
  }

  Future _onRequestData(RequestData event, Emitter<HomeState> emit) async {
    print('++++ ${state.hasMore} ${state.isFetching} ${state.pageToRequest} ');

    if (!state.hasMore || state.isFetching) {
      return;
    }

    if (event.showLoader) {
      emit(state.copyWith(
        isLoading: true,
      ));
    }

    emit(state.copyWith(
      isFetching: true,
    ));

    try {
      final ApiariesResponse apiariesResponse = await apiaryService.getApiaries(page: state.pageToRequest);

      emit(state.copyWith(
        apiariesResponse: apiariesResponse,
        hasMore: apiariesResponse.next != null,
        pageToRequest: state.pageToRequest + 1,
        requestStatus: RequestStatus.success,
      ));
    } catch (e) {
      log('Error from server: ${e.toString()}');
      emit(state.copyWith(
        requestStatus: RequestStatus.failure,
      ));
    } finally {
      emit(state.copyWith(
        isLoading: false,
        isFetching: false,
        requestStatus: RequestStatus.idle,
      ));
    }
  }
}
