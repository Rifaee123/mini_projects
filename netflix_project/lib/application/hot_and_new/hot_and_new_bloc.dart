import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/models/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    //get hot and new movie data
    on<LoadDataInCommingSoon>((event, emit) async {
      //send loading to ui

      emit(const HotAndNewState(
          commmingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
      //get data from remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //data to state
      final newState = _result.fold(
        (MainFaliure failure) {
          return const HotAndNewState(
              commmingSoonList: [],
              everyOneIsWatchingList: [],
              isLoading: false,
              hasError: true);
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            commmingSoonList: resp.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(newState);
    });

//get hot and new Tv data
    on<LoadDataInEveryOneIsWatching>((event, emit) async {
      //send loading to ui

      emit(const HotAndNewState(
          commmingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
      //get data from remote
      final _result = await _hotAndNewService.getHotAndNewTvData();

      //data to state
      final newState = _result.fold(
        (MainFaliure failure) {
          return const HotAndNewState(
              commmingSoonList: [],
              everyOneIsWatchingList: [],
              isLoading: false,
              hasError: true);
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            commmingSoonList: state.commmingSoonList,
            everyOneIsWatchingList: resp.results,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(newState);
    });
  }
}
