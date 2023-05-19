import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/models/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;

  HomeBloc(this._homeService) : super(HomeState.intial()) {
    //on event get homeScreen data

    on<GetHomeScreenData>((event, emit) async {
      log('Getting HomeScreen data');
      //Send Loading to Ui

      emit(state.copyWith(isLoading: true, hasError: false));

      //get data
      final _movieResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();

      //transform data

      final _state1 = _movieResult.fold((MainFaliure faliure) {
        return HomeState(
          stateIid: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tensedDramasMoveList: [],
          sountindianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southIndian = resp.results;
        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();
        return HomeState(
          stateIid: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          tensedDramasMoveList: dramas,
          sountindianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });

      emit(_state1);

      final _state2 = _tvResult.fold((MainFaliure faliure) {
        return HomeState(
          stateIid: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tensedDramasMoveList: [],
          sountindianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final top10List = resp.results;
        return HomeState(
          stateIid: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: state.trendingMovieList,
          tensedDramasMoveList: state.tensedDramasMoveList,
          sountindianMovieList: state.sountindianMovieList,
          trendingTvList: top10List,
          isLoading: false,
          hasError: false,
        );
      });

      //Send to UI

      emit(_state2);
    });
  }
}
