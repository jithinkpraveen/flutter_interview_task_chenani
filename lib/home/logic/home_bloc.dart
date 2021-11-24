import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:task/home/data/home_services.dart';
import 'package:task/home/logic/home_event.dart';
import 'package:task/home/logic/home_state.dart';
import 'package:task/model/home_header_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeState? initialState}) : super(HomeInitial()) {
    on<GetSalon>(onGetsalon);
  }
}

Future<void> onGetsalon(GetSalon event, Emitter<HomeState> emit) async {
  try {
    // Response response = await HomeServices().getServiceList();
    var homeHeader = await HomeServices().getSalon();

    if (homeHeader.runtimeType == HomeHeaderModel) {
      return emit(HomeSuccess(header: homeHeader));
    } else {
      return emit(HomeFailure());
    }
  } catch (e) {
    return emit(HomeFailure());
  }
}
