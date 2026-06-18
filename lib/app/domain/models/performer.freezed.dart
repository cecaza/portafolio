// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Performer {
  int get id;
  String get name;
  @JsonKey(name: 'profile_path')
  String? get profilePath;
  Gender get gender;
  @JsonKey(name: 'known_for_department')
  String? get department;
  @JsonKey(name: 'known_for')
  List<KnownFor> get knownFor;

  /// Create a copy of Performer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PerformerCopyWith<Performer> get copyWith =>
      _$PerformerCopyWithImpl<Performer>(this as Performer, _$identity);

  /// Serializes this Performer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Performer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.department, department) ||
                other.department == department) &&
            const DeepCollectionEquality().equals(other.knownFor, knownFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, profilePath, gender,
      department, const DeepCollectionEquality().hash(knownFor));

  @override
  String toString() {
    return 'Performer(id: $id, name: $name, profilePath: $profilePath, gender: $gender, department: $department, knownFor: $knownFor)';
  }
}

/// @nodoc
abstract mixin class $PerformerCopyWith<$Res> {
  factory $PerformerCopyWith(Performer value, $Res Function(Performer) _then) =
      _$PerformerCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'profile_path') String? profilePath,
      Gender gender,
      @JsonKey(name: 'known_for_department') String? department,
      @JsonKey(name: 'known_for') List<KnownFor> knownFor});
}

/// @nodoc
class _$PerformerCopyWithImpl<$Res> implements $PerformerCopyWith<$Res> {
  _$PerformerCopyWithImpl(this._self, this._then);

  final Performer _self;
  final $Res Function(Performer) _then;

  /// Create a copy of Performer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profilePath = freezed,
    Object? gender = null,
    Object? department = freezed,
    Object? knownFor = null,
  }) {
    return _then(Performer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _self.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      department: freezed == department
          ? _self.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      knownFor: null == knownFor
          ? _self.knownFor
          : knownFor // ignore: cast_nullable_to_non_nullable
              as List<KnownFor>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Performer].
extension PerformerPatterns on Performer {
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
    TResult Function(_Performer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Performer() when $default != null:
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
    TResult Function(_Performer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Performer():
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
    TResult? Function(_Performer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Performer() when $default != null:
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
            @JsonKey(name: 'profile_path') String? profilePath,
            Gender gender,
            @JsonKey(name: 'known_for_department') String? department,
            @JsonKey(name: 'known_for') List<KnownFor> knownFor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Performer() when $default != null:
        return $default(_that.id, _that.name, _that.profilePath, _that.gender,
            _that.department, _that.knownFor);
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
            @JsonKey(name: 'profile_path') String? profilePath,
            Gender gender,
            @JsonKey(name: 'known_for_department') String? department,
            @JsonKey(name: 'known_for') List<KnownFor> knownFor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Performer():
        return $default(_that.id, _that.name, _that.profilePath, _that.gender,
            _that.department, _that.knownFor);
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
            @JsonKey(name: 'profile_path') String? profilePath,
            Gender gender,
            @JsonKey(name: 'known_for_department') String? department,
            @JsonKey(name: 'known_for') List<KnownFor> knownFor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Performer() when $default != null:
        return $default(_that.id, _that.name, _that.profilePath, _that.gender,
            _that.department, _that.knownFor);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Performer implements Performer {
  const _Performer(
      {required this.id,
      this.name = '',
      @JsonKey(name: 'profile_path') this.profilePath,
      this.gender = Gender.unknown,
      @JsonKey(name: 'known_for_department') this.department,
      @JsonKey(name: 'known_for') List<KnownFor> knownFor = const <KnownFor>[]})
      : _knownFor = knownFor;
  factory _Performer.fromJson(Map<String, dynamic> json) =>
      _$PerformerFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @override
  @JsonKey()
  final Gender gender;
  @override
  @JsonKey(name: 'known_for_department')
  final String? department;
  final List<KnownFor> _knownFor;
  @override
  @JsonKey(name: 'known_for')
  List<KnownFor> get knownFor {
    if (_knownFor is EqualUnmodifiableListView) return _knownFor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_knownFor);
  }

  /// Create a copy of Performer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PerformerCopyWith<_Performer> get copyWith =>
      __$PerformerCopyWithImpl<_Performer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PerformerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Performer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.department, department) ||
                other.department == department) &&
            const DeepCollectionEquality().equals(other._knownFor, _knownFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, profilePath, gender,
      department, const DeepCollectionEquality().hash(_knownFor));

  @override
  String toString() {
    return 'Performer(id: $id, name: $name, profilePath: $profilePath, gender: $gender, department: $department, knownFor: $knownFor)';
  }
}

/// @nodoc
abstract mixin class _$PerformerCopyWith<$Res>
    implements $PerformerCopyWith<$Res> {
  factory _$PerformerCopyWith(
          _Performer value, $Res Function(_Performer) _then) =
      __$PerformerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'profile_path') String? profilePath,
      Gender gender,
      @JsonKey(name: 'known_for_department') String? department,
      @JsonKey(name: 'known_for') List<KnownFor> knownFor});
}

/// @nodoc
class __$PerformerCopyWithImpl<$Res> implements _$PerformerCopyWith<$Res> {
  __$PerformerCopyWithImpl(this._self, this._then);

  final _Performer _self;
  final $Res Function(_Performer) _then;

  /// Create a copy of Performer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profilePath = freezed,
    Object? gender = null,
    Object? department = freezed,
    Object? knownFor = null,
  }) {
    return _then(_Performer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _self.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      department: freezed == department
          ? _self.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      knownFor: null == knownFor
          ? _self._knownFor
          : knownFor // ignore: cast_nullable_to_non_nullable
              as List<KnownFor>,
    ));
  }
}

/// @nodoc
mixin _$KnownFor {
  int get id;
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @JsonKey(name: 'title', readValue: _readTitle)
  String get title;

  /// Create a copy of KnownFor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KnownForCopyWith<KnownFor> get copyWith =>
      _$KnownForCopyWithImpl<KnownFor>(this as KnownFor, _$identity);

  /// Serializes this KnownFor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KnownFor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, posterPath, title);

  @override
  String toString() {
    return 'KnownFor(id: $id, posterPath: $posterPath, title: $title)';
  }
}

/// @nodoc
abstract mixin class $KnownForCopyWith<$Res> {
  factory $KnownForCopyWith(KnownFor value, $Res Function(KnownFor) _then) =
      _$KnownForCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'title', readValue: _readTitle) String title});
}

/// @nodoc
class _$KnownForCopyWithImpl<$Res> implements $KnownForCopyWith<$Res> {
  _$KnownForCopyWithImpl(this._self, this._then);

  final KnownFor _self;
  final $Res Function(KnownFor) _then;

  /// Create a copy of KnownFor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? posterPath = freezed,
    Object? title = null,
  }) {
    return _then(KnownFor(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      posterPath: freezed == posterPath
          ? _self.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [KnownFor].
extension KnownForPatterns on KnownFor {
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
    TResult Function(_KnownFor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KnownFor() when $default != null:
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
    TResult Function(_KnownFor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KnownFor():
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
    TResult? Function(_KnownFor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KnownFor() when $default != null:
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
    TResult Function(int id, @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'title', readValue: _readTitle) String title)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KnownFor() when $default != null:
        return $default(_that.id, _that.posterPath, _that.title);
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
    TResult Function(int id, @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'title', readValue: _readTitle) String title)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KnownFor():
        return $default(_that.id, _that.posterPath, _that.title);
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
    TResult? Function(int id, @JsonKey(name: 'poster_path') String? posterPath,
            @JsonKey(name: 'title', readValue: _readTitle) String title)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KnownFor() when $default != null:
        return $default(_that.id, _that.posterPath, _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _KnownFor implements KnownFor {
  const _KnownFor(
      {required this.id,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'title', readValue: _readTitle) this.title = ''});
  factory _KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'title', readValue: _readTitle)
  final String title;

  /// Create a copy of KnownFor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KnownForCopyWith<_KnownFor> get copyWith =>
      __$KnownForCopyWithImpl<_KnownFor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KnownForToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KnownFor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, posterPath, title);

  @override
  String toString() {
    return 'KnownFor(id: $id, posterPath: $posterPath, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$KnownForCopyWith<$Res>
    implements $KnownForCopyWith<$Res> {
  factory _$KnownForCopyWith(_KnownFor value, $Res Function(_KnownFor) _then) =
      __$KnownForCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'title', readValue: _readTitle) String title});
}

/// @nodoc
class __$KnownForCopyWithImpl<$Res> implements _$KnownForCopyWith<$Res> {
  __$KnownForCopyWithImpl(this._self, this._then);

  final _KnownFor _self;
  final $Res Function(_KnownFor) _then;

  /// Create a copy of KnownFor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? posterPath = freezed,
    Object? title = null,
  }) {
    return _then(_KnownFor(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      posterPath: freezed == posterPath
          ? _self.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
