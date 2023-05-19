part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateIid,
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tensedDramasMoveList,
    required List<HotAndNewData> sountindianMovieList,
    required List<HotAndNewData> trendingTvList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HomeState.intial() => const HomeState(
        stateIid: '0',
        pastYearMovieList: [],
        trendingMovieList: [],
        tensedDramasMoveList: [],
        sountindianMovieList: [],
        trendingTvList: [],
        isLoading: false,
        hasError: false,
      );
}
