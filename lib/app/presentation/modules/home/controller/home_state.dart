import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/models/movie.dart';
import '../../../../domain/models/performer.dart';

part 'home_state.freezed.dart';

/// Estado INMUTABLE de la pantalla Home (generado con freezed).
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(TimeWindow.day) TimeWindow timeWindow,
    @Default(true) bool moviesLoading,
    @Default(false) bool moviesFailed,
    @Default(<Movie>[]) List<Movie> movies,
    @Default(true) bool performersLoading,
    @Default(false) bool performersFailed,
    @Default(<Performer>[]) List<Performer> performers,
  }) = _HomeState;
}
