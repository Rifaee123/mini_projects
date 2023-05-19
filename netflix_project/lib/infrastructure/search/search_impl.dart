import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/Domain/search/model/search_resp/search_resp.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_app/Domain/search/model/search_resp/search_service.dart';

import '../../Domain/core/api_end_points.dart';

@LazySingleton(as: SearchService)
class SearchImpl implements SearchService {
  @override
  Future<Either<MainFaliure, SearchResp>> searchMovies(
      {required String movieQuery}) async {
    try {
      final response = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {
          'query': movieQuery,
        },
      );
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchResp.fromJson(response.data);
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
