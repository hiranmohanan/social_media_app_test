import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/service/model/image_model.dart';

import '../../../service/api_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeScreenApiCallEvent>(_getImages);
  }
  Future<void> _getImages(HomeScreenApiCallEvent event, Emitter emit) async {
    emit(HomeLoadingState());
    final responce = await HomeApiServices().getImages();
    if (responce.quotes!.isEmpty) {
      emit(HomeFailureState(errorMessage: 'No images found'));
      return;
    }
    if (responce.quotes!.isNotEmpty) {
      debugPrint('==========responce from bloc $responce');
      emit(HomeSuccessState(quotes: responce));
    } else {
      emit(HomeFailureState(errorMessage: 'No images found'));
    }
  }
}
