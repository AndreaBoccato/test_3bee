import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3bee/core/instance_locator.dart';
import 'package:test_3bee/models/responses/apiaries_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<RequestData>(_onRequestData);
    //on<LoadingStatusChanged>(_onLoadingStatusChanged);
  }

  Future _onRequestData(RequestData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      final ApiariesResponse apiariesResponse = await commonService.getApiaries(page: event.page);

      emit(state.copyWith(
        apiariesResponse: apiariesResponse,
      ));
    } catch (e) {
      log('Error from server: ${e.toString()}');
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }
}
