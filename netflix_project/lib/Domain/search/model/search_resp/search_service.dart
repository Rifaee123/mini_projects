import 'package:dartz/dartz.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:netflix_app/Domain/search/model/search_resp/search_resp.dart';

abstract class SearchService {
  Future<Either<MainFaliure, SearchResp>> searchMovies({
    required String movieQuery,
  });
}
