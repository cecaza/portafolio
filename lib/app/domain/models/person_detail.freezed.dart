// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonDetail {
  int get id;
  String get name;
  String get biography;
  @JsonKey(name: 'profile_path')
  String? get profilePath;
  @JsonKey(name: 'known_for_department')
  String? get department;
  String? get birthday;
  @JsonKey(name: 'place_of_birth')
  String? get placeOfBirth;
  @JsonKey(name: 'movie_credits', readValue: _readCast)
  List<PersonMovie> get movies;

  /// Create a copy of PersonDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PersonDetailCopyWith<PersonDetail> get copyWith =>
      _$PersonDetailCopyWithImpl<PersonDetail>(
          this as PersonDetail, _$identity);

  /// Serializes this PersonDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PersonDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.biography, biography) ||
                other.biography == biography) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.placeOfBirth, placeOfBirth) ||
                other.placeOfBirth == placeOfBirth) &&
            const DeepCollectionEquality().equals(other.movies, movies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      biography,
      profilePath,
      department,
      birthday,
      placeOfBirth,
      const DeepCollectionEquality().hash(movies));

  @override
  String toString() {
    return 'PersonDetail(id: $id, name: $name, biography: $biography, profilePath: $profilePath, department: $department, birthday: $birthday, placeOfBirth: $placeOfBirth, movies: $movies)';
  }
}

/// @nodoc
abstract mixin class $PersonDetailCopyWith<$Res> {
  factory $PersonDetailCopyWith(
          PersonDetail value, $Res Function(PersonDetail) _then) =
      _$PersonDetailCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String biography,
      @JsonKey(name: 'profile_path') String? profilePath,
      @JsonKey(name: 'known_for_department') String? department,
      String? birthday,
      @JsonKey(name: 'place_of_birth') String? placeOfBirth,
      @JsonKey(name: 'movie_credits', readValue: _readCast)
      List<PersonMovie> movies});
}

/// @nodoc
class _$PersonDetailCopyWithImpl<$Res> implements $PersonDetailCopyWith<$Res> {
  _$PersonDetailCopyWithImpl(this._self, this._then);

  final PersonDetail _self;
  final $Res Function(PersonDetail) _then;

  /// Create a copy of PersonDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? biography = null,
    Object? profilePath = freezed,
    Object? department = freezed,
    Object? birthday = freezed,
    Object? placeOfBirth = freezed,
    Object? movies = null,
  }) {
    return _then(PersonDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      biography: null == biography
          ? _self.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _self.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _self.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      placeOfBirth: freezed == placeOfBirth
          ? _self.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      movies: null == movies
          ? _self.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<PersonMovie>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PersonDetail].
extension PersonDetailPatterns on PersonDetail {
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
    TResult Function(_PersonDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PersonDetail() when $default != null:
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
    TResult Function(_PersonDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonDetail():
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
    TResult? Function(_PersonDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonDetail() when $default != null:
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
            String name,
            String biography,
            @JsonKey(name: 'profile_path') String? profilePath,
            @JsonKey(name: 'known_for_department') String? department,
            String? birthday,
            @JsonKey(name: 'place_of_birth') String? placeOfBirth,
            @JsonKey(name: 'movie_credits', readValue: _readCast)
            List<PersonMovie> movies)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PersonDetail() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.biography,
            _that.profilePath,
            _that.department,
            _that.birthday,
            _that.placeOfBirth,
            _that.movies);
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
            String name,
            String biography,
            @JsonKey(name: 'profile_path') String? profilePath,
            @JsonKey(name: 'known_for_department') String? department,
            String? birthday,
            @JsonKey(name: 'place_of_birth') String? placeOfBirth,
            @JsonKey(name: 'movie_credits', readValue: _readCast)
            List<PersonMovie> movies)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonDetail():
        return $default(
            _that.id,
            _that.name,
            _that.biography,
            _that.profilePath,
            _that.department,
            _that.birthday,
            _that.placeOfBirth,
            _that.movies);
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
            String name,
            String biography,
            @JsonKey(name: 'profile_path') String? profilePath,
            @JsonKey(name: 'known_for_department') String? department,
            String? birthday,
            @JsonKey(name: 'place_of_birth') String? placeOfBirth,
            @JsonKey(name: 'movie_credits', readValue: _readCast)
            List<PersonMovie> movies)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonDetail() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.biography,
            _that.profilePath,
            _that.department,
            _that.birthday,
            _that.placeOfBirth,
            _that.movies);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PersonDetail implements PersonDetail {
  const _PersonDetail(
      {required this.id,
      this.name = '',
      this.biography = '',
      @JsonKey(name: 'profile_path') this.profilePath,
      @JsonKey(name: 'known_for_department') this.department,
      this.birthday,
      @JsonKey(name: 'place_of_birth') this.placeOfBirth,
      @JsonKey(name: 'movie_credits', readValue: _readCast)
      List<PersonMovie> movies = const <PersonMovie>[]})
      : _movies = movies;
  factory _PersonDetail.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String biography;
  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @override
  @JsonKey(name: 'known_for_department')
  final String? department;
  @override
  final String? birthday;
  @override
  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;
  final List<PersonMovie> _movies;
  @override
  @JsonKey(name: 'movie_credits', readValue: _readCast)
  List<PersonMovie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  /// Create a copy of PersonDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PersonDetailCopyWith<_PersonDetail> get copyWith =>
      __$PersonDetailCopyWithImpl<_PersonDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PersonDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PersonDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.biography, biography) ||
                other.biography == biography) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.placeOfBirth, placeOfBirth) ||
                other.placeOfBirth == placeOfBirth) &&
            const DeepCollectionEquality().equals(other._movies, _movies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      biography,
      profilePath,
      department,
      birthday,
      placeOfBirth,
      const DeepCollectionEquality().hash(_movies));

  @override
  String toString() {
    return 'PersonDetail(id: $id, name: $name, biography: $biography, profilePath: $profilePath, department: $department, birthday: $birthday, placeOfBirth: $placeOfBirth, movies: $movies)';
  }
}

/// @nodoc
abstract mixin class _$PersonDetailCopyWith<$Res>
    implements $PersonDetailCopyWith<$Res> {
  factory _$PersonDetailCopyWith(
          _PersonDetail value, $Res Function(_PersonDetail) _then) =
      __$PersonDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String biography,
      @JsonKey(name: 'profile_path') String? profilePath,
      @JsonKey(name: 'known_for_department') String? department,
      String? birthday,
      @JsonKey(name: 'place_of_birth') String? placeOfBirth,
      @JsonKey(name: 'movie_credits', readValue: _readCast)
      List<PersonMovie> movies});
}

/// @nodoc
class __$PersonDetailCopyWithImpl<$Res>
    implements _$PersonDetailCopyWith<$Res> {
  __$PersonDetailCopyWithImpl(this._self, this._then);

  final _PersonDetail _self;
  final $Res Function(_PersonDetail) _then;

  /// Create a copy of PersonDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? biography = null,
    Object? profilePath = freezed,
    Object? department = freezed,
    Object? birthday = freezed,
    Object? placeOfBirth = freezed,
    Object? movies = null,
  }) {
    return _then(_PersonDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      biography: null == biography
          ? _self.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _self.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _self.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      placeOfBirth: freezed == placeOfBirth
          ? _self.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      movies: null == movies
          ? _self._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<PersonMovie>,
    ));
  }
}

/// @nodoc
mixin _$PersonMovie {
  int get id;
  String get title;
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @JsonKey(name: 'release_date')
  String? get releaseDate;
  String get character;

  /// Create a copy of PersonMovie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PersonMovieCopyWith<PersonMovie> get copyWith =>
      _$PersonMovieCopyWithImpl<PersonMovie>(this as PersonMovie, _$identity);

  /// Serializes this PersonMovie to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PersonMovie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.character, character) ||
                other.character == character));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, posterPath, voteAverage, releaseDate, character);

  @override
  String toString() {
    return 'PersonMovie(id: $id, title: $title, posterPath: $posterPath, voteAverage: $voteAverage, releaseDate: $releaseDate, character: $character)';
  }
}

/// @nodoc
abstract mixin class $PersonMovieCopyWith<$Res> {
  factory $PersonMovieCopyWith(
          PersonMovie value, $Res Function(PersonMovie) _then) =
      _$PersonMovieCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'release_date') String? releaseDate,
      String character});
}

/// @nodoc
class _$PersonMovieCopyWithImpl<$Res> implements $PersonMovieCopyWith<$Res> {
  _$PersonMovieCopyWithImpl(this._self, this._then);

  final PersonMovie _self;
  final $Res Function(PersonMovie) _then;

  /// Create a copy of PersonMovie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? posterPath = freezed,
    Object? voteAverage = null,
    Object? releaseDate = freezed,
    Object? character = null,
  }) {
    return _then(PersonMovie(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
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
      character: null == character
          ? _self.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PersonMovie].
extension PersonMoviePatterns on PersonMovie {
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
    TResult Function(_PersonMovie value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PersonMovie() when $default != null:
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
    TResult Function(_PersonMovie value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonMovie():
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
    TResult? Function(_PersonMovie value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonMovie() when $default != null:
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
            @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'vote_average') double voteAverage,
            @JsonKey(name: 'release_date') String? releaseDate,
            String character)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PersonMovie() when $default != null:
        return $default(_that.id, _that.title, _that.posterPath,
            _that.voteAverage, _that.releaseDate, _that.character);
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
            @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'vote_average') double voteAverage,
            @JsonKey(name: 'release_date') String? releaseDate,
            String character)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonMovie():
        return $default(_that.id, _that.title, _that.posterPath,
            _that.voteAverage, _that.releaseDate, _that.character);
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
            @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'vote_average') double voteAverage,
            @JsonKey(name: 'release_date') String? releaseDate,
            String character)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PersonMovie() when $default != null:
        return $default(_that.id, _that.title, _that.posterPath,
            _that.voteAverage, _that.releaseDate, _that.character);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PersonMovie implements PersonMovie {
  const _PersonMovie(
      {required this.id,
      this.title = '',
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'release_date') this.releaseDate,
      this.character = ''});
  factory _PersonMovie.fromJson(Map<String, dynamic> json) =>
      _$PersonMovieFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
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
  final String character;

  /// Create a copy of PersonMovie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PersonMovieCopyWith<_PersonMovie> get copyWith =>
      __$PersonMovieCopyWithImpl<_PersonMovie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PersonMovieToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PersonMovie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.character, character) ||
                other.character == character));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, posterPath, voteAverage, releaseDate, character);

  @override
  String toString() {
    return 'PersonMovie(id: $id, title: $title, posterPath: $posterPath, voteAverage: $voteAverage, releaseDate: $releaseDate, character: $character)';
  }
}

/// @nodoc
abstract mixin class _$PersonMovieCopyWith<$Res>
    implements $PersonMovieCopyWith<$Res> {
  factory _$PersonMovieCopyWith(
          _PersonMovie value, $Res Function(_PersonMovie) _then) =
      __$PersonMovieCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'release_date') String? releaseDate,
      String character});
}

/// @nodoc
class __$PersonMovieCopyWithImpl<$Res> implements _$PersonMovieCopyWith<$Res> {
  __$PersonMovieCopyWithImpl(this._self, this._then);

  final _PersonMovie _self;
  final $Res Function(_PersonMovie) _then;

  /// Create a copy of PersonMovie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? posterPath = freezed,
    Object? voteAverage = null,
    Object? releaseDate = freezed,
    Object? character = null,
  }) {
    return _then(_PersonMovie(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
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
      character: null == character
          ? _self.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
