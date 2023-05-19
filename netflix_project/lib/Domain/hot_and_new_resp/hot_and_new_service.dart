import 'package:dartz/dartz.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/models/hot_and_new_resp.dart';

abstract class HotAndNewService {
  Future<Either<MainFaliure, HotAndNewResp>> getHotAndNewMovieData();
  Future<Either<MainFaliure, HotAndNewResp>> getHotAndNewTvData();
}
