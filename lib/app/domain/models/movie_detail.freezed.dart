// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MovieDetail {
  int get id;
  String get title;
  String get overview;
  String get tagline;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @JsonKey(name: 'release_date')
  String? get releaseDate;
  int get runtime;
  List<Genre> get genres;
  @JsonKey(name: 'credits', readValue: _readCast)
  List<Cast> get cast;
  @JsonKey(name: 'account_states', readValue: _readFavorite)
  bool get isFavorite;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MovieDetailCopyWith<MovieDetail> get copyWith =>
      _$MovieDetailCopyWithImpl<MovieDetail>(this as MovieDetail, _$identity);

  /// Serializes this MovieDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MovieDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            const DeepCollectionEquality().equals(other.genres, genres) &&
            const DeepCollectionEquality().equals(other.cast, cast) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      overview,
      tagline,
      backdropPath,
      posterPath,
      voteAverage,
      releaseDate,
      runtime,
      const DeepCollectionEquality().hash(genres),
      const DeepCollectionEquality().hash(cast),
      isFavorite);

  @override
  String toString() {
    return 'MovieDetail(id: $id, title: $title, overview: $overview, tagline: $tagline, backdropPath: $backdropPath, posterPath: $posterPath, voteAverage: $voteAverage, releaseDate: $releaseDate, runtime: $runtime, genres: $genres, cast: $cast, isFavorite: $isFavorite)';
  }
}

/// @nodoc
abstract mixin class $MovieDetailCopyWith<$Res> {
  factory $MovieDetailCopyWith(
          MovieDetail value, $Res Function(MovieDetail) _then) =
      _$MovieDetailCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String overview,
      String tagline,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'release_date') String? releaseDate,
      int runtime,
      List<Genre> genres,
      @JsonKey(name: 'credits', readValue: _readCast) List<Cast> cast,
      @JsonKey(name: 'account_states', readValue: _readFavorite)
      bool isFavorite});
}

/// @nodoc
class _$MovieDetailCopyWithImpl<$Res> implements $MovieDetailCopyWith<$Res> {
  _$MovieDetailCopyWithImpl(this._self, this._then);

  final MovieDetail _self;
  final $Res Function(MovieDetail) _then;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? tagline = null,
    Object? backdropPath = freezed,
    Object? posterPath = freezed,
    Object? voteAverage = null,
    Object? releaseDate = freezed,
    Object? runtime = null,
    Object? genres = null,
    Object? cast = null,
    Object? isFavorite = null,
  }) {
    return _then(MovieDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _self.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      tagline: null == tagline
          ? _self.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: freezed == backdropPath
          ? _self.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _self.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _self.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: null == runtime
          ? _self.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
      cast: null == cast
          ? _self.cast
          : cast // ignore: cast_nullable_to_non_nullable
              as List<Cast>,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [MovieDetail].
extension MovieDetailPatterns on MovieDetail {
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
    TResult Function(_MovieDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MovieDetail() when $default != null:
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
    TResult Function(_MovieDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MovieDetail():
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
    TResult? Function(_MovieDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MovieDetail() when $default != null:
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
            int id,
            String title,
            String overview,
            String tagline,
            @JsonKey(name: 'backdrop_path') String? backdropPath,
            @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'vote_average') double voteAverage,
            @JsonKey(name: 'release_date') String? releaseDate,
            int runtime,
            List<Genre> genres,
            @JsonKey(name: 'credits', readValue: _readCast) List<Cast> cast,
            @JsonKey(name: 'account_states', readValue: _readFavorite)
            bool isFavorite)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MovieDetail() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.overview,
            _that.tagline,
            _that.backdropPath,
            _that.posterPath,
            _that.voteAverage,
            _that.releaseDate,
            _that.runtime,
            _that.genres,
            _that.cast,
            _that.isFavorite);
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
            int id,
            String title,
            String overview,
            String tagline,
            @JsonKey(name: 'backdrop_path') String? backdropPath,
            @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'vote_average') double voteAverage,
            @JsonKey(name: 'release_date') String? releaseDate,
            int runtime,
            List<Genre> genres,
            @JsonKey(name: 'credits', readValue: _readCast) List<Cast> cast,
            @JsonKey(name: 'account_states', readValue: _readFavorite)
            bool isFavorite)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MovieDetail():
        return $default(
            _that.id,
            _that.title,
            _that.overview,
            _that.tagline,
            _that.backdropPath,
            _that.posterPath,
            _that.voteAverage,
            _that.releaseDate,
            _that.runtime,
            _that.genres,
            _that.cast,
            _that.isFavorite);
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
            int id,
            String title,
            String overview,
            String tagline,
            @JsonKey(name: 'backdrop_path') String? backdropPath,
            @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'vote_average') double voteAverage,
            @JsonKey(name: 'release_date') String? releaseDate,
            int runtime,
            List<Genre> genres,
            @JsonKey(name: 'credits', readValue: _readCast) List<Cast> cast,
            @JsonKey(name: 'account_states', readValue: _readFavorite)
            bool isFavorite)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MovieDetail() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.overview,
            _that.tagline,
            _that.backdropPath,
            _that.posterPath,
            _that.voteAverage,
            _that.releaseDate,
            _that.runtime,
            _that.genres,
            _that.cast,
            _that.isFavorite);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MovieDetail implements MovieDetail {
  const _MovieDetail(
      {required this.id,
      this.title = '',
      this.overview = '',
      this.tagline = '',
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'release_date') this.releaseDate,
      this.runtime = 0,
      List<Genre> genres = const <Genre>[],
      @JsonKey(name: 'credits', readValue: _readCast)
      List<Cast> cast = const <Cast>[],
      @JsonKey(name: 'account_states', readValue: _readFavorite)
      this.isFavorite = false})
      : _genres = genres,
        _cast = cast;
  factory _MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String overview;
  @override
  @JsonKey()
  final String tagline;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @override
  @JsonKey()
  final int runtime;
  final List<Genre> _genres;
  @override
  @JsonKey()
  List<Genre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<Cast> _cast;
  @override
  @JsonKey(name: 'credits', readValue: _readCast)
  List<Cast> get cast {
    if (_cast is EqualUnmodifiableListView) return _cast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cast);
  }

  @override
  @JsonKey(name: 'account_states', readValue: _readFavorite)
  final bool isFavorite;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MovieDetailCopyWith<_MovieDetail> get copyWith =>
      __$MovieDetailCopyWithImpl<_MovieDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MovieDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MovieDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality().equals(other._cast, _cast) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      overview,
      tagline,
      backdropPath,
      posterPath,
      voteAverage,
      releaseDate,
      runtime,
      const DeepCollectionEquality().hash(_genres),
      const DeepCollectionEquality().hash(_cast),
      isFavorite);

  @override
  String toString() {
    return 'MovieDetail(id: $id, title: $title, overview: $overview, tagline: $tagline, backdropPath: $backdropPath, posterPath: $posterPath, voteAverage: $voteAverage, releaseDate: $releaseDate, runtime: $runtime, genres: $genres, cast: $cast, isFavorite: $isFavorite)';
  }
}

/// @nodoc
abstract mixin class _$MovieDetailCopyWith<$Res>
    implements $MovieDetailCopyWith<$Res> {
  factory _$MovieDetailCopyWith(
          _MovieDetail value, $Res Function(_MovieDetail) _then) =
      __$MovieDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String overview,
      String tagline,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'release_date') String? releaseDate,
      int runtime,
      List<Genre> genres,
      @JsonKey(name: 'credits', readValue: _readCast) List<Cast> cast,
      @JsonKey(name: 'account_states', readValue: _readFavorite)
      bool isFavorite});
}

/// @nodoc
class __$MovieDetailCopyWithImpl<$Res> implements _$MovieDetailCopyWith<$Res> {
  __$MovieDetailCopyWithImpl(this._self, this._then);

  final _MovieDetail _self;
  final $Res Function(_MovieDetail) _then;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? tagline = null,
    Object? backdropPath = freezed,
    Object? posterPath = freezed,
    Object? voteAverage = null,
    Object? releaseDate = freezed,
    Object? runtime = null,
    Object? genres = null,
    Object? cast = null,
    Object? isFavorite = null,
  }) {
    return _then(_MovieDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _self.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      tagline: null == tagline
          ? _self.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: freezed == backdropPath
          ? _self.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _self.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _self.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: null == runtime
          ? _self.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
      cast: null == cast
          ? _self._cast
          : cast // ignore: cast_nullable_to_non_nullable
              as List<Cast>,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$Cast {
  int get id;
  String get name;
  String get character;
  @JsonKey(name: 'profile_path')
  String? get profilePath;

  /// Create a copy of Cast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CastCopyWith<Cast> get copyWith =>
      _$CastCopyWithImpl<Cast>(this as Cast, _$identity);

  /// Serializes this Cast to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Cast &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, character, profilePath);

  @override
  String toString() {
    return 'Cast(id: $id, name: $name, character: $character, profilePath: $profilePath)';
  }
}

/// @nodoc
abstract mixin class $CastCopyWith<$Res> {
  factory $CastCopyWith(Cast value, $Res Function(Cast) _then) =
      _$CastCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String character,
      @JsonKey(name: 'profile_path') String? profilePath});
}

/// @nodoc
class _$CastCopyWithImpl<$Res> implements $CastCopyWith<$Res> {
  _$CastCopyWithImpl(this._self, this._then);

  final Cast _self;
  final $Res Function(Cast) _then;

  /// Create a copy of Cast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? character = null,
    Object? profilePath = freezed,
  }) {
    return _then(Cast(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      character: null == character
          ? _self.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _self.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Cast].
extension CastPatterns on Cast {
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
    TResult Function(_Cast value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Cast() when $default != null:
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
    TResult Function(_Cast value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Cast():
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
    TResult? Function(_Cast value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Cast() when $default != null:
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
    TResult Function(int id, String name, String character,
            @JsonKey(name: 'profile_path') String? profilePath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Cast() when $default != null:
        return $default(
            _that.id, _that.name, _that.character, _that.profilePath);
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
    TResult Function(int id, String name, String character,
            @JsonKey(name: 'profile_path') String? profilePath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Cast():
        return $default(
            _that.id, _that.name, _that.character, _that.profilePath);
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
    TResult? Function(int id, String name, String character,
            @JsonKey(name: 'profile_path') String? profilePath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Cast() when $default != null:
        return $default(
            _that.id, _that.name, _that.character, _that.profilePath);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Cast implements Cast {
  const _Cast(
      {required this.id,
      this.name = '',
      this.character = '',
      @JsonKey(name: 'profile_path') this.profilePath});
  factory _Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String character;
  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  /// Create a copy of Cast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CastCopyWith<_Cast> get copyWith =>
      __$CastCopyWithImpl<_Cast>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CastToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Cast &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, character, profilePath);

  @override
  String toString() {
    return 'Cast(id: $id, name: $name, character: $character, profilePath: $profilePath)';
  }
}

/// @nodoc
abstract mixin class _$CastCopyWith<$Res> implements $CastCopyWith<$Res> {
  factory _$CastCopyWith(_Cast value, $Res Function(_Cast) _then) =
      __$CastCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String character,
      @JsonKey(name: 'profile_path') String? profilePath});
}

/// @nodoc
class __$CastCopyWithImpl<$Res> implements _$CastCopyWith<$Res> {
  __$CastCopyWithImpl(this._self, this._then);

  final _Cast _self;
  final $Res Function(_Cast) _then;

  /// Create a copy of Cast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? character = null,
    Object? profilePath = freezed,
  }) {
    return _then(_Cast(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      character: null == character
          ? _self.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _self.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Genre {
  int get id;
  String get name;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenreCopyWith<Genre> get copyWith =>
      _$GenreCopyWithImpl<Genre>(this as Genre, _$identity);

  /// Serializes this Genre to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Genre &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'Genre(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $GenreCopyWith<$Res> {
  factory $GenreCopyWith(Genre value, $Res Function(Genre) _then) =
      _$GenreCopyWithImpl;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$GenreCopyWithImpl<$Res> implements $GenreCopyWith<$Res> {
  _$GenreCopyWithImpl(this._self, this._then);

  final Genre _self;
  final $Res Function(Genre) _then;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(Genre(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Genre].
extension GenrePatterns on Genre {
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
    TResult Function(_Genre value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Genre() when $default != null:
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
    TResult Function(_Genre value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Genre():
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
    TResult? Function(_Genre value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Genre() when $default != null:
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
    TResult Function(int id, String name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Genre() when $default != null:
        return $default(_that.id, _that.name);
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
    TResult Function(int id, String name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Genre():
        return $default(_that.id, _that.name);
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
    TResult? Function(int id, String name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Genre() when $default != null:
        return $default(_that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Genre implements Genre {
  const _Genre({required this.id, this.name = ''});
  factory _Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String name;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenreCopyWith<_Genre> get copyWith =>
      __$GenreCopyWithImpl<_Genre>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GenreToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Genre &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'Genre(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$GenreCopyWith<$Res> implements $GenreCopyWith<$Res> {
  factory _$GenreCopyWith(_Genre value, $Res Function(_Genre) _then) =
      __$GenreCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$GenreCopyWithImpl<$Res> implements _$GenreCopyWith<$Res> {
  __$GenreCopyWithImpl(this._self, this._then);

  final _Genre _self;
  final $Res Function(_Genre) _then;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_Genre(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
