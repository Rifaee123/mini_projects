import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/Domain/core/api_end_points.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_app/Domain/downloads/i_downloads_repo.dart';
import 'package:netflix_app/Domain/downloads/models/downloads.dart';

@LazySingleton(as: IDownloadsRepo)
class DownloadsRepository implements IDownloadsRepo {
  @override
  Future<Either<MainFaliure, List<Downloads>>> getDownloadsImages() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.downloads);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // await Future.delayed(const Duration(seconds: 1));
        final downloadsList = (response.data['results'] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();
        // log(downloadsList.toString());

        print(downloadsList);
        return Right(downloadsList);
      } else {
        return const Left(MainFaliure.servrerFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFaliure.clientFailure());
    }
  }
}
