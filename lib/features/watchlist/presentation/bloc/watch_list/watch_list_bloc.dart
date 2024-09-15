import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_tmbd/features/home/data/models/models.dart';

part 'watch_list_event.dart';

part 'watch_list_state.dart';

part 'watch_list_bloc.g.dart';

class WatchListBloc extends HydratedBloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(const WatchListState()) {
    on<ToggleWatchListEvent>(_onAddWatchList);
  }

  Future<void> _onAddWatchList(
    ToggleWatchListEvent event,
    Emitter<WatchListState> emit,
  ) async {
    try {
      final List<Movie> updatedMovies = List.from(state.savedMovies);

      final int index = updatedMovies.indexWhere(
        (element) => element.id == event.movie.id,
      );

      if (index == -1) {
        updatedMovies.add(event.movie);
      } else {
        updatedMovies.removeAt(index);
      }

      emit(state.copyWith(
        status: WatchlistStatus.done,
        savedMovies: updatedMovies,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        status: WatchlistStatus.error,
      ));
    }
  }

  /// for hydrated bloc
  @override
  WatchListState? fromJson(Map<String, dynamic> json) {
    try {
      return WatchListState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WatchListState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
