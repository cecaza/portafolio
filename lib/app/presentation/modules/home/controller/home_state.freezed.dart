// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeState {
  TimeWindow get timeWindow;
  bool get moviesLoading;
  bool get moviesFailed;
  List<Movie> get movies;
  bool get performersLoading;
  bool get performersFailed;
  List<Performer> get performers;
  bool get sectionsLoading;
  bool get sectionsFailed;
  Map<MovieCategory, List<Movie>> get sections;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeStateCopyWith<HomeState> get copyWith =>
      _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeState &&
            (identical(other.timeWindow, timeWindow) ||
                other.timeWindow == timeWindow) &&
            (identical(other.moviesLoading, moviesLoading) ||
                other.moviesLoading == moviesLoading) &&
            (identical(other.moviesFailed, moviesFailed) ||
                other.moviesFailed == moviesFailed) &&
            const DeepCollectionEquality().equals(other.movies, movies) &&
            (identical(other.performersLoading, performersLoading) ||
                other.performersLoading == performersLoading) &&
            (identical(other.performersFailed, performersFailed) ||
                other.performersFailed == performersFailed) &&
            const DeepCollectionEquality()
                .equals(other.performers, performers) &&
            (identical(other.sectionsLoading, sectionsLoading) ||
                other.sectionsLoading == sectionsLoading) &&
            (identical(other.sectionsFailed, sectionsFailed) ||
                other.sectionsFailed == sectionsFailed) &&
            const DeepCollectionEquality().equals(other.sections, sections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      timeWindow,
      moviesLoading,
      moviesFailed,
      const DeepCollectionEquality().hash(movies),
      performersLoading,
      performersFailed,
      const DeepCollectionEquality().hash(performers),
      sectionsLoading,
      sectionsFailed,
      const DeepCollectionEquality().hash(sections));

  @override
  String toString() {
    return 'HomeState(timeWindow: $timeWindow, moviesLoading: $moviesLoading, moviesFailed: $moviesFailed, movies: $movies, performersLoading: $performersLoading, performersFailed: $performersFailed, performers: $performers, sectionsLoading: $sectionsLoading, sectionsFailed: $sectionsFailed, sections: $sections)';
  }
}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) =
      _$HomeStateCopyWithImpl;
  @useResult
  $Res call(
      {TimeWindow timeWindow,
      bool moviesLoading,
      bool moviesFailed,
      List<Movie> movies,
      bool performersLoading,
      bool performersFailed,
      List<Performer> performers,
      bool sectionsLoading,
      bool sectionsFailed,
      Map<MovieCategory, List<Movie>> sections});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeWindow = null,
    Object? moviesLoading = null,
    Object? moviesFailed = null,
    Object? movies = null,
    Object? performersLoading = null,
    Object? performersFailed = null,
    Object? performers = null,
    Object? sectionsLoading = null,
    Object? sectionsFailed = null,
    Object? sections = null,
  }) {
    return _then(HomeState(
      timeWindow: null == timeWindow
          ? _self.timeWindow
          : timeWindow // ignore: cast_nullable_to_non_nullable
              as TimeWindow,
      moviesLoading: null == moviesLoading
          ? _self.moviesLoading
          : moviesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      moviesFailed: null == moviesFailed
          ? _self.moviesFailed
          : moviesFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      movies: null == movies
          ? _self.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
      performersLoading: null == performersLoading
          ? _self.performersLoading
          : performersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      performersFailed: null == performersFailed
          ? _self.performersFailed
          : performersFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      performers: null == performers
          ? _self.performers
          : performers // ignore: cast_nullable_to_non_nullable
              as List<Performer>,
      sectionsLoading: null == sectionsLoading
          ? _self.sectionsLoading
          : sectionsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      sectionsFailed: null == sectionsFailed
          ? _self.sectionsFailed
          : sectionsFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      sections: null == sections
          ? _self.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as Map<MovieCategory, List<Movie>>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HomeState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_HomeState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HomeState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            TimeWindow timeWindow,
            bool moviesLoading,
            bool moviesFailed,
            List<Movie> movies,
            bool performersLoading,
            bool performersFailed,
            List<Performer> performers,
            bool sectionsLoading,
            bool sectionsFailed,
            Map<MovieCategory, List<Movie>> sections)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(
            _that.timeWindow,
            _that.moviesLoading,
            _that.moviesFailed,
            _that.movies,
            _that.performersLoading,
            _that.performersFailed,
            _that.performers,
            _that.sectionsLoading,
            _that.sectionsFailed,
            _that.sections);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            TimeWindow timeWindow,
            bool moviesLoading,
            bool moviesFailed,
            List<Movie> movies,
            bool performersLoading,
            bool performersFailed,
            List<Performer> performers,
            bool sectionsLoading,
            bool sectionsFailed,
            Map<MovieCategory, List<Movie>> sections)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState():
        return $default(
            _that.timeWindow,
            _that.moviesLoading,
            _that.moviesFailed,
            _that.movies,
            _that.performersLoading,
            _that.performersFailed,
            _that.performers,
            _that.sectionsLoading,
            _that.sectionsFailed,
            _that.sections);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            TimeWindow timeWindow,
            bool moviesLoading,
            bool moviesFailed,
            List<Movie> movies,
            bool performersLoading,
            bool performersFailed,
            List<Performer> performers,
            bool sectionsLoading,
            bool sectionsFailed,
            Map<MovieCategory, List<Movie>> sections)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(
            _that.timeWindow,
            _that.moviesLoading,
            _that.moviesFailed,
            _that.movies,
            _that.performersLoading,
            _that.performersFailed,
            _that.performers,
            _that.sectionsLoading,
            _that.sectionsFailed,
            _that.sections);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HomeState implements HomeState {
  const _HomeState(
      {this.timeWindow = TimeWindow.day,
      this.moviesLoading = true,
      this.moviesFailed = false,
      List<Movie> movies = const <Movie>[],
      this.performersLoading = true,
      this.performersFailed = false,
      List<Performer> performers = const <Performer>[],
      this.sectionsLoading = true,
      this.sectionsFailed = false,
      Map<MovieCategory, List<Movie>> sections =
          const <MovieCategory, List<Movie>>{}})
      : _movies = movies,
        _performers = performers,
        _sections = sections;

  @override
  @JsonKey()
  final TimeWindow timeWindow;
  @override
  @JsonKey()
  final bool moviesLoading;
  @override
  @JsonKey()
  final bool moviesFailed;
  final List<Movie> _movies;
  @override
  @JsonKey()
  List<Movie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  @override
  @JsonKey()
  final bool performersLoading;
  @override
  @JsonKey()
  final bool performersFailed;
  final List<Performer> _performers;
  @override
  @JsonKey()
  List<Performer> get performers {
    if (_performers is EqualUnmodifiableListView) return _performers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_performers);
  }

  @override
  @JsonKey()
  final bool sectionsLoading;
  @override
  @JsonKey()
  final bool sectionsFailed;
  final Map<MovieCategory, List<Movie>> _sections;
  @override
  @JsonKey()
  Map<MovieCategory, List<Movie>> get sections {
    if (_sections is EqualUnmodifiableMapView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sections);
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeState &&
            (identical(other.timeWindow, timeWindow) ||
                other.timeWindow == timeWindow) &&
            (identical(other.moviesLoading, moviesLoading) ||
                other.moviesLoading == moviesLoading) &&
            (identical(other.moviesFailed, moviesFailed) ||
                other.moviesFailed == moviesFailed) &&
            const DeepCollectionEquality().equals(other._movies, _movies) &&
            (identical(other.performersLoading, performersLoading) ||
                other.performersLoading == performersLoading) &&
            (identical(other.performersFailed, performersFailed) ||
                other.performersFailed == performersFailed) &&
            const DeepCollectionEquality()
                .equals(other._performers, _performers) &&
            (identical(other.sectionsLoading, sectionsLoading) ||
                other.sectionsLoading == sectionsLoading) &&
            (identical(other.sectionsFailed, sectionsFailed) ||
                other.sectionsFailed == sectionsFailed) &&
            const DeepCollectionEquality().equals(other._sections, _sections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      timeWindow,
      moviesLoading,
      moviesFailed,
      const DeepCollectionEquality().hash(_movies),
      performersLoading,
      performersFailed,
      const DeepCollectionEquality().hash(_performers),
      sectionsLoading,
      sectionsFailed,
      const DeepCollectionEquality().hash(_sections));

  @override
  String toString() {
    return 'HomeState(timeWindow: $timeWindow, moviesLoading: $moviesLoading, moviesFailed: $moviesFailed, movies: $movies, performersLoading: $performersLoading, performersFailed: $performersFailed, performers: $performers, sectionsLoading: $sectionsLoading, sectionsFailed: $sectionsFailed, sections: $sections)';
  }
}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) _then) =
      __$HomeStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {TimeWindow timeWindow,
      bool moviesLoading,
      bool moviesFailed,
      List<Movie> movies,
      bool performersLoading,
      bool performersFailed,
      List<Performer> performers,
      bool sectionsLoading,
      bool sectionsFailed,
      Map<MovieCategory, List<Movie>> sections});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? timeWindow = null,
    Object? moviesLoading = null,
    Object? moviesFailed = null,
    Object? movies = null,
    Object? performersLoading = null,
    Object? performersFailed = null,
    Object? performers = null,
    Object? sectionsLoading = null,
    Object? sectionsFailed = null,
    Object? sections = null,
  }) {
    return _then(_HomeState(
      timeWindow: null == timeWindow
          ? _self.timeWindow
          : timeWindow // ignore: cast_nullable_to_non_nullable
              as TimeWindow,
      moviesLoading: null == moviesLoading
          ? _self.moviesLoading
          : moviesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      moviesFailed: null == moviesFailed
          ? _self.moviesFailed
          : moviesFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      movies: null == movies
          ? _self._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
      performersLoading: null == performersLoading
          ? _self.performersLoading
          : performersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      performersFailed: null == performersFailed
          ? _self.performersFailed
          : performersFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      performers: null == performers
          ? _self._performers
          : performers // ignore: cast_nullable_to_non_nullable
              as List<Performer>,
      sectionsLoading: null == sectionsLoading
          ? _self.sectionsLoading
          : sectionsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      sectionsFailed: null == sectionsFailed
          ? _self.sectionsFailed
          : sectionsFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      sections: null == sections
          ? _self._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as Map<MovieCategory, List<Movie>>,
    ));
  }
}

// dart format on
