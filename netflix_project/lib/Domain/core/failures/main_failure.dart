import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_failures.freezed.dart';

@freezed
class MainFaliure with _$MainFaliure {
  const factory MainFaliure.clientFailure() = _ClientFailure;
  const factory MainFaliure.servrerFailure() = _ServrerFailure;
}
