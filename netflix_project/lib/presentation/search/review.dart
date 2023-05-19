import 'dart:developer';

import 'package:dio/dio.dart';


  void funreview() async {
    final dio = Dio();
    final _response = await dio.get('https://pub.dev');
    log(_response.data.toString());
  }
