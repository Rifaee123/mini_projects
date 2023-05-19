import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/Domain/core/api_end_points.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/Domain/hot_and_new_resp/models/hot_and_new_resp.dart';



@LazySingleton(as:HotAndNewService)
class HotAndNewImplementation implements HotAndNewService {
  @override
  Future<Either<MainFaliure, HotAndNewResp>> getHotAndNewMovieData() async {
    try {
      final response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFaliure.servrerFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFaliure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFaliure.clientFailure());
    }
  }

  @override
  Future<Either<MainFaliure, HotAndNewResp>> getHotAndNewTvData() async {
    try {
      final response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFaliure.servrerFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFaliure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFaliure.clientFailure());
    }
  }
}
