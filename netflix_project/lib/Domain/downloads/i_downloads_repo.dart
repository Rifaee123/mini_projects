import 'package:dartz/dartz.dart';
import 'package:netflix_app/Domain/core/failures/main_failure.dart';
import 'package:netflix_app/Domain/downloads/models/downloads.dart';

abstract class IDownloadsRepo {
  Future<Either<MainFaliure, List<Downloads>>> getDownloadsImages();
}
