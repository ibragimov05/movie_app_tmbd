import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_tmbd/features/home/domain/repository/movie_repository.dart';
import 'package:movie_app_tmbd/features/home/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app_tmbd/features/main/presentation/cubit/tab_box_cubit.dart';
import 'package:movie_app_tmbd/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:movie_app_tmbd/features/movie_detail/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import 'core/constants/constants.dart';
import 'features/watchlist/presentation/bloc/watch_list/watch_list_bloc.dart';

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
