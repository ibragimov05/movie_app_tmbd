// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_list_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchListState _$WatchListStateFromJson(Map<String, dynamic> json) =>
    WatchListState(
      savedMovies: (json['savedMovies'] as List<dynamic>?)
              ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$WatchlistStatusEnumMap, json['status']) ??
          WatchlistStatus.initial,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$WatchListStateToJson(WatchListState instance) =>
    <String, dynamic>{
      'savedMovies': instance.savedMovies,
      'status': _$WatchlistStatusEnumMap[instance.status]!,
      'error': instance.error,
    };

const _$WatchlistStatusEnumMap = {
  WatchlistStatus.initial: 'initial',
  WatchlistStatus.done: 'done',
  WatchlistStatus.error: 'error',
};
