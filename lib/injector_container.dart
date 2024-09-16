import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'features/home/home.dart';
import 'features/main/main.dart';
import 'core/constants/constants.dart';
import 'features/watchlist/watchlist.dart';
import 'features/movie_detail/movie_detail.dart';

export 'features/home/home.dart';
export 'features/main/main.dart';
export 'core/constants/constants.dart';
export 'features/watchlist/watchlist.dart';
export 'features/movie_detail/movie_detail.dart';

final GetIt getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: 'application/json',
        sendTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        baseUrl: Constants.baseUrl,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzgyMGNmNTZhYzYyYTEyODFmOTA0NzU4NzRlZmVhYSIsIm5iZiI6MTcyNjIwMzQ2Ny4xMzM2OTcsInN1YiI6IjY2ZTNjNDZkZjQ2N2MyYWQ2MmY5NGZjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ecdHnDRmHE4g63CKPcfMe6UBTDW5Vw3UGZz1GIEz09Y',
        },
      )
      ..interceptors.add(LogInterceptor(
        error: kDebugMode,
        request: kDebugMode,
        requestBody: kDebugMode,
        responseBody: kDebugMode,
        requestHeader: kDebugMode,
        responseHeader: kDebugMode,
        logPrint: (Object object) {
          if (kDebugMode) log("dio: $object");
        },
      )),
  );

  getIt.registerLazySingleton(() => Connectivity());

  /// registering blocs
  getIt.registerLazySingleton(
    () => MovieBloc(
      movieRepository: MovieRepositoryImpl(dio: getIt.get<Dio>()),
    ),
  );
  getIt.registerLazySingleton(
    () => MovieDetailBloc(
      movieDetailRepository: MovieDetailRepositoryImpl(dio: getIt.get<Dio>()),
    ),
  );
  getIt.registerLazySingleton(() => WatchListBloc());

  /// registering cubits
  getIt.registerLazySingleton(() => TabBoxCubit());
}
