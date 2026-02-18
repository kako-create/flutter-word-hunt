// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puzzle_v1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$I18nText {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is I18nText);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'I18nText()';
}


}

/// @nodoc
class $I18nTextCopyWith<$Res>  {
$I18nTextCopyWith(I18nText _, $Res Function(I18nText) __);
}


/// Adds pattern-matching-related methods to [I18nText].
extension I18nTextPatterns on I18nText {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _I18nTextRaw value)?  raw,TResult Function( _I18nTextLocalized value)?  localized,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _I18nTextRaw() when raw != null:
return raw(_that);case _I18nTextLocalized() when localized != null:
return localized(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _I18nTextRaw value)  raw,required TResult Function( _I18nTextLocalized value)  localized,}){
final _that = this;
switch (_that) {
case _I18nTextRaw():
return raw(_that);case _I18nTextLocalized():
return localized(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _I18nTextRaw value)?  raw,TResult? Function( _I18nTextLocalized value)?  localized,}){
final _that = this;
switch (_that) {
case _I18nTextRaw() when raw != null:
return raw(_that);case _I18nTextLocalized() when localized != null:
return localized(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  raw,TResult Function( Map<String, String> values)?  localized,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _I18nTextRaw() when raw != null:
return raw(_that.value);case _I18nTextLocalized() when localized != null:
return localized(_that.values);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  raw,required TResult Function( Map<String, String> values)  localized,}) {final _that = this;
switch (_that) {
case _I18nTextRaw():
return raw(_that.value);case _I18nTextLocalized():
return localized(_that.values);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  raw,TResult? Function( Map<String, String> values)?  localized,}) {final _that = this;
switch (_that) {
case _I18nTextRaw() when raw != null:
return raw(_that.value);case _I18nTextLocalized() when localized != null:
return localized(_that.values);case _:
  return null;

}
}

}

/// @nodoc


class _I18nTextRaw extends I18nText {
  const _I18nTextRaw(this.value): super._();
  

 final  String value;

/// Create a copy of I18nText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$I18nTextRawCopyWith<_I18nTextRaw> get copyWith => __$I18nTextRawCopyWithImpl<_I18nTextRaw>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _I18nTextRaw&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'I18nText.raw(value: $value)';
}


}

/// @nodoc
abstract mixin class _$I18nTextRawCopyWith<$Res> implements $I18nTextCopyWith<$Res> {
  factory _$I18nTextRawCopyWith(_I18nTextRaw value, $Res Function(_I18nTextRaw) _then) = __$I18nTextRawCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$I18nTextRawCopyWithImpl<$Res>
    implements _$I18nTextRawCopyWith<$Res> {
  __$I18nTextRawCopyWithImpl(this._self, this._then);

  final _I18nTextRaw _self;
  final $Res Function(_I18nTextRaw) _then;

/// Create a copy of I18nText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_I18nTextRaw(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _I18nTextLocalized extends I18nText {
  const _I18nTextLocalized(final  Map<String, String> values): _values = values,super._();
  

 final  Map<String, String> _values;
 Map<String, String> get values {
  if (_values is EqualUnmodifiableMapView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_values);
}


/// Create a copy of I18nText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$I18nTextLocalizedCopyWith<_I18nTextLocalized> get copyWith => __$I18nTextLocalizedCopyWithImpl<_I18nTextLocalized>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _I18nTextLocalized&&const DeepCollectionEquality().equals(other._values, _values));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_values));

@override
String toString() {
  return 'I18nText.localized(values: $values)';
}


}

/// @nodoc
abstract mixin class _$I18nTextLocalizedCopyWith<$Res> implements $I18nTextCopyWith<$Res> {
  factory _$I18nTextLocalizedCopyWith(_I18nTextLocalized value, $Res Function(_I18nTextLocalized) _then) = __$I18nTextLocalizedCopyWithImpl;
@useResult
$Res call({
 Map<String, String> values
});




}
/// @nodoc
class __$I18nTextLocalizedCopyWithImpl<$Res>
    implements _$I18nTextLocalizedCopyWith<$Res> {
  __$I18nTextLocalizedCopyWithImpl(this._self, this._then);

  final _I18nTextLocalized _self;
  final $Res Function(_I18nTextLocalized) _then;

/// Create a copy of I18nText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? values = null,}) {
  return _then(_I18nTextLocalized(
null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}


/// @nodoc
mixin _$PuzzleV1 {

 String get schema; String get id;@I18nTextConverter() I18nText get title; PuzzleContent get content; List<PuzzleVariant> get variants; JsonMap? get extensions;
/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleV1CopyWith<PuzzleV1> get copyWith => _$PuzzleV1CopyWithImpl<PuzzleV1>(this as PuzzleV1, _$identity);

  /// Serializes this PuzzleV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleV1&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.variants, variants)&&const DeepCollectionEquality().equals(other.extensions, extensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,id,title,content,const DeepCollectionEquality().hash(variants),const DeepCollectionEquality().hash(extensions));

@override
String toString() {
  return 'PuzzleV1(schema: $schema, id: $id, title: $title, content: $content, variants: $variants, extensions: $extensions)';
}


}

/// @nodoc
abstract mixin class $PuzzleV1CopyWith<$Res>  {
  factory $PuzzleV1CopyWith(PuzzleV1 value, $Res Function(PuzzleV1) _then) = _$PuzzleV1CopyWithImpl;
@useResult
$Res call({
 String schema, String id,@I18nTextConverter() I18nText title, PuzzleContent content, List<PuzzleVariant> variants, JsonMap? extensions
});


$I18nTextCopyWith<$Res> get title;$PuzzleContentCopyWith<$Res> get content;

}
/// @nodoc
class _$PuzzleV1CopyWithImpl<$Res>
    implements $PuzzleV1CopyWith<$Res> {
  _$PuzzleV1CopyWithImpl(this._self, this._then);

  final PuzzleV1 _self;
  final $Res Function(PuzzleV1) _then;

/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schema = null,Object? id = null,Object? title = null,Object? content = null,Object? variants = null,Object? extensions = freezed,}) {
  return _then(_self.copyWith(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as I18nText,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PuzzleContent,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<PuzzleVariant>,extensions: freezed == extensions ? _self.extensions : extensions // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}
/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$I18nTextCopyWith<$Res> get title {
  
  return $I18nTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleContentCopyWith<$Res> get content {
  
  return $PuzzleContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [PuzzleV1].
extension PuzzleV1Patterns on PuzzleV1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleV1 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleV1() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleV1 value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleV1():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleV1 value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleV1() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String schema,  String id, @I18nTextConverter()  I18nText title,  PuzzleContent content,  List<PuzzleVariant> variants,  JsonMap? extensions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleV1() when $default != null:
return $default(_that.schema,_that.id,_that.title,_that.content,_that.variants,_that.extensions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String schema,  String id, @I18nTextConverter()  I18nText title,  PuzzleContent content,  List<PuzzleVariant> variants,  JsonMap? extensions)  $default,) {final _that = this;
switch (_that) {
case _PuzzleV1():
return $default(_that.schema,_that.id,_that.title,_that.content,_that.variants,_that.extensions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String schema,  String id, @I18nTextConverter()  I18nText title,  PuzzleContent content,  List<PuzzleVariant> variants,  JsonMap? extensions)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleV1() when $default != null:
return $default(_that.schema,_that.id,_that.title,_that.content,_that.variants,_that.extensions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PuzzleV1 implements PuzzleV1 {
  const _PuzzleV1({required this.schema, required this.id, @I18nTextConverter() required this.title, required this.content, required final  List<PuzzleVariant> variants, final  JsonMap? extensions}): _variants = variants,_extensions = extensions;
  factory _PuzzleV1.fromJson(Map<String, dynamic> json) => _$PuzzleV1FromJson(json);

@override final  String schema;
@override final  String id;
@override@I18nTextConverter() final  I18nText title;
@override final  PuzzleContent content;
 final  List<PuzzleVariant> _variants;
@override List<PuzzleVariant> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

 final  JsonMap? _extensions;
@override JsonMap? get extensions {
  final value = _extensions;
  if (value == null) return null;
  if (_extensions is EqualUnmodifiableMapView) return _extensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleV1CopyWith<_PuzzleV1> get copyWith => __$PuzzleV1CopyWithImpl<_PuzzleV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PuzzleV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleV1&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._variants, _variants)&&const DeepCollectionEquality().equals(other._extensions, _extensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,id,title,content,const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_extensions));

@override
String toString() {
  return 'PuzzleV1(schema: $schema, id: $id, title: $title, content: $content, variants: $variants, extensions: $extensions)';
}


}

/// @nodoc
abstract mixin class _$PuzzleV1CopyWith<$Res> implements $PuzzleV1CopyWith<$Res> {
  factory _$PuzzleV1CopyWith(_PuzzleV1 value, $Res Function(_PuzzleV1) _then) = __$PuzzleV1CopyWithImpl;
@override @useResult
$Res call({
 String schema, String id,@I18nTextConverter() I18nText title, PuzzleContent content, List<PuzzleVariant> variants, JsonMap? extensions
});


@override $I18nTextCopyWith<$Res> get title;@override $PuzzleContentCopyWith<$Res> get content;

}
/// @nodoc
class __$PuzzleV1CopyWithImpl<$Res>
    implements _$PuzzleV1CopyWith<$Res> {
  __$PuzzleV1CopyWithImpl(this._self, this._then);

  final _PuzzleV1 _self;
  final $Res Function(_PuzzleV1) _then;

/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? id = null,Object? title = null,Object? content = null,Object? variants = null,Object? extensions = freezed,}) {
  return _then(_PuzzleV1(
schema: null == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as I18nText,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PuzzleContent,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<PuzzleVariant>,extensions: freezed == extensions ? _self._extensions : extensions // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}

/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$I18nTextCopyWith<$Res> get title {
  
  return $I18nTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of PuzzleV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleContentCopyWith<$Res> get content {
  
  return $PuzzleContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// @nodoc
mixin _$PuzzleContent {

 String get locale; NormalizeConfig? get normalize; PuzzleBoard get board; PuzzleLexicon get lexicon; PuzzleSolution get solution; JsonMap? get meta;
/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleContentCopyWith<PuzzleContent> get copyWith => _$PuzzleContentCopyWithImpl<PuzzleContent>(this as PuzzleContent, _$identity);

  /// Serializes this PuzzleContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleContent&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.normalize, normalize) || other.normalize == normalize)&&(identical(other.board, board) || other.board == board)&&(identical(other.lexicon, lexicon) || other.lexicon == lexicon)&&(identical(other.solution, solution) || other.solution == solution)&&const DeepCollectionEquality().equals(other.meta, meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,normalize,board,lexicon,solution,const DeepCollectionEquality().hash(meta));

@override
String toString() {
  return 'PuzzleContent(locale: $locale, normalize: $normalize, board: $board, lexicon: $lexicon, solution: $solution, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $PuzzleContentCopyWith<$Res>  {
  factory $PuzzleContentCopyWith(PuzzleContent value, $Res Function(PuzzleContent) _then) = _$PuzzleContentCopyWithImpl;
@useResult
$Res call({
 String locale, NormalizeConfig? normalize, PuzzleBoard board, PuzzleLexicon lexicon, PuzzleSolution solution, JsonMap? meta
});


$NormalizeConfigCopyWith<$Res>? get normalize;$PuzzleBoardCopyWith<$Res> get board;$PuzzleLexiconCopyWith<$Res> get lexicon;$PuzzleSolutionCopyWith<$Res> get solution;

}
/// @nodoc
class _$PuzzleContentCopyWithImpl<$Res>
    implements $PuzzleContentCopyWith<$Res> {
  _$PuzzleContentCopyWithImpl(this._self, this._then);

  final PuzzleContent _self;
  final $Res Function(PuzzleContent) _then;

/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? normalize = freezed,Object? board = null,Object? lexicon = null,Object? solution = null,Object? meta = freezed,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,normalize: freezed == normalize ? _self.normalize : normalize // ignore: cast_nullable_to_non_nullable
as NormalizeConfig?,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as PuzzleBoard,lexicon: null == lexicon ? _self.lexicon : lexicon // ignore: cast_nullable_to_non_nullable
as PuzzleLexicon,solution: null == solution ? _self.solution : solution // ignore: cast_nullable_to_non_nullable
as PuzzleSolution,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}
/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NormalizeConfigCopyWith<$Res>? get normalize {
    if (_self.normalize == null) {
    return null;
  }

  return $NormalizeConfigCopyWith<$Res>(_self.normalize!, (value) {
    return _then(_self.copyWith(normalize: value));
  });
}/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleBoardCopyWith<$Res> get board {
  
  return $PuzzleBoardCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleLexiconCopyWith<$Res> get lexicon {
  
  return $PuzzleLexiconCopyWith<$Res>(_self.lexicon, (value) {
    return _then(_self.copyWith(lexicon: value));
  });
}/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleSolutionCopyWith<$Res> get solution {
  
  return $PuzzleSolutionCopyWith<$Res>(_self.solution, (value) {
    return _then(_self.copyWith(solution: value));
  });
}
}


/// Adds pattern-matching-related methods to [PuzzleContent].
extension PuzzleContentPatterns on PuzzleContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleContent() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleContent value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleContent():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleContent value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleContent() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  NormalizeConfig? normalize,  PuzzleBoard board,  PuzzleLexicon lexicon,  PuzzleSolution solution,  JsonMap? meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleContent() when $default != null:
return $default(_that.locale,_that.normalize,_that.board,_that.lexicon,_that.solution,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  NormalizeConfig? normalize,  PuzzleBoard board,  PuzzleLexicon lexicon,  PuzzleSolution solution,  JsonMap? meta)  $default,) {final _that = this;
switch (_that) {
case _PuzzleContent():
return $default(_that.locale,_that.normalize,_that.board,_that.lexicon,_that.solution,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  NormalizeConfig? normalize,  PuzzleBoard board,  PuzzleLexicon lexicon,  PuzzleSolution solution,  JsonMap? meta)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleContent() when $default != null:
return $default(_that.locale,_that.normalize,_that.board,_that.lexicon,_that.solution,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PuzzleContent implements PuzzleContent {
  const _PuzzleContent({required this.locale, this.normalize, required this.board, required this.lexicon, required this.solution, final  JsonMap? meta}): _meta = meta;
  factory _PuzzleContent.fromJson(Map<String, dynamic> json) => _$PuzzleContentFromJson(json);

@override final  String locale;
@override final  NormalizeConfig? normalize;
@override final  PuzzleBoard board;
@override final  PuzzleLexicon lexicon;
@override final  PuzzleSolution solution;
 final  JsonMap? _meta;
@override JsonMap? get meta {
  final value = _meta;
  if (value == null) return null;
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleContentCopyWith<_PuzzleContent> get copyWith => __$PuzzleContentCopyWithImpl<_PuzzleContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PuzzleContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleContent&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.normalize, normalize) || other.normalize == normalize)&&(identical(other.board, board) || other.board == board)&&(identical(other.lexicon, lexicon) || other.lexicon == lexicon)&&(identical(other.solution, solution) || other.solution == solution)&&const DeepCollectionEquality().equals(other._meta, _meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,normalize,board,lexicon,solution,const DeepCollectionEquality().hash(_meta));

@override
String toString() {
  return 'PuzzleContent(locale: $locale, normalize: $normalize, board: $board, lexicon: $lexicon, solution: $solution, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$PuzzleContentCopyWith<$Res> implements $PuzzleContentCopyWith<$Res> {
  factory _$PuzzleContentCopyWith(_PuzzleContent value, $Res Function(_PuzzleContent) _then) = __$PuzzleContentCopyWithImpl;
@override @useResult
$Res call({
 String locale, NormalizeConfig? normalize, PuzzleBoard board, PuzzleLexicon lexicon, PuzzleSolution solution, JsonMap? meta
});


@override $NormalizeConfigCopyWith<$Res>? get normalize;@override $PuzzleBoardCopyWith<$Res> get board;@override $PuzzleLexiconCopyWith<$Res> get lexicon;@override $PuzzleSolutionCopyWith<$Res> get solution;

}
/// @nodoc
class __$PuzzleContentCopyWithImpl<$Res>
    implements _$PuzzleContentCopyWith<$Res> {
  __$PuzzleContentCopyWithImpl(this._self, this._then);

  final _PuzzleContent _self;
  final $Res Function(_PuzzleContent) _then;

/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? normalize = freezed,Object? board = null,Object? lexicon = null,Object? solution = null,Object? meta = freezed,}) {
  return _then(_PuzzleContent(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,normalize: freezed == normalize ? _self.normalize : normalize // ignore: cast_nullable_to_non_nullable
as NormalizeConfig?,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as PuzzleBoard,lexicon: null == lexicon ? _self.lexicon : lexicon // ignore: cast_nullable_to_non_nullable
as PuzzleLexicon,solution: null == solution ? _self.solution : solution // ignore: cast_nullable_to_non_nullable
as PuzzleSolution,meta: freezed == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}

/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NormalizeConfigCopyWith<$Res>? get normalize {
    if (_self.normalize == null) {
    return null;
  }

  return $NormalizeConfigCopyWith<$Res>(_self.normalize!, (value) {
    return _then(_self.copyWith(normalize: value));
  });
}/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleBoardCopyWith<$Res> get board {
  
  return $PuzzleBoardCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleLexiconCopyWith<$Res> get lexicon {
  
  return $PuzzleLexiconCopyWith<$Res>(_self.lexicon, (value) {
    return _then(_self.copyWith(lexicon: value));
  });
}/// Create a copy of PuzzleContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PuzzleSolutionCopyWith<$Res> get solution {
  
  return $PuzzleSolutionCopyWith<$Res>(_self.solution, (value) {
    return _then(_self.copyWith(solution: value));
  });
}
}


/// @nodoc
mixin _$NormalizeConfig {

 bool get upper; bool get stripAccents; bool get stripNonLetters; Map<String, String>? get customMap;
/// Create a copy of NormalizeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NormalizeConfigCopyWith<NormalizeConfig> get copyWith => _$NormalizeConfigCopyWithImpl<NormalizeConfig>(this as NormalizeConfig, _$identity);

  /// Serializes this NormalizeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NormalizeConfig&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.stripAccents, stripAccents) || other.stripAccents == stripAccents)&&(identical(other.stripNonLetters, stripNonLetters) || other.stripNonLetters == stripNonLetters)&&const DeepCollectionEquality().equals(other.customMap, customMap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upper,stripAccents,stripNonLetters,const DeepCollectionEquality().hash(customMap));

@override
String toString() {
  return 'NormalizeConfig(upper: $upper, stripAccents: $stripAccents, stripNonLetters: $stripNonLetters, customMap: $customMap)';
}


}

/// @nodoc
abstract mixin class $NormalizeConfigCopyWith<$Res>  {
  factory $NormalizeConfigCopyWith(NormalizeConfig value, $Res Function(NormalizeConfig) _then) = _$NormalizeConfigCopyWithImpl;
@useResult
$Res call({
 bool upper, bool stripAccents, bool stripNonLetters, Map<String, String>? customMap
});




}
/// @nodoc
class _$NormalizeConfigCopyWithImpl<$Res>
    implements $NormalizeConfigCopyWith<$Res> {
  _$NormalizeConfigCopyWithImpl(this._self, this._then);

  final NormalizeConfig _self;
  final $Res Function(NormalizeConfig) _then;

/// Create a copy of NormalizeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upper = null,Object? stripAccents = null,Object? stripNonLetters = null,Object? customMap = freezed,}) {
  return _then(_self.copyWith(
upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as bool,stripAccents: null == stripAccents ? _self.stripAccents : stripAccents // ignore: cast_nullable_to_non_nullable
as bool,stripNonLetters: null == stripNonLetters ? _self.stripNonLetters : stripNonLetters // ignore: cast_nullable_to_non_nullable
as bool,customMap: freezed == customMap ? _self.customMap : customMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NormalizeConfig].
extension NormalizeConfigPatterns on NormalizeConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NormalizeConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NormalizeConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NormalizeConfig value)  $default,){
final _that = this;
switch (_that) {
case _NormalizeConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NormalizeConfig value)?  $default,){
final _that = this;
switch (_that) {
case _NormalizeConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool upper,  bool stripAccents,  bool stripNonLetters,  Map<String, String>? customMap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NormalizeConfig() when $default != null:
return $default(_that.upper,_that.stripAccents,_that.stripNonLetters,_that.customMap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool upper,  bool stripAccents,  bool stripNonLetters,  Map<String, String>? customMap)  $default,) {final _that = this;
switch (_that) {
case _NormalizeConfig():
return $default(_that.upper,_that.stripAccents,_that.stripNonLetters,_that.customMap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool upper,  bool stripAccents,  bool stripNonLetters,  Map<String, String>? customMap)?  $default,) {final _that = this;
switch (_that) {
case _NormalizeConfig() when $default != null:
return $default(_that.upper,_that.stripAccents,_that.stripNonLetters,_that.customMap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NormalizeConfig implements NormalizeConfig {
  const _NormalizeConfig({this.upper = true, this.stripAccents = true, this.stripNonLetters = true, final  Map<String, String>? customMap}): _customMap = customMap;
  factory _NormalizeConfig.fromJson(Map<String, dynamic> json) => _$NormalizeConfigFromJson(json);

@override@JsonKey() final  bool upper;
@override@JsonKey() final  bool stripAccents;
@override@JsonKey() final  bool stripNonLetters;
 final  Map<String, String>? _customMap;
@override Map<String, String>? get customMap {
  final value = _customMap;
  if (value == null) return null;
  if (_customMap is EqualUnmodifiableMapView) return _customMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NormalizeConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NormalizeConfigCopyWith<_NormalizeConfig> get copyWith => __$NormalizeConfigCopyWithImpl<_NormalizeConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NormalizeConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NormalizeConfig&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.stripAccents, stripAccents) || other.stripAccents == stripAccents)&&(identical(other.stripNonLetters, stripNonLetters) || other.stripNonLetters == stripNonLetters)&&const DeepCollectionEquality().equals(other._customMap, _customMap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upper,stripAccents,stripNonLetters,const DeepCollectionEquality().hash(_customMap));

@override
String toString() {
  return 'NormalizeConfig(upper: $upper, stripAccents: $stripAccents, stripNonLetters: $stripNonLetters, customMap: $customMap)';
}


}

/// @nodoc
abstract mixin class _$NormalizeConfigCopyWith<$Res> implements $NormalizeConfigCopyWith<$Res> {
  factory _$NormalizeConfigCopyWith(_NormalizeConfig value, $Res Function(_NormalizeConfig) _then) = __$NormalizeConfigCopyWithImpl;
@override @useResult
$Res call({
 bool upper, bool stripAccents, bool stripNonLetters, Map<String, String>? customMap
});




}
/// @nodoc
class __$NormalizeConfigCopyWithImpl<$Res>
    implements _$NormalizeConfigCopyWith<$Res> {
  __$NormalizeConfigCopyWithImpl(this._self, this._then);

  final _NormalizeConfig _self;
  final $Res Function(_NormalizeConfig) _then;

/// Create a copy of NormalizeConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upper = null,Object? stripAccents = null,Object? stripNonLetters = null,Object? customMap = freezed,}) {
  return _then(_NormalizeConfig(
upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as bool,stripAccents: null == stripAccents ? _self.stripAccents : stripAccents // ignore: cast_nullable_to_non_nullable
as bool,stripNonLetters: null == stripNonLetters ? _self.stripNonLetters : stripNonLetters // ignore: cast_nullable_to_non_nullable
as bool,customMap: freezed == customMap ? _self._customMap : customMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}


/// @nodoc
mixin _$PuzzleBoard {

 int get rows; int get cols; String get alphabet; BoardSource get source;
/// Create a copy of PuzzleBoard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleBoardCopyWith<PuzzleBoard> get copyWith => _$PuzzleBoardCopyWithImpl<PuzzleBoard>(this as PuzzleBoard, _$identity);

  /// Serializes this PuzzleBoard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleBoard&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.alphabet, alphabet) || other.alphabet == alphabet)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rows,cols,alphabet,source);

@override
String toString() {
  return 'PuzzleBoard(rows: $rows, cols: $cols, alphabet: $alphabet, source: $source)';
}


}

/// @nodoc
abstract mixin class $PuzzleBoardCopyWith<$Res>  {
  factory $PuzzleBoardCopyWith(PuzzleBoard value, $Res Function(PuzzleBoard) _then) = _$PuzzleBoardCopyWithImpl;
@useResult
$Res call({
 int rows, int cols, String alphabet, BoardSource source
});


$BoardSourceCopyWith<$Res> get source;

}
/// @nodoc
class _$PuzzleBoardCopyWithImpl<$Res>
    implements $PuzzleBoardCopyWith<$Res> {
  _$PuzzleBoardCopyWithImpl(this._self, this._then);

  final PuzzleBoard _self;
  final $Res Function(PuzzleBoard) _then;

/// Create a copy of PuzzleBoard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rows = null,Object? cols = null,Object? alphabet = null,Object? source = null,}) {
  return _then(_self.copyWith(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,alphabet: null == alphabet ? _self.alphabet : alphabet // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as BoardSource,
  ));
}
/// Create a copy of PuzzleBoard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardSourceCopyWith<$Res> get source {
  
  return $BoardSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [PuzzleBoard].
extension PuzzleBoardPatterns on PuzzleBoard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleBoard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleBoard() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleBoard value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleBoard():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleBoard value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleBoard() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rows,  int cols,  String alphabet,  BoardSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleBoard() when $default != null:
return $default(_that.rows,_that.cols,_that.alphabet,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rows,  int cols,  String alphabet,  BoardSource source)  $default,) {final _that = this;
switch (_that) {
case _PuzzleBoard():
return $default(_that.rows,_that.cols,_that.alphabet,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rows,  int cols,  String alphabet,  BoardSource source)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleBoard() when $default != null:
return $default(_that.rows,_that.cols,_that.alphabet,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PuzzleBoard implements PuzzleBoard {
  const _PuzzleBoard({required this.rows, required this.cols, required this.alphabet, required this.source});
  factory _PuzzleBoard.fromJson(Map<String, dynamic> json) => _$PuzzleBoardFromJson(json);

@override final  int rows;
@override final  int cols;
@override final  String alphabet;
@override final  BoardSource source;

/// Create a copy of PuzzleBoard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleBoardCopyWith<_PuzzleBoard> get copyWith => __$PuzzleBoardCopyWithImpl<_PuzzleBoard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PuzzleBoardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleBoard&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.alphabet, alphabet) || other.alphabet == alphabet)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rows,cols,alphabet,source);

@override
String toString() {
  return 'PuzzleBoard(rows: $rows, cols: $cols, alphabet: $alphabet, source: $source)';
}


}

/// @nodoc
abstract mixin class _$PuzzleBoardCopyWith<$Res> implements $PuzzleBoardCopyWith<$Res> {
  factory _$PuzzleBoardCopyWith(_PuzzleBoard value, $Res Function(_PuzzleBoard) _then) = __$PuzzleBoardCopyWithImpl;
@override @useResult
$Res call({
 int rows, int cols, String alphabet, BoardSource source
});


@override $BoardSourceCopyWith<$Res> get source;

}
/// @nodoc
class __$PuzzleBoardCopyWithImpl<$Res>
    implements _$PuzzleBoardCopyWith<$Res> {
  __$PuzzleBoardCopyWithImpl(this._self, this._then);

  final _PuzzleBoard _self;
  final $Res Function(_PuzzleBoard) _then;

/// Create a copy of PuzzleBoard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rows = null,Object? cols = null,Object? alphabet = null,Object? source = null,}) {
  return _then(_PuzzleBoard(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,alphabet: null == alphabet ? _self.alphabet : alphabet // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as BoardSource,
  ));
}

/// Create a copy of PuzzleBoard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardSourceCopyWith<$Res> get source {
  
  return $BoardSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

BoardSource _$BoardSourceFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'static':
          return BoardSourceStaticGrid.fromJson(
            json
          );
                case 'generated':
          return BoardSourceGenerated.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'BoardSource',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$BoardSource {



  /// Serializes this BoardSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardSource);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardSource()';
}


}

/// @nodoc
class $BoardSourceCopyWith<$Res>  {
$BoardSourceCopyWith(BoardSource _, $Res Function(BoardSource) __);
}


/// Adds pattern-matching-related methods to [BoardSource].
extension BoardSourcePatterns on BoardSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardSourceStaticGrid value)?  staticGrid,TResult Function( BoardSourceGenerated value)?  generated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardSourceStaticGrid() when staticGrid != null:
return staticGrid(_that);case BoardSourceGenerated() when generated != null:
return generated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardSourceStaticGrid value)  staticGrid,required TResult Function( BoardSourceGenerated value)  generated,}){
final _that = this;
switch (_that) {
case BoardSourceStaticGrid():
return staticGrid(_that);case BoardSourceGenerated():
return generated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardSourceStaticGrid value)?  staticGrid,TResult? Function( BoardSourceGenerated value)?  generated,}){
final _that = this;
switch (_that) {
case BoardSourceStaticGrid() when staticGrid != null:
return staticGrid(_that);case BoardSourceGenerated() when generated != null:
return generated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<String> grid)?  staticGrid,TResult Function( BoardGenerator generator)?  generated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BoardSourceStaticGrid() when staticGrid != null:
return staticGrid(_that.grid);case BoardSourceGenerated() when generated != null:
return generated(_that.generator);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<String> grid)  staticGrid,required TResult Function( BoardGenerator generator)  generated,}) {final _that = this;
switch (_that) {
case BoardSourceStaticGrid():
return staticGrid(_that.grid);case BoardSourceGenerated():
return generated(_that.generator);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<String> grid)?  staticGrid,TResult? Function( BoardGenerator generator)?  generated,}) {final _that = this;
switch (_that) {
case BoardSourceStaticGrid() when staticGrid != null:
return staticGrid(_that.grid);case BoardSourceGenerated() when generated != null:
return generated(_that.generator);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class BoardSourceStaticGrid implements BoardSource {
  const BoardSourceStaticGrid({required final  List<String> grid, final  String? $type}): _grid = grid,$type = $type ?? 'static';
  factory BoardSourceStaticGrid.fromJson(Map<String, dynamic> json) => _$BoardSourceStaticGridFromJson(json);

 final  List<String> _grid;
 List<String> get grid {
  if (_grid is EqualUnmodifiableListView) return _grid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grid);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of BoardSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardSourceStaticGridCopyWith<BoardSourceStaticGrid> get copyWith => _$BoardSourceStaticGridCopyWithImpl<BoardSourceStaticGrid>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardSourceStaticGridToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardSourceStaticGrid&&const DeepCollectionEquality().equals(other._grid, _grid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_grid));

@override
String toString() {
  return 'BoardSource.staticGrid(grid: $grid)';
}


}

/// @nodoc
abstract mixin class $BoardSourceStaticGridCopyWith<$Res> implements $BoardSourceCopyWith<$Res> {
  factory $BoardSourceStaticGridCopyWith(BoardSourceStaticGrid value, $Res Function(BoardSourceStaticGrid) _then) = _$BoardSourceStaticGridCopyWithImpl;
@useResult
$Res call({
 List<String> grid
});




}
/// @nodoc
class _$BoardSourceStaticGridCopyWithImpl<$Res>
    implements $BoardSourceStaticGridCopyWith<$Res> {
  _$BoardSourceStaticGridCopyWithImpl(this._self, this._then);

  final BoardSourceStaticGrid _self;
  final $Res Function(BoardSourceStaticGrid) _then;

/// Create a copy of BoardSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? grid = null,}) {
  return _then(BoardSourceStaticGrid(
grid: null == grid ? _self._grid : grid // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BoardSourceGenerated implements BoardSource {
  const BoardSourceGenerated({required this.generator, final  String? $type}): $type = $type ?? 'generated';
  factory BoardSourceGenerated.fromJson(Map<String, dynamic> json) => _$BoardSourceGeneratedFromJson(json);

 final  BoardGenerator generator;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of BoardSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardSourceGeneratedCopyWith<BoardSourceGenerated> get copyWith => _$BoardSourceGeneratedCopyWithImpl<BoardSourceGenerated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardSourceGeneratedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardSourceGenerated&&(identical(other.generator, generator) || other.generator == generator));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generator);

@override
String toString() {
  return 'BoardSource.generated(generator: $generator)';
}


}

/// @nodoc
abstract mixin class $BoardSourceGeneratedCopyWith<$Res> implements $BoardSourceCopyWith<$Res> {
  factory $BoardSourceGeneratedCopyWith(BoardSourceGenerated value, $Res Function(BoardSourceGenerated) _then) = _$BoardSourceGeneratedCopyWithImpl;
@useResult
$Res call({
 BoardGenerator generator
});


$BoardGeneratorCopyWith<$Res> get generator;

}
/// @nodoc
class _$BoardSourceGeneratedCopyWithImpl<$Res>
    implements $BoardSourceGeneratedCopyWith<$Res> {
  _$BoardSourceGeneratedCopyWithImpl(this._self, this._then);

  final BoardSourceGenerated _self;
  final $Res Function(BoardSourceGenerated) _then;

/// Create a copy of BoardSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? generator = null,}) {
  return _then(BoardSourceGenerated(
generator: null == generator ? _self.generator : generator // ignore: cast_nullable_to_non_nullable
as BoardGenerator,
  ));
}

/// Create a copy of BoardSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardGeneratorCopyWith<$Res> get generator {
  
  return $BoardGeneratorCopyWith<$Res>(_self.generator, (value) {
    return _then(_self.copyWith(generator: value));
  });
}
}


/// @nodoc
mixin _$BoardGenerator {

 String get algo; String? get seed; int get maxAttempts; bool get allowOverlaps; bool get preferOverlaps; FillStrategy get fillStrategy;
/// Create a copy of BoardGenerator
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardGeneratorCopyWith<BoardGenerator> get copyWith => _$BoardGeneratorCopyWithImpl<BoardGenerator>(this as BoardGenerator, _$identity);

  /// Serializes this BoardGenerator to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardGenerator&&(identical(other.algo, algo) || other.algo == algo)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.allowOverlaps, allowOverlaps) || other.allowOverlaps == allowOverlaps)&&(identical(other.preferOverlaps, preferOverlaps) || other.preferOverlaps == preferOverlaps)&&(identical(other.fillStrategy, fillStrategy) || other.fillStrategy == fillStrategy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algo,seed,maxAttempts,allowOverlaps,preferOverlaps,fillStrategy);

@override
String toString() {
  return 'BoardGenerator(algo: $algo, seed: $seed, maxAttempts: $maxAttempts, allowOverlaps: $allowOverlaps, preferOverlaps: $preferOverlaps, fillStrategy: $fillStrategy)';
}


}

/// @nodoc
abstract mixin class $BoardGeneratorCopyWith<$Res>  {
  factory $BoardGeneratorCopyWith(BoardGenerator value, $Res Function(BoardGenerator) _then) = _$BoardGeneratorCopyWithImpl;
@useResult
$Res call({
 String algo, String? seed, int maxAttempts, bool allowOverlaps, bool preferOverlaps, FillStrategy fillStrategy
});




}
/// @nodoc
class _$BoardGeneratorCopyWithImpl<$Res>
    implements $BoardGeneratorCopyWith<$Res> {
  _$BoardGeneratorCopyWithImpl(this._self, this._then);

  final BoardGenerator _self;
  final $Res Function(BoardGenerator) _then;

/// Create a copy of BoardGenerator
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? algo = null,Object? seed = freezed,Object? maxAttempts = null,Object? allowOverlaps = null,Object? preferOverlaps = null,Object? fillStrategy = null,}) {
  return _then(_self.copyWith(
algo: null == algo ? _self.algo : algo // ignore: cast_nullable_to_non_nullable
as String,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as String?,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,allowOverlaps: null == allowOverlaps ? _self.allowOverlaps : allowOverlaps // ignore: cast_nullable_to_non_nullable
as bool,preferOverlaps: null == preferOverlaps ? _self.preferOverlaps : preferOverlaps // ignore: cast_nullable_to_non_nullable
as bool,fillStrategy: null == fillStrategy ? _self.fillStrategy : fillStrategy // ignore: cast_nullable_to_non_nullable
as FillStrategy,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardGenerator].
extension BoardGeneratorPatterns on BoardGenerator {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardGenerator value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardGenerator() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardGenerator value)  $default,){
final _that = this;
switch (_that) {
case _BoardGenerator():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardGenerator value)?  $default,){
final _that = this;
switch (_that) {
case _BoardGenerator() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String algo,  String? seed,  int maxAttempts,  bool allowOverlaps,  bool preferOverlaps,  FillStrategy fillStrategy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardGenerator() when $default != null:
return $default(_that.algo,_that.seed,_that.maxAttempts,_that.allowOverlaps,_that.preferOverlaps,_that.fillStrategy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String algo,  String? seed,  int maxAttempts,  bool allowOverlaps,  bool preferOverlaps,  FillStrategy fillStrategy)  $default,) {final _that = this;
switch (_that) {
case _BoardGenerator():
return $default(_that.algo,_that.seed,_that.maxAttempts,_that.allowOverlaps,_that.preferOverlaps,_that.fillStrategy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String algo,  String? seed,  int maxAttempts,  bool allowOverlaps,  bool preferOverlaps,  FillStrategy fillStrategy)?  $default,) {final _that = this;
switch (_that) {
case _BoardGenerator() when $default != null:
return $default(_that.algo,_that.seed,_that.maxAttempts,_that.allowOverlaps,_that.preferOverlaps,_that.fillStrategy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardGenerator implements BoardGenerator {
  const _BoardGenerator({required this.algo, this.seed, this.maxAttempts = 300, this.allowOverlaps = true, this.preferOverlaps = true, this.fillStrategy = FillStrategy.random});
  factory _BoardGenerator.fromJson(Map<String, dynamic> json) => _$BoardGeneratorFromJson(json);

@override final  String algo;
@override final  String? seed;
@override@JsonKey() final  int maxAttempts;
@override@JsonKey() final  bool allowOverlaps;
@override@JsonKey() final  bool preferOverlaps;
@override@JsonKey() final  FillStrategy fillStrategy;

/// Create a copy of BoardGenerator
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardGeneratorCopyWith<_BoardGenerator> get copyWith => __$BoardGeneratorCopyWithImpl<_BoardGenerator>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardGeneratorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardGenerator&&(identical(other.algo, algo) || other.algo == algo)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.allowOverlaps, allowOverlaps) || other.allowOverlaps == allowOverlaps)&&(identical(other.preferOverlaps, preferOverlaps) || other.preferOverlaps == preferOverlaps)&&(identical(other.fillStrategy, fillStrategy) || other.fillStrategy == fillStrategy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algo,seed,maxAttempts,allowOverlaps,preferOverlaps,fillStrategy);

@override
String toString() {
  return 'BoardGenerator(algo: $algo, seed: $seed, maxAttempts: $maxAttempts, allowOverlaps: $allowOverlaps, preferOverlaps: $preferOverlaps, fillStrategy: $fillStrategy)';
}


}

/// @nodoc
abstract mixin class _$BoardGeneratorCopyWith<$Res> implements $BoardGeneratorCopyWith<$Res> {
  factory _$BoardGeneratorCopyWith(_BoardGenerator value, $Res Function(_BoardGenerator) _then) = __$BoardGeneratorCopyWithImpl;
@override @useResult
$Res call({
 String algo, String? seed, int maxAttempts, bool allowOverlaps, bool preferOverlaps, FillStrategy fillStrategy
});




}
/// @nodoc
class __$BoardGeneratorCopyWithImpl<$Res>
    implements _$BoardGeneratorCopyWith<$Res> {
  __$BoardGeneratorCopyWithImpl(this._self, this._then);

  final _BoardGenerator _self;
  final $Res Function(_BoardGenerator) _then;

/// Create a copy of BoardGenerator
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? algo = null,Object? seed = freezed,Object? maxAttempts = null,Object? allowOverlaps = null,Object? preferOverlaps = null,Object? fillStrategy = null,}) {
  return _then(_BoardGenerator(
algo: null == algo ? _self.algo : algo // ignore: cast_nullable_to_non_nullable
as String,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as String?,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,allowOverlaps: null == allowOverlaps ? _self.allowOverlaps : allowOverlaps // ignore: cast_nullable_to_non_nullable
as bool,preferOverlaps: null == preferOverlaps ? _self.preferOverlaps : preferOverlaps // ignore: cast_nullable_to_non_nullable
as bool,fillStrategy: null == fillStrategy ? _self.fillStrategy : fillStrategy // ignore: cast_nullable_to_non_nullable
as FillStrategy,
  ));
}


}


/// @nodoc
mixin _$PuzzleLexicon {

 List<LexiconWord> get words; List<LexiconGroup>? get groups;
/// Create a copy of PuzzleLexicon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleLexiconCopyWith<PuzzleLexicon> get copyWith => _$PuzzleLexiconCopyWithImpl<PuzzleLexicon>(this as PuzzleLexicon, _$identity);

  /// Serializes this PuzzleLexicon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleLexicon&&const DeepCollectionEquality().equals(other.words, words)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(words),const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'PuzzleLexicon(words: $words, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $PuzzleLexiconCopyWith<$Res>  {
  factory $PuzzleLexiconCopyWith(PuzzleLexicon value, $Res Function(PuzzleLexicon) _then) = _$PuzzleLexiconCopyWithImpl;
@useResult
$Res call({
 List<LexiconWord> words, List<LexiconGroup>? groups
});




}
/// @nodoc
class _$PuzzleLexiconCopyWithImpl<$Res>
    implements $PuzzleLexiconCopyWith<$Res> {
  _$PuzzleLexiconCopyWithImpl(this._self, this._then);

  final PuzzleLexicon _self;
  final $Res Function(PuzzleLexicon) _then;

/// Create a copy of PuzzleLexicon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? words = null,Object? groups = freezed,}) {
  return _then(_self.copyWith(
words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<LexiconWord>,groups: freezed == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<LexiconGroup>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PuzzleLexicon].
extension PuzzleLexiconPatterns on PuzzleLexicon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleLexicon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleLexicon() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleLexicon value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleLexicon():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleLexicon value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleLexicon() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LexiconWord> words,  List<LexiconGroup>? groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleLexicon() when $default != null:
return $default(_that.words,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LexiconWord> words,  List<LexiconGroup>? groups)  $default,) {final _that = this;
switch (_that) {
case _PuzzleLexicon():
return $default(_that.words,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LexiconWord> words,  List<LexiconGroup>? groups)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleLexicon() when $default != null:
return $default(_that.words,_that.groups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PuzzleLexicon implements PuzzleLexicon {
  const _PuzzleLexicon({required final  List<LexiconWord> words, final  List<LexiconGroup>? groups}): _words = words,_groups = groups;
  factory _PuzzleLexicon.fromJson(Map<String, dynamic> json) => _$PuzzleLexiconFromJson(json);

 final  List<LexiconWord> _words;
@override List<LexiconWord> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

 final  List<LexiconGroup>? _groups;
@override List<LexiconGroup>? get groups {
  final value = _groups;
  if (value == null) return null;
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PuzzleLexicon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleLexiconCopyWith<_PuzzleLexicon> get copyWith => __$PuzzleLexiconCopyWithImpl<_PuzzleLexicon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PuzzleLexiconToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleLexicon&&const DeepCollectionEquality().equals(other._words, _words)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_words),const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'PuzzleLexicon(words: $words, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$PuzzleLexiconCopyWith<$Res> implements $PuzzleLexiconCopyWith<$Res> {
  factory _$PuzzleLexiconCopyWith(_PuzzleLexicon value, $Res Function(_PuzzleLexicon) _then) = __$PuzzleLexiconCopyWithImpl;
@override @useResult
$Res call({
 List<LexiconWord> words, List<LexiconGroup>? groups
});




}
/// @nodoc
class __$PuzzleLexiconCopyWithImpl<$Res>
    implements _$PuzzleLexiconCopyWith<$Res> {
  __$PuzzleLexiconCopyWithImpl(this._self, this._then);

  final _PuzzleLexicon _self;
  final $Res Function(_PuzzleLexicon) _then;

/// Create a copy of PuzzleLexicon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? words = null,Object? groups = freezed,}) {
  return _then(_PuzzleLexicon(
words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<LexiconWord>,groups: freezed == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<LexiconGroup>?,
  ));
}


}


/// @nodoc
mixin _$LexiconWord {

 String get id; String get text; String? get display; String? get speech; List<String>? get tags; double get weight; int? get difficulty;
/// Create a copy of LexiconWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LexiconWordCopyWith<LexiconWord> get copyWith => _$LexiconWordCopyWithImpl<LexiconWord>(this as LexiconWord, _$identity);

  /// Serializes this LexiconWord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LexiconWord&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.display, display) || other.display == display)&&(identical(other.speech, speech) || other.speech == speech)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,display,speech,const DeepCollectionEquality().hash(tags),weight,difficulty);

@override
String toString() {
  return 'LexiconWord(id: $id, text: $text, display: $display, speech: $speech, tags: $tags, weight: $weight, difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class $LexiconWordCopyWith<$Res>  {
  factory $LexiconWordCopyWith(LexiconWord value, $Res Function(LexiconWord) _then) = _$LexiconWordCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? display, String? speech, List<String>? tags, double weight, int? difficulty
});




}
/// @nodoc
class _$LexiconWordCopyWithImpl<$Res>
    implements $LexiconWordCopyWith<$Res> {
  _$LexiconWordCopyWithImpl(this._self, this._then);

  final LexiconWord _self;
  final $Res Function(LexiconWord) _then;

/// Create a copy of LexiconWord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? display = freezed,Object? speech = freezed,Object? tags = freezed,Object? weight = null,Object? difficulty = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,display: freezed == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String?,speech: freezed == speech ? _self.speech : speech // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LexiconWord].
extension LexiconWordPatterns on LexiconWord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LexiconWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LexiconWord() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LexiconWord value)  $default,){
final _that = this;
switch (_that) {
case _LexiconWord():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LexiconWord value)?  $default,){
final _that = this;
switch (_that) {
case _LexiconWord() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String? display,  String? speech,  List<String>? tags,  double weight,  int? difficulty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LexiconWord() when $default != null:
return $default(_that.id,_that.text,_that.display,_that.speech,_that.tags,_that.weight,_that.difficulty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String? display,  String? speech,  List<String>? tags,  double weight,  int? difficulty)  $default,) {final _that = this;
switch (_that) {
case _LexiconWord():
return $default(_that.id,_that.text,_that.display,_that.speech,_that.tags,_that.weight,_that.difficulty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String? display,  String? speech,  List<String>? tags,  double weight,  int? difficulty)?  $default,) {final _that = this;
switch (_that) {
case _LexiconWord() when $default != null:
return $default(_that.id,_that.text,_that.display,_that.speech,_that.tags,_that.weight,_that.difficulty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LexiconWord implements LexiconWord {
  const _LexiconWord({required this.id, required this.text, this.display, this.speech, final  List<String>? tags, this.weight = 1.0, this.difficulty}): _tags = tags;
  factory _LexiconWord.fromJson(Map<String, dynamic> json) => _$LexiconWordFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? display;
@override final  String? speech;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  double weight;
@override final  int? difficulty;

/// Create a copy of LexiconWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LexiconWordCopyWith<_LexiconWord> get copyWith => __$LexiconWordCopyWithImpl<_LexiconWord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LexiconWordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LexiconWord&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.display, display) || other.display == display)&&(identical(other.speech, speech) || other.speech == speech)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,display,speech,const DeepCollectionEquality().hash(_tags),weight,difficulty);

@override
String toString() {
  return 'LexiconWord(id: $id, text: $text, display: $display, speech: $speech, tags: $tags, weight: $weight, difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class _$LexiconWordCopyWith<$Res> implements $LexiconWordCopyWith<$Res> {
  factory _$LexiconWordCopyWith(_LexiconWord value, $Res Function(_LexiconWord) _then) = __$LexiconWordCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? display, String? speech, List<String>? tags, double weight, int? difficulty
});




}
/// @nodoc
class __$LexiconWordCopyWithImpl<$Res>
    implements _$LexiconWordCopyWith<$Res> {
  __$LexiconWordCopyWithImpl(this._self, this._then);

  final _LexiconWord _self;
  final $Res Function(_LexiconWord) _then;

/// Create a copy of LexiconWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? display = freezed,Object? speech = freezed,Object? tags = freezed,Object? weight = null,Object? difficulty = freezed,}) {
  return _then(_LexiconWord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,display: freezed == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String?,speech: freezed == speech ? _self.speech : speech // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$LexiconGroup {

 String get id;@I18nTextConverter() I18nText? get label; List<String> get wordIds;
/// Create a copy of LexiconGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LexiconGroupCopyWith<LexiconGroup> get copyWith => _$LexiconGroupCopyWithImpl<LexiconGroup>(this as LexiconGroup, _$identity);

  /// Serializes this LexiconGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LexiconGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.wordIds, wordIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(wordIds));

@override
String toString() {
  return 'LexiconGroup(id: $id, label: $label, wordIds: $wordIds)';
}


}

/// @nodoc
abstract mixin class $LexiconGroupCopyWith<$Res>  {
  factory $LexiconGroupCopyWith(LexiconGroup value, $Res Function(LexiconGroup) _then) = _$LexiconGroupCopyWithImpl;
@useResult
$Res call({
 String id,@I18nTextConverter() I18nText? label, List<String> wordIds
});


$I18nTextCopyWith<$Res>? get label;

}
/// @nodoc
class _$LexiconGroupCopyWithImpl<$Res>
    implements $LexiconGroupCopyWith<$Res> {
  _$LexiconGroupCopyWithImpl(this._self, this._then);

  final LexiconGroup _self;
  final $Res Function(LexiconGroup) _then;

/// Create a copy of LexiconGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = freezed,Object? wordIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as I18nText?,wordIds: null == wordIds ? _self.wordIds : wordIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of LexiconGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$I18nTextCopyWith<$Res>? get label {
    if (_self.label == null) {
    return null;
  }

  return $I18nTextCopyWith<$Res>(_self.label!, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}


/// Adds pattern-matching-related methods to [LexiconGroup].
extension LexiconGroupPatterns on LexiconGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LexiconGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LexiconGroup() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LexiconGroup value)  $default,){
final _that = this;
switch (_that) {
case _LexiconGroup():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LexiconGroup value)?  $default,){
final _that = this;
switch (_that) {
case _LexiconGroup() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @I18nTextConverter()  I18nText? label,  List<String> wordIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LexiconGroup() when $default != null:
return $default(_that.id,_that.label,_that.wordIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @I18nTextConverter()  I18nText? label,  List<String> wordIds)  $default,) {final _that = this;
switch (_that) {
case _LexiconGroup():
return $default(_that.id,_that.label,_that.wordIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @I18nTextConverter()  I18nText? label,  List<String> wordIds)?  $default,) {final _that = this;
switch (_that) {
case _LexiconGroup() when $default != null:
return $default(_that.id,_that.label,_that.wordIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LexiconGroup implements LexiconGroup {
  const _LexiconGroup({required this.id, @I18nTextConverter() this.label, required final  List<String> wordIds}): _wordIds = wordIds;
  factory _LexiconGroup.fromJson(Map<String, dynamic> json) => _$LexiconGroupFromJson(json);

@override final  String id;
@override@I18nTextConverter() final  I18nText? label;
 final  List<String> _wordIds;
@override List<String> get wordIds {
  if (_wordIds is EqualUnmodifiableListView) return _wordIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wordIds);
}


/// Create a copy of LexiconGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LexiconGroupCopyWith<_LexiconGroup> get copyWith => __$LexiconGroupCopyWithImpl<_LexiconGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LexiconGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LexiconGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._wordIds, _wordIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(_wordIds));

@override
String toString() {
  return 'LexiconGroup(id: $id, label: $label, wordIds: $wordIds)';
}


}

/// @nodoc
abstract mixin class _$LexiconGroupCopyWith<$Res> implements $LexiconGroupCopyWith<$Res> {
  factory _$LexiconGroupCopyWith(_LexiconGroup value, $Res Function(_LexiconGroup) _then) = __$LexiconGroupCopyWithImpl;
@override @useResult
$Res call({
 String id,@I18nTextConverter() I18nText? label, List<String> wordIds
});


@override $I18nTextCopyWith<$Res>? get label;

}
/// @nodoc
class __$LexiconGroupCopyWithImpl<$Res>
    implements _$LexiconGroupCopyWith<$Res> {
  __$LexiconGroupCopyWithImpl(this._self, this._then);

  final _LexiconGroup _self;
  final $Res Function(_LexiconGroup) _then;

/// Create a copy of LexiconGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = freezed,Object? wordIds = null,}) {
  return _then(_LexiconGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as I18nText?,wordIds: null == wordIds ? _self._wordIds : wordIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of LexiconGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$I18nTextCopyWith<$Res>? get label {
    if (_self.label == null) {
    return null;
  }

  return $I18nTextCopyWith<$Res>(_self.label!, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}

PuzzleSolution _$PuzzleSolutionFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'placements':
          return PuzzleSolutionPlacements.fromJson(
            json
          );
                case 'auto_from_grid':
          return PuzzleSolutionAutoFromGrid.fromJson(
            json
          );
                case 'none':
          return PuzzleSolutionNone.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'PuzzleSolution',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$PuzzleSolution {



  /// Serializes this PuzzleSolution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleSolution);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PuzzleSolution()';
}


}

/// @nodoc
class $PuzzleSolutionCopyWith<$Res>  {
$PuzzleSolutionCopyWith(PuzzleSolution _, $Res Function(PuzzleSolution) __);
}


/// Adds pattern-matching-related methods to [PuzzleSolution].
extension PuzzleSolutionPatterns on PuzzleSolution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PuzzleSolutionPlacements value)?  placements,TResult Function( PuzzleSolutionAutoFromGrid value)?  autoFromGrid,TResult Function( PuzzleSolutionNone value)?  none,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PuzzleSolutionPlacements() when placements != null:
return placements(_that);case PuzzleSolutionAutoFromGrid() when autoFromGrid != null:
return autoFromGrid(_that);case PuzzleSolutionNone() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PuzzleSolutionPlacements value)  placements,required TResult Function( PuzzleSolutionAutoFromGrid value)  autoFromGrid,required TResult Function( PuzzleSolutionNone value)  none,}){
final _that = this;
switch (_that) {
case PuzzleSolutionPlacements():
return placements(_that);case PuzzleSolutionAutoFromGrid():
return autoFromGrid(_that);case PuzzleSolutionNone():
return none(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PuzzleSolutionPlacements value)?  placements,TResult? Function( PuzzleSolutionAutoFromGrid value)?  autoFromGrid,TResult? Function( PuzzleSolutionNone value)?  none,}){
final _that = this;
switch (_that) {
case PuzzleSolutionPlacements() when placements != null:
return placements(_that);case PuzzleSolutionAutoFromGrid() when autoFromGrid != null:
return autoFromGrid(_that);case PuzzleSolutionNone() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<WordPlacementV1> placements)?  placements,TResult Function()?  autoFromGrid,TResult Function()?  none,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PuzzleSolutionPlacements() when placements != null:
return placements(_that.placements);case PuzzleSolutionAutoFromGrid() when autoFromGrid != null:
return autoFromGrid();case PuzzleSolutionNone() when none != null:
return none();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<WordPlacementV1> placements)  placements,required TResult Function()  autoFromGrid,required TResult Function()  none,}) {final _that = this;
switch (_that) {
case PuzzleSolutionPlacements():
return placements(_that.placements);case PuzzleSolutionAutoFromGrid():
return autoFromGrid();case PuzzleSolutionNone():
return none();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<WordPlacementV1> placements)?  placements,TResult? Function()?  autoFromGrid,TResult? Function()?  none,}) {final _that = this;
switch (_that) {
case PuzzleSolutionPlacements() when placements != null:
return placements(_that.placements);case PuzzleSolutionAutoFromGrid() when autoFromGrid != null:
return autoFromGrid();case PuzzleSolutionNone() when none != null:
return none();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PuzzleSolutionPlacements implements PuzzleSolution {
  const PuzzleSolutionPlacements({required final  List<WordPlacementV1> placements, final  String? $type}): _placements = placements,$type = $type ?? 'placements';
  factory PuzzleSolutionPlacements.fromJson(Map<String, dynamic> json) => _$PuzzleSolutionPlacementsFromJson(json);

 final  List<WordPlacementV1> _placements;
 List<WordPlacementV1> get placements {
  if (_placements is EqualUnmodifiableListView) return _placements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placements);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PuzzleSolution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleSolutionPlacementsCopyWith<PuzzleSolutionPlacements> get copyWith => _$PuzzleSolutionPlacementsCopyWithImpl<PuzzleSolutionPlacements>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PuzzleSolutionPlacementsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleSolutionPlacements&&const DeepCollectionEquality().equals(other._placements, _placements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_placements));

@override
String toString() {
  return 'PuzzleSolution.placements(placements: $placements)';
}


}

/// @nodoc
abstract mixin class $PuzzleSolutionPlacementsCopyWith<$Res> implements $PuzzleSolutionCopyWith<$Res> {
  factory $PuzzleSolutionPlacementsCopyWith(PuzzleSolutionPlacements value, $Res Function(PuzzleSolutionPlacements) _then) = _$PuzzleSolutionPlacementsCopyWithImpl;
@useResult
$Res call({
 List<WordPlacementV1> placements
});




}
/// @nodoc
class _$PuzzleSolutionPlacementsCopyWithImpl<$Res>
    implements $PuzzleSolutionPlacementsCopyWith<$Res> {
  _$PuzzleSolutionPlacementsCopyWithImpl(this._self, this._then);

  final PuzzleSolutionPlacements _self;
  final $Res Function(PuzzleSolutionPlacements) _then;

/// Create a copy of PuzzleSolution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placements = null,}) {
  return _then(PuzzleSolutionPlacements(
placements: null == placements ? _self._placements : placements // ignore: cast_nullable_to_non_nullable
as List<WordPlacementV1>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PuzzleSolutionAutoFromGrid implements PuzzleSolution {
  const PuzzleSolutionAutoFromGrid({final  String? $type}): $type = $type ?? 'auto_from_grid';
  factory PuzzleSolutionAutoFromGrid.fromJson(Map<String, dynamic> json) => _$PuzzleSolutionAutoFromGridFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$PuzzleSolutionAutoFromGridToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleSolutionAutoFromGrid);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PuzzleSolution.autoFromGrid()';
}


}




/// @nodoc
@JsonSerializable()

class PuzzleSolutionNone implements PuzzleSolution {
  const PuzzleSolutionNone({final  String? $type}): $type = $type ?? 'none';
  factory PuzzleSolutionNone.fromJson(Map<String, dynamic> json) => _$PuzzleSolutionNoneFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$PuzzleSolutionNoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleSolutionNone);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PuzzleSolution.none()';
}


}





/// @nodoc
mixin _$WordPlacementV1 {

 String get wordId; Coord get start; Direction get dir; int? get len;
/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordPlacementV1CopyWith<WordPlacementV1> get copyWith => _$WordPlacementV1CopyWithImpl<WordPlacementV1>(this as WordPlacementV1, _$identity);

  /// Serializes this WordPlacementV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordPlacementV1&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.start, start) || other.start == start)&&(identical(other.dir, dir) || other.dir == dir)&&(identical(other.len, len) || other.len == len));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,start,dir,len);

@override
String toString() {
  return 'WordPlacementV1(wordId: $wordId, start: $start, dir: $dir, len: $len)';
}


}

/// @nodoc
abstract mixin class $WordPlacementV1CopyWith<$Res>  {
  factory $WordPlacementV1CopyWith(WordPlacementV1 value, $Res Function(WordPlacementV1) _then) = _$WordPlacementV1CopyWithImpl;
@useResult
$Res call({
 String wordId, Coord start, Direction dir, int? len
});


$CoordCopyWith<$Res> get start;$DirectionCopyWith<$Res> get dir;

}
/// @nodoc
class _$WordPlacementV1CopyWithImpl<$Res>
    implements $WordPlacementV1CopyWith<$Res> {
  _$WordPlacementV1CopyWithImpl(this._self, this._then);

  final WordPlacementV1 _self;
  final $Res Function(WordPlacementV1) _then;

/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wordId = null,Object? start = null,Object? dir = null,Object? len = freezed,}) {
  return _then(_self.copyWith(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Coord,dir: null == dir ? _self.dir : dir // ignore: cast_nullable_to_non_nullable
as Direction,len: freezed == len ? _self.len : len // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get start {
  
  return $CoordCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DirectionCopyWith<$Res> get dir {
  
  return $DirectionCopyWith<$Res>(_self.dir, (value) {
    return _then(_self.copyWith(dir: value));
  });
}
}


/// Adds pattern-matching-related methods to [WordPlacementV1].
extension WordPlacementV1Patterns on WordPlacementV1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordPlacementV1 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordPlacementV1() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordPlacementV1 value)  $default,){
final _that = this;
switch (_that) {
case _WordPlacementV1():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordPlacementV1 value)?  $default,){
final _that = this;
switch (_that) {
case _WordPlacementV1() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String wordId,  Coord start,  Direction dir,  int? len)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordPlacementV1() when $default != null:
return $default(_that.wordId,_that.start,_that.dir,_that.len);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String wordId,  Coord start,  Direction dir,  int? len)  $default,) {final _that = this;
switch (_that) {
case _WordPlacementV1():
return $default(_that.wordId,_that.start,_that.dir,_that.len);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String wordId,  Coord start,  Direction dir,  int? len)?  $default,) {final _that = this;
switch (_that) {
case _WordPlacementV1() when $default != null:
return $default(_that.wordId,_that.start,_that.dir,_that.len);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordPlacementV1 implements WordPlacementV1 {
  const _WordPlacementV1({required this.wordId, required this.start, required this.dir, this.len});
  factory _WordPlacementV1.fromJson(Map<String, dynamic> json) => _$WordPlacementV1FromJson(json);

@override final  String wordId;
@override final  Coord start;
@override final  Direction dir;
@override final  int? len;

/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordPlacementV1CopyWith<_WordPlacementV1> get copyWith => __$WordPlacementV1CopyWithImpl<_WordPlacementV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordPlacementV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordPlacementV1&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.start, start) || other.start == start)&&(identical(other.dir, dir) || other.dir == dir)&&(identical(other.len, len) || other.len == len));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,start,dir,len);

@override
String toString() {
  return 'WordPlacementV1(wordId: $wordId, start: $start, dir: $dir, len: $len)';
}


}

/// @nodoc
abstract mixin class _$WordPlacementV1CopyWith<$Res> implements $WordPlacementV1CopyWith<$Res> {
  factory _$WordPlacementV1CopyWith(_WordPlacementV1 value, $Res Function(_WordPlacementV1) _then) = __$WordPlacementV1CopyWithImpl;
@override @useResult
$Res call({
 String wordId, Coord start, Direction dir, int? len
});


@override $CoordCopyWith<$Res> get start;@override $DirectionCopyWith<$Res> get dir;

}
/// @nodoc
class __$WordPlacementV1CopyWithImpl<$Res>
    implements _$WordPlacementV1CopyWith<$Res> {
  __$WordPlacementV1CopyWithImpl(this._self, this._then);

  final _WordPlacementV1 _self;
  final $Res Function(_WordPlacementV1) _then;

/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wordId = null,Object? start = null,Object? dir = null,Object? len = freezed,}) {
  return _then(_WordPlacementV1(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Coord,dir: null == dir ? _self.dir : dir // ignore: cast_nullable_to_non_nullable
as Direction,len: freezed == len ? _self.len : len // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get start {
  
  return $CoordCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of WordPlacementV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DirectionCopyWith<$Res> get dir {
  
  return $DirectionCopyWith<$Res>(_self.dir, (value) {
    return _then(_self.copyWith(dir: value));
  });
}
}


/// @nodoc
mixin _$Coord {

 int get r; int get c;
/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordCopyWith<Coord> get copyWith => _$CoordCopyWithImpl<Coord>(this as Coord, _$identity);

  /// Serializes this Coord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coord&&(identical(other.r, r) || other.r == r)&&(identical(other.c, c) || other.c == c));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,r,c);

@override
String toString() {
  return 'Coord(r: $r, c: $c)';
}


}

/// @nodoc
abstract mixin class $CoordCopyWith<$Res>  {
  factory $CoordCopyWith(Coord value, $Res Function(Coord) _then) = _$CoordCopyWithImpl;
@useResult
$Res call({
 int r, int c
});




}
/// @nodoc
class _$CoordCopyWithImpl<$Res>
    implements $CoordCopyWith<$Res> {
  _$CoordCopyWithImpl(this._self, this._then);

  final Coord _self;
  final $Res Function(Coord) _then;

/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? r = null,Object? c = null,}) {
  return _then(_self.copyWith(
r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,c: null == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Coord].
extension CoordPatterns on Coord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coord() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coord value)  $default,){
final _that = this;
switch (_that) {
case _Coord():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coord value)?  $default,){
final _that = this;
switch (_that) {
case _Coord() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int r,  int c)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coord() when $default != null:
return $default(_that.r,_that.c);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int r,  int c)  $default,) {final _that = this;
switch (_that) {
case _Coord():
return $default(_that.r,_that.c);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int r,  int c)?  $default,) {final _that = this;
switch (_that) {
case _Coord() when $default != null:
return $default(_that.r,_that.c);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Coord implements Coord {
  const _Coord({required this.r, required this.c});
  factory _Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

@override final  int r;
@override final  int c;

/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoordCopyWith<_Coord> get copyWith => __$CoordCopyWithImpl<_Coord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coord&&(identical(other.r, r) || other.r == r)&&(identical(other.c, c) || other.c == c));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,r,c);

@override
String toString() {
  return 'Coord(r: $r, c: $c)';
}


}

/// @nodoc
abstract mixin class _$CoordCopyWith<$Res> implements $CoordCopyWith<$Res> {
  factory _$CoordCopyWith(_Coord value, $Res Function(_Coord) _then) = __$CoordCopyWithImpl;
@override @useResult
$Res call({
 int r, int c
});




}
/// @nodoc
class __$CoordCopyWithImpl<$Res>
    implements _$CoordCopyWith<$Res> {
  __$CoordCopyWithImpl(this._self, this._then);

  final _Coord _self;
  final $Res Function(_Coord) _then;

/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? r = null,Object? c = null,}) {
  return _then(_Coord(
r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,c: null == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Direction {

 int get dr; int get dc;
/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectionCopyWith<Direction> get copyWith => _$DirectionCopyWithImpl<Direction>(this as Direction, _$identity);

  /// Serializes this Direction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Direction&&(identical(other.dr, dr) || other.dr == dr)&&(identical(other.dc, dc) || other.dc == dc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dr,dc);

@override
String toString() {
  return 'Direction(dr: $dr, dc: $dc)';
}


}

/// @nodoc
abstract mixin class $DirectionCopyWith<$Res>  {
  factory $DirectionCopyWith(Direction value, $Res Function(Direction) _then) = _$DirectionCopyWithImpl;
@useResult
$Res call({
 int dr, int dc
});




}
/// @nodoc
class _$DirectionCopyWithImpl<$Res>
    implements $DirectionCopyWith<$Res> {
  _$DirectionCopyWithImpl(this._self, this._then);

  final Direction _self;
  final $Res Function(Direction) _then;

/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dr = null,Object? dc = null,}) {
  return _then(_self.copyWith(
dr: null == dr ? _self.dr : dr // ignore: cast_nullable_to_non_nullable
as int,dc: null == dc ? _self.dc : dc // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Direction].
extension DirectionPatterns on Direction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Direction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Direction() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Direction value)  $default,){
final _that = this;
switch (_that) {
case _Direction():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Direction value)?  $default,){
final _that = this;
switch (_that) {
case _Direction() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dr,  int dc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Direction() when $default != null:
return $default(_that.dr,_that.dc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dr,  int dc)  $default,) {final _that = this;
switch (_that) {
case _Direction():
return $default(_that.dr,_that.dc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dr,  int dc)?  $default,) {final _that = this;
switch (_that) {
case _Direction() when $default != null:
return $default(_that.dr,_that.dc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Direction implements Direction {
  const _Direction({required this.dr, required this.dc});
  factory _Direction.fromJson(Map<String, dynamic> json) => _$DirectionFromJson(json);

@override final  int dr;
@override final  int dc;

/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DirectionCopyWith<_Direction> get copyWith => __$DirectionCopyWithImpl<_Direction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DirectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Direction&&(identical(other.dr, dr) || other.dr == dr)&&(identical(other.dc, dc) || other.dc == dc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dr,dc);

@override
String toString() {
  return 'Direction(dr: $dr, dc: $dc)';
}


}

/// @nodoc
abstract mixin class _$DirectionCopyWith<$Res> implements $DirectionCopyWith<$Res> {
  factory _$DirectionCopyWith(_Direction value, $Res Function(_Direction) _then) = __$DirectionCopyWithImpl;
@override @useResult
$Res call({
 int dr, int dc
});




}
/// @nodoc
class __$DirectionCopyWithImpl<$Res>
    implements _$DirectionCopyWith<$Res> {
  __$DirectionCopyWithImpl(this._self, this._then);

  final _Direction _self;
  final $Res Function(_Direction) _then;

/// Create a copy of Direction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dr = null,Object? dc = null,}) {
  return _then(_Direction(
dr: null == dr ? _self.dr : dr // ignore: cast_nullable_to_non_nullable
as int,dc: null == dc ? _self.dc : dc // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PuzzleVariant {

 String get id;@I18nTextConverter() I18nText get title; VariantMode get mode; RulesConfig? get rules; GoalSet? get goals; HintConfig? get hints; ScoringConfig? get scoring; UIConfig? get ui; List<Modifier> get modifiers; JsonMap? get extensions;
/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PuzzleVariantCopyWith<PuzzleVariant> get copyWith => _$PuzzleVariantCopyWithImpl<PuzzleVariant>(this as PuzzleVariant, _$identity);

  /// Serializes this PuzzleVariant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PuzzleVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.hints, hints) || other.hints == hints)&&(identical(other.scoring, scoring) || other.scoring == scoring)&&(identical(other.ui, ui) || other.ui == ui)&&const DeepCollectionEquality().equals(other.modifiers, modifiers)&&const DeepCollectionEquality().equals(other.extensions, extensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,mode,rules,goals,hints,scoring,ui,const DeepCollectionEquality().hash(modifiers),const DeepCollectionEquality().hash(extensions));

@override
String toString() {
  return 'PuzzleVariant(id: $id, title: $title, mode: $mode, rules: $rules, goals: $goals, hints: $hints, scoring: $scoring, ui: $ui, modifiers: $modifiers, extensions: $extensions)';
}


}

/// @nodoc
abstract mixin class $PuzzleVariantCopyWith<$Res>  {
  factory $PuzzleVariantCopyWith(PuzzleVariant value, $Res Function(PuzzleVariant) _then) = _$PuzzleVariantCopyWithImpl;
@useResult
$Res call({
 String id,@I18nTextConverter() I18nText title, VariantMode mode, RulesConfig? rules, GoalSet? goals, HintConfig? hints, ScoringConfig? scoring, UIConfig? ui, List<Modifier> modifiers, JsonMap? extensions
});


$I18nTextCopyWith<$Res> get title;$VariantModeCopyWith<$Res> get mode;$RulesConfigCopyWith<$Res>? get rules;$GoalSetCopyWith<$Res>? get goals;$HintConfigCopyWith<$Res>? get hints;$ScoringConfigCopyWith<$Res>? get scoring;$UIConfigCopyWith<$Res>? get ui;

}
/// @nodoc
class _$PuzzleVariantCopyWithImpl<$Res>
    implements $PuzzleVariantCopyWith<$Res> {
  _$PuzzleVariantCopyWithImpl(this._self, this._then);

  final PuzzleVariant _self;
  final $Res Function(PuzzleVariant) _then;

/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? mode = null,Object? rules = freezed,Object? goals = freezed,Object? hints = freezed,Object? scoring = freezed,Object? ui = freezed,Object? modifiers = null,Object? extensions = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as I18nText,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as VariantMode,rules: freezed == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as RulesConfig?,goals: freezed == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as GoalSet?,hints: freezed == hints ? _self.hints : hints // ignore: cast_nullable_to_non_nullable
as HintConfig?,scoring: freezed == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as ScoringConfig?,ui: freezed == ui ? _self.ui : ui // ignore: cast_nullable_to_non_nullable
as UIConfig?,modifiers: null == modifiers ? _self.modifiers : modifiers // ignore: cast_nullable_to_non_nullable
as List<Modifier>,extensions: freezed == extensions ? _self.extensions : extensions // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}
/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$I18nTextCopyWith<$Res> get title {
  
  return $I18nTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VariantModeCopyWith<$Res> get mode {
  
  return $VariantModeCopyWith<$Res>(_self.mode, (value) {
    return _then(_self.copyWith(mode: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RulesConfigCopyWith<$Res>? get rules {
    if (_self.rules == null) {
    return null;
  }

  return $RulesConfigCopyWith<$Res>(_self.rules!, (value) {
    return _then(_self.copyWith(rules: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalSetCopyWith<$Res>? get goals {
    if (_self.goals == null) {
    return null;
  }

  return $GoalSetCopyWith<$Res>(_self.goals!, (value) {
    return _then(_self.copyWith(goals: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HintConfigCopyWith<$Res>? get hints {
    if (_self.hints == null) {
    return null;
  }

  return $HintConfigCopyWith<$Res>(_self.hints!, (value) {
    return _then(_self.copyWith(hints: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoringConfigCopyWith<$Res>? get scoring {
    if (_self.scoring == null) {
    return null;
  }

  return $ScoringConfigCopyWith<$Res>(_self.scoring!, (value) {
    return _then(_self.copyWith(scoring: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIConfigCopyWith<$Res>? get ui {
    if (_self.ui == null) {
    return null;
  }

  return $UIConfigCopyWith<$Res>(_self.ui!, (value) {
    return _then(_self.copyWith(ui: value));
  });
}
}


/// Adds pattern-matching-related methods to [PuzzleVariant].
extension PuzzleVariantPatterns on PuzzleVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PuzzleVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PuzzleVariant() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PuzzleVariant value)  $default,){
final _that = this;
switch (_that) {
case _PuzzleVariant():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PuzzleVariant value)?  $default,){
final _that = this;
switch (_that) {
case _PuzzleVariant() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @I18nTextConverter()  I18nText title,  VariantMode mode,  RulesConfig? rules,  GoalSet? goals,  HintConfig? hints,  ScoringConfig? scoring,  UIConfig? ui,  List<Modifier> modifiers,  JsonMap? extensions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PuzzleVariant() when $default != null:
return $default(_that.id,_that.title,_that.mode,_that.rules,_that.goals,_that.hints,_that.scoring,_that.ui,_that.modifiers,_that.extensions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @I18nTextConverter()  I18nText title,  VariantMode mode,  RulesConfig? rules,  GoalSet? goals,  HintConfig? hints,  ScoringConfig? scoring,  UIConfig? ui,  List<Modifier> modifiers,  JsonMap? extensions)  $default,) {final _that = this;
switch (_that) {
case _PuzzleVariant():
return $default(_that.id,_that.title,_that.mode,_that.rules,_that.goals,_that.hints,_that.scoring,_that.ui,_that.modifiers,_that.extensions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @I18nTextConverter()  I18nText title,  VariantMode mode,  RulesConfig? rules,  GoalSet? goals,  HintConfig? hints,  ScoringConfig? scoring,  UIConfig? ui,  List<Modifier> modifiers,  JsonMap? extensions)?  $default,) {final _that = this;
switch (_that) {
case _PuzzleVariant() when $default != null:
return $default(_that.id,_that.title,_that.mode,_that.rules,_that.goals,_that.hints,_that.scoring,_that.ui,_that.modifiers,_that.extensions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PuzzleVariant implements PuzzleVariant {
  const _PuzzleVariant({required this.id, @I18nTextConverter() required this.title, required this.mode, this.rules, this.goals, this.hints, this.scoring, this.ui, final  List<Modifier> modifiers = const <Modifier>[], final  JsonMap? extensions}): _modifiers = modifiers,_extensions = extensions;
  factory _PuzzleVariant.fromJson(Map<String, dynamic> json) => _$PuzzleVariantFromJson(json);

@override final  String id;
@override@I18nTextConverter() final  I18nText title;
@override final  VariantMode mode;
@override final  RulesConfig? rules;
@override final  GoalSet? goals;
@override final  HintConfig? hints;
@override final  ScoringConfig? scoring;
@override final  UIConfig? ui;
 final  List<Modifier> _modifiers;
@override@JsonKey() List<Modifier> get modifiers {
  if (_modifiers is EqualUnmodifiableListView) return _modifiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_modifiers);
}

 final  JsonMap? _extensions;
@override JsonMap? get extensions {
  final value = _extensions;
  if (value == null) return null;
  if (_extensions is EqualUnmodifiableMapView) return _extensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PuzzleVariantCopyWith<_PuzzleVariant> get copyWith => __$PuzzleVariantCopyWithImpl<_PuzzleVariant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PuzzleVariantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PuzzleVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.hints, hints) || other.hints == hints)&&(identical(other.scoring, scoring) || other.scoring == scoring)&&(identical(other.ui, ui) || other.ui == ui)&&const DeepCollectionEquality().equals(other._modifiers, _modifiers)&&const DeepCollectionEquality().equals(other._extensions, _extensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,mode,rules,goals,hints,scoring,ui,const DeepCollectionEquality().hash(_modifiers),const DeepCollectionEquality().hash(_extensions));

@override
String toString() {
  return 'PuzzleVariant(id: $id, title: $title, mode: $mode, rules: $rules, goals: $goals, hints: $hints, scoring: $scoring, ui: $ui, modifiers: $modifiers, extensions: $extensions)';
}


}

/// @nodoc
abstract mixin class _$PuzzleVariantCopyWith<$Res> implements $PuzzleVariantCopyWith<$Res> {
  factory _$PuzzleVariantCopyWith(_PuzzleVariant value, $Res Function(_PuzzleVariant) _then) = __$PuzzleVariantCopyWithImpl;
@override @useResult
$Res call({
 String id,@I18nTextConverter() I18nText title, VariantMode mode, RulesConfig? rules, GoalSet? goals, HintConfig? hints, ScoringConfig? scoring, UIConfig? ui, List<Modifier> modifiers, JsonMap? extensions
});


@override $I18nTextCopyWith<$Res> get title;@override $VariantModeCopyWith<$Res> get mode;@override $RulesConfigCopyWith<$Res>? get rules;@override $GoalSetCopyWith<$Res>? get goals;@override $HintConfigCopyWith<$Res>? get hints;@override $ScoringConfigCopyWith<$Res>? get scoring;@override $UIConfigCopyWith<$Res>? get ui;

}
/// @nodoc
class __$PuzzleVariantCopyWithImpl<$Res>
    implements _$PuzzleVariantCopyWith<$Res> {
  __$PuzzleVariantCopyWithImpl(this._self, this._then);

  final _PuzzleVariant _self;
  final $Res Function(_PuzzleVariant) _then;

/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? mode = null,Object? rules = freezed,Object? goals = freezed,Object? hints = freezed,Object? scoring = freezed,Object? ui = freezed,Object? modifiers = null,Object? extensions = freezed,}) {
  return _then(_PuzzleVariant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as I18nText,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as VariantMode,rules: freezed == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as RulesConfig?,goals: freezed == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as GoalSet?,hints: freezed == hints ? _self.hints : hints // ignore: cast_nullable_to_non_nullable
as HintConfig?,scoring: freezed == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as ScoringConfig?,ui: freezed == ui ? _self.ui : ui // ignore: cast_nullable_to_non_nullable
as UIConfig?,modifiers: null == modifiers ? _self._modifiers : modifiers // ignore: cast_nullable_to_non_nullable
as List<Modifier>,extensions: freezed == extensions ? _self._extensions : extensions // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}

/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$I18nTextCopyWith<$Res> get title {
  
  return $I18nTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VariantModeCopyWith<$Res> get mode {
  
  return $VariantModeCopyWith<$Res>(_self.mode, (value) {
    return _then(_self.copyWith(mode: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RulesConfigCopyWith<$Res>? get rules {
    if (_self.rules == null) {
    return null;
  }

  return $RulesConfigCopyWith<$Res>(_self.rules!, (value) {
    return _then(_self.copyWith(rules: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalSetCopyWith<$Res>? get goals {
    if (_self.goals == null) {
    return null;
  }

  return $GoalSetCopyWith<$Res>(_self.goals!, (value) {
    return _then(_self.copyWith(goals: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HintConfigCopyWith<$Res>? get hints {
    if (_self.hints == null) {
    return null;
  }

  return $HintConfigCopyWith<$Res>(_self.hints!, (value) {
    return _then(_self.copyWith(hints: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoringConfigCopyWith<$Res>? get scoring {
    if (_self.scoring == null) {
    return null;
  }

  return $ScoringConfigCopyWith<$Res>(_self.scoring!, (value) {
    return _then(_self.copyWith(scoring: value));
  });
}/// Create a copy of PuzzleVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIConfigCopyWith<$Res>? get ui {
    if (_self.ui == null) {
    return null;
  }

  return $UIConfigCopyWith<$Res>(_self.ui!, (value) {
    return _then(_self.copyWith(ui: value));
  });
}
}

VariantMode _$VariantModeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'classic':
          return VariantModeClassic.fromJson(
            json
          );
                case 'zen':
          return VariantModeZen.fromJson(
            json
          );
                case 'timed':
          return VariantModeTimed.fromJson(
            json
          );
                case 'sprint':
          return VariantModeSprint.fromJson(
            json
          );
                case 'ordered':
          return VariantModeOrdered.fromJson(
            json
          );
                case 'subset':
          return VariantModeSubset.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'VariantMode',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$VariantMode {



  /// Serializes this VariantMode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantMode);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VariantMode()';
}


}

/// @nodoc
class $VariantModeCopyWith<$Res>  {
$VariantModeCopyWith(VariantMode _, $Res Function(VariantMode) __);
}


/// Adds pattern-matching-related methods to [VariantMode].
extension VariantModePatterns on VariantMode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VariantModeClassic value)?  classic,TResult Function( VariantModeZen value)?  zen,TResult Function( VariantModeTimed value)?  timed,TResult Function( VariantModeSprint value)?  sprint,TResult Function( VariantModeOrdered value)?  ordered,TResult Function( VariantModeSubset value)?  subset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VariantModeClassic() when classic != null:
return classic(_that);case VariantModeZen() when zen != null:
return zen(_that);case VariantModeTimed() when timed != null:
return timed(_that);case VariantModeSprint() when sprint != null:
return sprint(_that);case VariantModeOrdered() when ordered != null:
return ordered(_that);case VariantModeSubset() when subset != null:
return subset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VariantModeClassic value)  classic,required TResult Function( VariantModeZen value)  zen,required TResult Function( VariantModeTimed value)  timed,required TResult Function( VariantModeSprint value)  sprint,required TResult Function( VariantModeOrdered value)  ordered,required TResult Function( VariantModeSubset value)  subset,}){
final _that = this;
switch (_that) {
case VariantModeClassic():
return classic(_that);case VariantModeZen():
return zen(_that);case VariantModeTimed():
return timed(_that);case VariantModeSprint():
return sprint(_that);case VariantModeOrdered():
return ordered(_that);case VariantModeSubset():
return subset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VariantModeClassic value)?  classic,TResult? Function( VariantModeZen value)?  zen,TResult? Function( VariantModeTimed value)?  timed,TResult? Function( VariantModeSprint value)?  sprint,TResult? Function( VariantModeOrdered value)?  ordered,TResult? Function( VariantModeSubset value)?  subset,}){
final _that = this;
switch (_that) {
case VariantModeClassic() when classic != null:
return classic(_that);case VariantModeZen() when zen != null:
return zen(_that);case VariantModeTimed() when timed != null:
return timed(_that);case VariantModeSprint() when sprint != null:
return sprint(_that);case VariantModeOrdered() when ordered != null:
return ordered(_that);case VariantModeSubset() when subset != null:
return subset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  classic,TResult Function()?  zen,TResult Function( int timeLimitSec)?  timed,TResult Function( int timeLimitSec)?  sprint,TResult Function( OrderConfig order)?  ordered,TResult Function( SubsetBy by,  String? groupId,  String? tag,  List<String>? wordIds,  int? count)?  subset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VariantModeClassic() when classic != null:
return classic();case VariantModeZen() when zen != null:
return zen();case VariantModeTimed() when timed != null:
return timed(_that.timeLimitSec);case VariantModeSprint() when sprint != null:
return sprint(_that.timeLimitSec);case VariantModeOrdered() when ordered != null:
return ordered(_that.order);case VariantModeSubset() when subset != null:
return subset(_that.by,_that.groupId,_that.tag,_that.wordIds,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  classic,required TResult Function()  zen,required TResult Function( int timeLimitSec)  timed,required TResult Function( int timeLimitSec)  sprint,required TResult Function( OrderConfig order)  ordered,required TResult Function( SubsetBy by,  String? groupId,  String? tag,  List<String>? wordIds,  int? count)  subset,}) {final _that = this;
switch (_that) {
case VariantModeClassic():
return classic();case VariantModeZen():
return zen();case VariantModeTimed():
return timed(_that.timeLimitSec);case VariantModeSprint():
return sprint(_that.timeLimitSec);case VariantModeOrdered():
return ordered(_that.order);case VariantModeSubset():
return subset(_that.by,_that.groupId,_that.tag,_that.wordIds,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  classic,TResult? Function()?  zen,TResult? Function( int timeLimitSec)?  timed,TResult? Function( int timeLimitSec)?  sprint,TResult? Function( OrderConfig order)?  ordered,TResult? Function( SubsetBy by,  String? groupId,  String? tag,  List<String>? wordIds,  int? count)?  subset,}) {final _that = this;
switch (_that) {
case VariantModeClassic() when classic != null:
return classic();case VariantModeZen() when zen != null:
return zen();case VariantModeTimed() when timed != null:
return timed(_that.timeLimitSec);case VariantModeSprint() when sprint != null:
return sprint(_that.timeLimitSec);case VariantModeOrdered() when ordered != null:
return ordered(_that.order);case VariantModeSubset() when subset != null:
return subset(_that.by,_that.groupId,_that.tag,_that.wordIds,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class VariantModeClassic implements VariantMode {
  const VariantModeClassic({final  String? $type}): $type = $type ?? 'classic';
  factory VariantModeClassic.fromJson(Map<String, dynamic> json) => _$VariantModeClassicFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$VariantModeClassicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModeClassic);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VariantMode.classic()';
}


}




/// @nodoc
@JsonSerializable()

class VariantModeZen implements VariantMode {
  const VariantModeZen({final  String? $type}): $type = $type ?? 'zen';
  factory VariantModeZen.fromJson(Map<String, dynamic> json) => _$VariantModeZenFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$VariantModeZenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModeZen);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VariantMode.zen()';
}


}




/// @nodoc
@JsonSerializable()

class VariantModeTimed implements VariantMode {
  const VariantModeTimed({required this.timeLimitSec, final  String? $type}): $type = $type ?? 'timed';
  factory VariantModeTimed.fromJson(Map<String, dynamic> json) => _$VariantModeTimedFromJson(json);

 final  int timeLimitSec;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantModeTimedCopyWith<VariantModeTimed> get copyWith => _$VariantModeTimedCopyWithImpl<VariantModeTimed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantModeTimedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModeTimed&&(identical(other.timeLimitSec, timeLimitSec) || other.timeLimitSec == timeLimitSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeLimitSec);

@override
String toString() {
  return 'VariantMode.timed(timeLimitSec: $timeLimitSec)';
}


}

/// @nodoc
abstract mixin class $VariantModeTimedCopyWith<$Res> implements $VariantModeCopyWith<$Res> {
  factory $VariantModeTimedCopyWith(VariantModeTimed value, $Res Function(VariantModeTimed) _then) = _$VariantModeTimedCopyWithImpl;
@useResult
$Res call({
 int timeLimitSec
});




}
/// @nodoc
class _$VariantModeTimedCopyWithImpl<$Res>
    implements $VariantModeTimedCopyWith<$Res> {
  _$VariantModeTimedCopyWithImpl(this._self, this._then);

  final VariantModeTimed _self;
  final $Res Function(VariantModeTimed) _then;

/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timeLimitSec = null,}) {
  return _then(VariantModeTimed(
timeLimitSec: null == timeLimitSec ? _self.timeLimitSec : timeLimitSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VariantModeSprint implements VariantMode {
  const VariantModeSprint({required this.timeLimitSec, final  String? $type}): $type = $type ?? 'sprint';
  factory VariantModeSprint.fromJson(Map<String, dynamic> json) => _$VariantModeSprintFromJson(json);

 final  int timeLimitSec;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantModeSprintCopyWith<VariantModeSprint> get copyWith => _$VariantModeSprintCopyWithImpl<VariantModeSprint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantModeSprintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModeSprint&&(identical(other.timeLimitSec, timeLimitSec) || other.timeLimitSec == timeLimitSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeLimitSec);

@override
String toString() {
  return 'VariantMode.sprint(timeLimitSec: $timeLimitSec)';
}


}

/// @nodoc
abstract mixin class $VariantModeSprintCopyWith<$Res> implements $VariantModeCopyWith<$Res> {
  factory $VariantModeSprintCopyWith(VariantModeSprint value, $Res Function(VariantModeSprint) _then) = _$VariantModeSprintCopyWithImpl;
@useResult
$Res call({
 int timeLimitSec
});




}
/// @nodoc
class _$VariantModeSprintCopyWithImpl<$Res>
    implements $VariantModeSprintCopyWith<$Res> {
  _$VariantModeSprintCopyWithImpl(this._self, this._then);

  final VariantModeSprint _self;
  final $Res Function(VariantModeSprint) _then;

/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timeLimitSec = null,}) {
  return _then(VariantModeSprint(
timeLimitSec: null == timeLimitSec ? _self.timeLimitSec : timeLimitSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VariantModeOrdered implements VariantMode {
  const VariantModeOrdered({required this.order, final  String? $type}): $type = $type ?? 'ordered';
  factory VariantModeOrdered.fromJson(Map<String, dynamic> json) => _$VariantModeOrderedFromJson(json);

 final  OrderConfig order;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantModeOrderedCopyWith<VariantModeOrdered> get copyWith => _$VariantModeOrderedCopyWithImpl<VariantModeOrdered>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantModeOrderedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModeOrdered&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'VariantMode.ordered(order: $order)';
}


}

/// @nodoc
abstract mixin class $VariantModeOrderedCopyWith<$Res> implements $VariantModeCopyWith<$Res> {
  factory $VariantModeOrderedCopyWith(VariantModeOrdered value, $Res Function(VariantModeOrdered) _then) = _$VariantModeOrderedCopyWithImpl;
@useResult
$Res call({
 OrderConfig order
});


$OrderConfigCopyWith<$Res> get order;

}
/// @nodoc
class _$VariantModeOrderedCopyWithImpl<$Res>
    implements $VariantModeOrderedCopyWith<$Res> {
  _$VariantModeOrderedCopyWithImpl(this._self, this._then);

  final VariantModeOrdered _self;
  final $Res Function(VariantModeOrdered) _then;

/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(VariantModeOrdered(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderConfig,
  ));
}

/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderConfigCopyWith<$Res> get order {
  
  return $OrderConfigCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class VariantModeSubset implements VariantMode {
  const VariantModeSubset({required this.by, this.groupId, this.tag, final  List<String>? wordIds, this.count, final  String? $type}): _wordIds = wordIds,$type = $type ?? 'subset';
  factory VariantModeSubset.fromJson(Map<String, dynamic> json) => _$VariantModeSubsetFromJson(json);

 final  SubsetBy by;
 final  String? groupId;
 final  String? tag;
 final  List<String>? _wordIds;
 List<String>? get wordIds {
  final value = _wordIds;
  if (value == null) return null;
  if (_wordIds is EqualUnmodifiableListView) return _wordIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? count;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantModeSubsetCopyWith<VariantModeSubset> get copyWith => _$VariantModeSubsetCopyWithImpl<VariantModeSubset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantModeSubsetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModeSubset&&(identical(other.by, by) || other.by == by)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.tag, tag) || other.tag == tag)&&const DeepCollectionEquality().equals(other._wordIds, _wordIds)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,by,groupId,tag,const DeepCollectionEquality().hash(_wordIds),count);

@override
String toString() {
  return 'VariantMode.subset(by: $by, groupId: $groupId, tag: $tag, wordIds: $wordIds, count: $count)';
}


}

/// @nodoc
abstract mixin class $VariantModeSubsetCopyWith<$Res> implements $VariantModeCopyWith<$Res> {
  factory $VariantModeSubsetCopyWith(VariantModeSubset value, $Res Function(VariantModeSubset) _then) = _$VariantModeSubsetCopyWithImpl;
@useResult
$Res call({
 SubsetBy by, String? groupId, String? tag, List<String>? wordIds, int? count
});




}
/// @nodoc
class _$VariantModeSubsetCopyWithImpl<$Res>
    implements $VariantModeSubsetCopyWith<$Res> {
  _$VariantModeSubsetCopyWithImpl(this._self, this._then);

  final VariantModeSubset _self;
  final $Res Function(VariantModeSubset) _then;

/// Create a copy of VariantMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? by = null,Object? groupId = freezed,Object? tag = freezed,Object? wordIds = freezed,Object? count = freezed,}) {
  return _then(VariantModeSubset(
by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as SubsetBy,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,wordIds: freezed == wordIds ? _self._wordIds : wordIds // ignore: cast_nullable_to_non_nullable
as List<String>?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

OrderConfig _$OrderConfigFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'explicit':
          return OrderConfigExplicit.fromJson(
            json
          );
                case 'by_length':
          return OrderConfigByLength.fromJson(
            json
          );
                case 'by_tag':
          return OrderConfigByTag.fromJson(
            json
          );
                case 'random':
          return OrderConfigRandom.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'OrderConfig',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$OrderConfig {



  /// Serializes this OrderConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfig);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderConfig()';
}


}

/// @nodoc
class $OrderConfigCopyWith<$Res>  {
$OrderConfigCopyWith(OrderConfig _, $Res Function(OrderConfig) __);
}


/// Adds pattern-matching-related methods to [OrderConfig].
extension OrderConfigPatterns on OrderConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderConfigExplicit value)?  explicit,TResult Function( OrderConfigByLength value)?  byLength,TResult Function( OrderConfigByTag value)?  byTag,TResult Function( OrderConfigRandom value)?  random,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderConfigExplicit() when explicit != null:
return explicit(_that);case OrderConfigByLength() when byLength != null:
return byLength(_that);case OrderConfigByTag() when byTag != null:
return byTag(_that);case OrderConfigRandom() when random != null:
return random(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderConfigExplicit value)  explicit,required TResult Function( OrderConfigByLength value)  byLength,required TResult Function( OrderConfigByTag value)  byTag,required TResult Function( OrderConfigRandom value)  random,}){
final _that = this;
switch (_that) {
case OrderConfigExplicit():
return explicit(_that);case OrderConfigByLength():
return byLength(_that);case OrderConfigByTag():
return byTag(_that);case OrderConfigRandom():
return random(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderConfigExplicit value)?  explicit,TResult? Function( OrderConfigByLength value)?  byLength,TResult? Function( OrderConfigByTag value)?  byTag,TResult? Function( OrderConfigRandom value)?  random,}){
final _that = this;
switch (_that) {
case OrderConfigExplicit() when explicit != null:
return explicit(_that);case OrderConfigByLength() when byLength != null:
return byLength(_that);case OrderConfigByTag() when byTag != null:
return byTag(_that);case OrderConfigRandom() when random != null:
return random(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<String> wordIds)?  explicit,TResult Function( bool ascending)?  byLength,TResult Function( String tag)?  byTag,TResult Function()?  random,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderConfigExplicit() when explicit != null:
return explicit(_that.wordIds);case OrderConfigByLength() when byLength != null:
return byLength(_that.ascending);case OrderConfigByTag() when byTag != null:
return byTag(_that.tag);case OrderConfigRandom() when random != null:
return random();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<String> wordIds)  explicit,required TResult Function( bool ascending)  byLength,required TResult Function( String tag)  byTag,required TResult Function()  random,}) {final _that = this;
switch (_that) {
case OrderConfigExplicit():
return explicit(_that.wordIds);case OrderConfigByLength():
return byLength(_that.ascending);case OrderConfigByTag():
return byTag(_that.tag);case OrderConfigRandom():
return random();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<String> wordIds)?  explicit,TResult? Function( bool ascending)?  byLength,TResult? Function( String tag)?  byTag,TResult? Function()?  random,}) {final _that = this;
switch (_that) {
case OrderConfigExplicit() when explicit != null:
return explicit(_that.wordIds);case OrderConfigByLength() when byLength != null:
return byLength(_that.ascending);case OrderConfigByTag() when byTag != null:
return byTag(_that.tag);case OrderConfigRandom() when random != null:
return random();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class OrderConfigExplicit implements OrderConfig {
  const OrderConfigExplicit({required final  List<String> wordIds, final  String? $type}): _wordIds = wordIds,$type = $type ?? 'explicit';
  factory OrderConfigExplicit.fromJson(Map<String, dynamic> json) => _$OrderConfigExplicitFromJson(json);

 final  List<String> _wordIds;
 List<String> get wordIds {
  if (_wordIds is EqualUnmodifiableListView) return _wordIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wordIds);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of OrderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderConfigExplicitCopyWith<OrderConfigExplicit> get copyWith => _$OrderConfigExplicitCopyWithImpl<OrderConfigExplicit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderConfigExplicitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfigExplicit&&const DeepCollectionEquality().equals(other._wordIds, _wordIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_wordIds));

@override
String toString() {
  return 'OrderConfig.explicit(wordIds: $wordIds)';
}


}

/// @nodoc
abstract mixin class $OrderConfigExplicitCopyWith<$Res> implements $OrderConfigCopyWith<$Res> {
  factory $OrderConfigExplicitCopyWith(OrderConfigExplicit value, $Res Function(OrderConfigExplicit) _then) = _$OrderConfigExplicitCopyWithImpl;
@useResult
$Res call({
 List<String> wordIds
});




}
/// @nodoc
class _$OrderConfigExplicitCopyWithImpl<$Res>
    implements $OrderConfigExplicitCopyWith<$Res> {
  _$OrderConfigExplicitCopyWithImpl(this._self, this._then);

  final OrderConfigExplicit _self;
  final $Res Function(OrderConfigExplicit) _then;

/// Create a copy of OrderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? wordIds = null,}) {
  return _then(OrderConfigExplicit(
wordIds: null == wordIds ? _self._wordIds : wordIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OrderConfigByLength implements OrderConfig {
  const OrderConfigByLength({this.ascending = true, final  String? $type}): $type = $type ?? 'by_length';
  factory OrderConfigByLength.fromJson(Map<String, dynamic> json) => _$OrderConfigByLengthFromJson(json);

@JsonKey() final  bool ascending;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of OrderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderConfigByLengthCopyWith<OrderConfigByLength> get copyWith => _$OrderConfigByLengthCopyWithImpl<OrderConfigByLength>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderConfigByLengthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfigByLength&&(identical(other.ascending, ascending) || other.ascending == ascending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ascending);

@override
String toString() {
  return 'OrderConfig.byLength(ascending: $ascending)';
}


}

/// @nodoc
abstract mixin class $OrderConfigByLengthCopyWith<$Res> implements $OrderConfigCopyWith<$Res> {
  factory $OrderConfigByLengthCopyWith(OrderConfigByLength value, $Res Function(OrderConfigByLength) _then) = _$OrderConfigByLengthCopyWithImpl;
@useResult
$Res call({
 bool ascending
});




}
/// @nodoc
class _$OrderConfigByLengthCopyWithImpl<$Res>
    implements $OrderConfigByLengthCopyWith<$Res> {
  _$OrderConfigByLengthCopyWithImpl(this._self, this._then);

  final OrderConfigByLength _self;
  final $Res Function(OrderConfigByLength) _then;

/// Create a copy of OrderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ascending = null,}) {
  return _then(OrderConfigByLength(
ascending: null == ascending ? _self.ascending : ascending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OrderConfigByTag implements OrderConfig {
  const OrderConfigByTag({required this.tag, final  String? $type}): $type = $type ?? 'by_tag';
  factory OrderConfigByTag.fromJson(Map<String, dynamic> json) => _$OrderConfigByTagFromJson(json);

 final  String tag;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of OrderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderConfigByTagCopyWith<OrderConfigByTag> get copyWith => _$OrderConfigByTagCopyWithImpl<OrderConfigByTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderConfigByTagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfigByTag&&(identical(other.tag, tag) || other.tag == tag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tag);

@override
String toString() {
  return 'OrderConfig.byTag(tag: $tag)';
}


}

/// @nodoc
abstract mixin class $OrderConfigByTagCopyWith<$Res> implements $OrderConfigCopyWith<$Res> {
  factory $OrderConfigByTagCopyWith(OrderConfigByTag value, $Res Function(OrderConfigByTag) _then) = _$OrderConfigByTagCopyWithImpl;
@useResult
$Res call({
 String tag
});




}
/// @nodoc
class _$OrderConfigByTagCopyWithImpl<$Res>
    implements $OrderConfigByTagCopyWith<$Res> {
  _$OrderConfigByTagCopyWithImpl(this._self, this._then);

  final OrderConfigByTag _self;
  final $Res Function(OrderConfigByTag) _then;

/// Create a copy of OrderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tag = null,}) {
  return _then(OrderConfigByTag(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OrderConfigRandom implements OrderConfig {
  const OrderConfigRandom({final  String? $type}): $type = $type ?? 'random';
  factory OrderConfigRandom.fromJson(Map<String, dynamic> json) => _$OrderConfigRandomFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$OrderConfigRandomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfigRandom);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderConfig.random()';
}


}





/// @nodoc
mixin _$RulesConfig {

 AllowedDirsPreset get allowedDirsPreset; List<Direction> get allowedDirs; bool get straightLineOnly; bool get allowReuseCell; SelectionConfig get selection;
/// Create a copy of RulesConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesConfigCopyWith<RulesConfig> get copyWith => _$RulesConfigCopyWithImpl<RulesConfig>(this as RulesConfig, _$identity);

  /// Serializes this RulesConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesConfig&&(identical(other.allowedDirsPreset, allowedDirsPreset) || other.allowedDirsPreset == allowedDirsPreset)&&const DeepCollectionEquality().equals(other.allowedDirs, allowedDirs)&&(identical(other.straightLineOnly, straightLineOnly) || other.straightLineOnly == straightLineOnly)&&(identical(other.allowReuseCell, allowReuseCell) || other.allowReuseCell == allowReuseCell)&&(identical(other.selection, selection) || other.selection == selection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allowedDirsPreset,const DeepCollectionEquality().hash(allowedDirs),straightLineOnly,allowReuseCell,selection);

@override
String toString() {
  return 'RulesConfig(allowedDirsPreset: $allowedDirsPreset, allowedDirs: $allowedDirs, straightLineOnly: $straightLineOnly, allowReuseCell: $allowReuseCell, selection: $selection)';
}


}

/// @nodoc
abstract mixin class $RulesConfigCopyWith<$Res>  {
  factory $RulesConfigCopyWith(RulesConfig value, $Res Function(RulesConfig) _then) = _$RulesConfigCopyWithImpl;
@useResult
$Res call({
 AllowedDirsPreset allowedDirsPreset, List<Direction> allowedDirs, bool straightLineOnly, bool allowReuseCell, SelectionConfig selection
});


$SelectionConfigCopyWith<$Res> get selection;

}
/// @nodoc
class _$RulesConfigCopyWithImpl<$Res>
    implements $RulesConfigCopyWith<$Res> {
  _$RulesConfigCopyWithImpl(this._self, this._then);

  final RulesConfig _self;
  final $Res Function(RulesConfig) _then;

/// Create a copy of RulesConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allowedDirsPreset = null,Object? allowedDirs = null,Object? straightLineOnly = null,Object? allowReuseCell = null,Object? selection = null,}) {
  return _then(_self.copyWith(
allowedDirsPreset: null == allowedDirsPreset ? _self.allowedDirsPreset : allowedDirsPreset // ignore: cast_nullable_to_non_nullable
as AllowedDirsPreset,allowedDirs: null == allowedDirs ? _self.allowedDirs : allowedDirs // ignore: cast_nullable_to_non_nullable
as List<Direction>,straightLineOnly: null == straightLineOnly ? _self.straightLineOnly : straightLineOnly // ignore: cast_nullable_to_non_nullable
as bool,allowReuseCell: null == allowReuseCell ? _self.allowReuseCell : allowReuseCell // ignore: cast_nullable_to_non_nullable
as bool,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as SelectionConfig,
  ));
}
/// Create a copy of RulesConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionConfigCopyWith<$Res> get selection {
  
  return $SelectionConfigCopyWith<$Res>(_self.selection, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}


/// Adds pattern-matching-related methods to [RulesConfig].
extension RulesConfigPatterns on RulesConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RulesConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RulesConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RulesConfig value)  $default,){
final _that = this;
switch (_that) {
case _RulesConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RulesConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RulesConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AllowedDirsPreset allowedDirsPreset,  List<Direction> allowedDirs,  bool straightLineOnly,  bool allowReuseCell,  SelectionConfig selection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RulesConfig() when $default != null:
return $default(_that.allowedDirsPreset,_that.allowedDirs,_that.straightLineOnly,_that.allowReuseCell,_that.selection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AllowedDirsPreset allowedDirsPreset,  List<Direction> allowedDirs,  bool straightLineOnly,  bool allowReuseCell,  SelectionConfig selection)  $default,) {final _that = this;
switch (_that) {
case _RulesConfig():
return $default(_that.allowedDirsPreset,_that.allowedDirs,_that.straightLineOnly,_that.allowReuseCell,_that.selection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AllowedDirsPreset allowedDirsPreset,  List<Direction> allowedDirs,  bool straightLineOnly,  bool allowReuseCell,  SelectionConfig selection)?  $default,) {final _that = this;
switch (_that) {
case _RulesConfig() when $default != null:
return $default(_that.allowedDirsPreset,_that.allowedDirs,_that.straightLineOnly,_that.allowReuseCell,_that.selection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RulesConfig implements RulesConfig {
  const _RulesConfig({this.allowedDirsPreset = AllowedDirsPreset.eightway, final  List<Direction> allowedDirs = const <Direction>[], this.straightLineOnly = true, this.allowReuseCell = true, this.selection = const SelectionConfig()}): _allowedDirs = allowedDirs;
  factory _RulesConfig.fromJson(Map<String, dynamic> json) => _$RulesConfigFromJson(json);

@override@JsonKey() final  AllowedDirsPreset allowedDirsPreset;
 final  List<Direction> _allowedDirs;
@override@JsonKey() List<Direction> get allowedDirs {
  if (_allowedDirs is EqualUnmodifiableListView) return _allowedDirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedDirs);
}

@override@JsonKey() final  bool straightLineOnly;
@override@JsonKey() final  bool allowReuseCell;
@override@JsonKey() final  SelectionConfig selection;

/// Create a copy of RulesConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RulesConfigCopyWith<_RulesConfig> get copyWith => __$RulesConfigCopyWithImpl<_RulesConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RulesConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RulesConfig&&(identical(other.allowedDirsPreset, allowedDirsPreset) || other.allowedDirsPreset == allowedDirsPreset)&&const DeepCollectionEquality().equals(other._allowedDirs, _allowedDirs)&&(identical(other.straightLineOnly, straightLineOnly) || other.straightLineOnly == straightLineOnly)&&(identical(other.allowReuseCell, allowReuseCell) || other.allowReuseCell == allowReuseCell)&&(identical(other.selection, selection) || other.selection == selection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allowedDirsPreset,const DeepCollectionEquality().hash(_allowedDirs),straightLineOnly,allowReuseCell,selection);

@override
String toString() {
  return 'RulesConfig(allowedDirsPreset: $allowedDirsPreset, allowedDirs: $allowedDirs, straightLineOnly: $straightLineOnly, allowReuseCell: $allowReuseCell, selection: $selection)';
}


}

/// @nodoc
abstract mixin class _$RulesConfigCopyWith<$Res> implements $RulesConfigCopyWith<$Res> {
  factory _$RulesConfigCopyWith(_RulesConfig value, $Res Function(_RulesConfig) _then) = __$RulesConfigCopyWithImpl;
@override @useResult
$Res call({
 AllowedDirsPreset allowedDirsPreset, List<Direction> allowedDirs, bool straightLineOnly, bool allowReuseCell, SelectionConfig selection
});


@override $SelectionConfigCopyWith<$Res> get selection;

}
/// @nodoc
class __$RulesConfigCopyWithImpl<$Res>
    implements _$RulesConfigCopyWith<$Res> {
  __$RulesConfigCopyWithImpl(this._self, this._then);

  final _RulesConfig _self;
  final $Res Function(_RulesConfig) _then;

/// Create a copy of RulesConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allowedDirsPreset = null,Object? allowedDirs = null,Object? straightLineOnly = null,Object? allowReuseCell = null,Object? selection = null,}) {
  return _then(_RulesConfig(
allowedDirsPreset: null == allowedDirsPreset ? _self.allowedDirsPreset : allowedDirsPreset // ignore: cast_nullable_to_non_nullable
as AllowedDirsPreset,allowedDirs: null == allowedDirs ? _self._allowedDirs : allowedDirs // ignore: cast_nullable_to_non_nullable
as List<Direction>,straightLineOnly: null == straightLineOnly ? _self.straightLineOnly : straightLineOnly // ignore: cast_nullable_to_non_nullable
as bool,allowReuseCell: null == allowReuseCell ? _self.allowReuseCell : allowReuseCell // ignore: cast_nullable_to_non_nullable
as bool,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as SelectionConfig,
  ));
}

/// Create a copy of RulesConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionConfigCopyWith<$Res> get selection {
  
  return $SelectionConfigCopyWith<$Res>(_self.selection, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}


/// @nodoc
mixin _$SelectionConfig {

 int get minLen; int? get maxLen; bool get snapToGrid;
/// Create a copy of SelectionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionConfigCopyWith<SelectionConfig> get copyWith => _$SelectionConfigCopyWithImpl<SelectionConfig>(this as SelectionConfig, _$identity);

  /// Serializes this SelectionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionConfig&&(identical(other.minLen, minLen) || other.minLen == minLen)&&(identical(other.maxLen, maxLen) || other.maxLen == maxLen)&&(identical(other.snapToGrid, snapToGrid) || other.snapToGrid == snapToGrid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLen,maxLen,snapToGrid);

@override
String toString() {
  return 'SelectionConfig(minLen: $minLen, maxLen: $maxLen, snapToGrid: $snapToGrid)';
}


}

/// @nodoc
abstract mixin class $SelectionConfigCopyWith<$Res>  {
  factory $SelectionConfigCopyWith(SelectionConfig value, $Res Function(SelectionConfig) _then) = _$SelectionConfigCopyWithImpl;
@useResult
$Res call({
 int minLen, int? maxLen, bool snapToGrid
});




}
/// @nodoc
class _$SelectionConfigCopyWithImpl<$Res>
    implements $SelectionConfigCopyWith<$Res> {
  _$SelectionConfigCopyWithImpl(this._self, this._then);

  final SelectionConfig _self;
  final $Res Function(SelectionConfig) _then;

/// Create a copy of SelectionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLen = null,Object? maxLen = freezed,Object? snapToGrid = null,}) {
  return _then(_self.copyWith(
minLen: null == minLen ? _self.minLen : minLen // ignore: cast_nullable_to_non_nullable
as int,maxLen: freezed == maxLen ? _self.maxLen : maxLen // ignore: cast_nullable_to_non_nullable
as int?,snapToGrid: null == snapToGrid ? _self.snapToGrid : snapToGrid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectionConfig].
extension SelectionConfigPatterns on SelectionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectionConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectionConfig value)  $default,){
final _that = this;
switch (_that) {
case _SelectionConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SelectionConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int minLen,  int? maxLen,  bool snapToGrid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectionConfig() when $default != null:
return $default(_that.minLen,_that.maxLen,_that.snapToGrid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int minLen,  int? maxLen,  bool snapToGrid)  $default,) {final _that = this;
switch (_that) {
case _SelectionConfig():
return $default(_that.minLen,_that.maxLen,_that.snapToGrid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int minLen,  int? maxLen,  bool snapToGrid)?  $default,) {final _that = this;
switch (_that) {
case _SelectionConfig() when $default != null:
return $default(_that.minLen,_that.maxLen,_that.snapToGrid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectionConfig implements SelectionConfig {
  const _SelectionConfig({this.minLen = 2, this.maxLen, this.snapToGrid = true});
  factory _SelectionConfig.fromJson(Map<String, dynamic> json) => _$SelectionConfigFromJson(json);

@override@JsonKey() final  int minLen;
@override final  int? maxLen;
@override@JsonKey() final  bool snapToGrid;

/// Create a copy of SelectionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionConfigCopyWith<_SelectionConfig> get copyWith => __$SelectionConfigCopyWithImpl<_SelectionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionConfig&&(identical(other.minLen, minLen) || other.minLen == minLen)&&(identical(other.maxLen, maxLen) || other.maxLen == maxLen)&&(identical(other.snapToGrid, snapToGrid) || other.snapToGrid == snapToGrid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLen,maxLen,snapToGrid);

@override
String toString() {
  return 'SelectionConfig(minLen: $minLen, maxLen: $maxLen, snapToGrid: $snapToGrid)';
}


}

/// @nodoc
abstract mixin class _$SelectionConfigCopyWith<$Res> implements $SelectionConfigCopyWith<$Res> {
  factory _$SelectionConfigCopyWith(_SelectionConfig value, $Res Function(_SelectionConfig) _then) = __$SelectionConfigCopyWithImpl;
@override @useResult
$Res call({
 int minLen, int? maxLen, bool snapToGrid
});




}
/// @nodoc
class __$SelectionConfigCopyWithImpl<$Res>
    implements _$SelectionConfigCopyWith<$Res> {
  __$SelectionConfigCopyWithImpl(this._self, this._then);

  final _SelectionConfig _self;
  final $Res Function(_SelectionConfig) _then;

/// Create a copy of SelectionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLen = null,Object? maxLen = freezed,Object? snapToGrid = null,}) {
  return _then(_SelectionConfig(
minLen: null == minLen ? _self.minLen : minLen // ignore: cast_nullable_to_non_nullable
as int,maxLen: freezed == maxLen ? _self.maxLen : maxLen // ignore: cast_nullable_to_non_nullable
as int?,snapToGrid: null == snapToGrid ? _self.snapToGrid : snapToGrid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$GoalSet {

 List<Condition> get end; List<Condition> get win; List<Condition> get fail;
/// Create a copy of GoalSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalSetCopyWith<GoalSet> get copyWith => _$GoalSetCopyWithImpl<GoalSet>(this as GoalSet, _$identity);

  /// Serializes this GoalSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalSet&&const DeepCollectionEquality().equals(other.end, end)&&const DeepCollectionEquality().equals(other.win, win)&&const DeepCollectionEquality().equals(other.fail, fail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(end),const DeepCollectionEquality().hash(win),const DeepCollectionEquality().hash(fail));

@override
String toString() {
  return 'GoalSet(end: $end, win: $win, fail: $fail)';
}


}

/// @nodoc
abstract mixin class $GoalSetCopyWith<$Res>  {
  factory $GoalSetCopyWith(GoalSet value, $Res Function(GoalSet) _then) = _$GoalSetCopyWithImpl;
@useResult
$Res call({
 List<Condition> end, List<Condition> win, List<Condition> fail
});




}
/// @nodoc
class _$GoalSetCopyWithImpl<$Res>
    implements $GoalSetCopyWith<$Res> {
  _$GoalSetCopyWithImpl(this._self, this._then);

  final GoalSet _self;
  final $Res Function(GoalSet) _then;

/// Create a copy of GoalSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? end = null,Object? win = null,Object? fail = null,}) {
  return _then(_self.copyWith(
end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as List<Condition>,win: null == win ? _self.win : win // ignore: cast_nullable_to_non_nullable
as List<Condition>,fail: null == fail ? _self.fail : fail // ignore: cast_nullable_to_non_nullable
as List<Condition>,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalSet].
extension GoalSetPatterns on GoalSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalSet() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalSet value)  $default,){
final _that = this;
switch (_that) {
case _GoalSet():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalSet value)?  $default,){
final _that = this;
switch (_that) {
case _GoalSet() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Condition> end,  List<Condition> win,  List<Condition> fail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalSet() when $default != null:
return $default(_that.end,_that.win,_that.fail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Condition> end,  List<Condition> win,  List<Condition> fail)  $default,) {final _that = this;
switch (_that) {
case _GoalSet():
return $default(_that.end,_that.win,_that.fail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Condition> end,  List<Condition> win,  List<Condition> fail)?  $default,) {final _that = this;
switch (_that) {
case _GoalSet() when $default != null:
return $default(_that.end,_that.win,_that.fail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalSet implements GoalSet {
  const _GoalSet({final  List<Condition> end = const <Condition>[], final  List<Condition> win = const <Condition>[], final  List<Condition> fail = const <Condition>[]}): _end = end,_win = win,_fail = fail;
  factory _GoalSet.fromJson(Map<String, dynamic> json) => _$GoalSetFromJson(json);

 final  List<Condition> _end;
@override@JsonKey() List<Condition> get end {
  if (_end is EqualUnmodifiableListView) return _end;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_end);
}

 final  List<Condition> _win;
@override@JsonKey() List<Condition> get win {
  if (_win is EqualUnmodifiableListView) return _win;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_win);
}

 final  List<Condition> _fail;
@override@JsonKey() List<Condition> get fail {
  if (_fail is EqualUnmodifiableListView) return _fail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fail);
}


/// Create a copy of GoalSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalSetCopyWith<_GoalSet> get copyWith => __$GoalSetCopyWithImpl<_GoalSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalSet&&const DeepCollectionEquality().equals(other._end, _end)&&const DeepCollectionEquality().equals(other._win, _win)&&const DeepCollectionEquality().equals(other._fail, _fail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_end),const DeepCollectionEquality().hash(_win),const DeepCollectionEquality().hash(_fail));

@override
String toString() {
  return 'GoalSet(end: $end, win: $win, fail: $fail)';
}


}

/// @nodoc
abstract mixin class _$GoalSetCopyWith<$Res> implements $GoalSetCopyWith<$Res> {
  factory _$GoalSetCopyWith(_GoalSet value, $Res Function(_GoalSet) _then) = __$GoalSetCopyWithImpl;
@override @useResult
$Res call({
 List<Condition> end, List<Condition> win, List<Condition> fail
});




}
/// @nodoc
class __$GoalSetCopyWithImpl<$Res>
    implements _$GoalSetCopyWith<$Res> {
  __$GoalSetCopyWithImpl(this._self, this._then);

  final _GoalSet _self;
  final $Res Function(_GoalSet) _then;

/// Create a copy of GoalSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? end = null,Object? win = null,Object? fail = null,}) {
  return _then(_GoalSet(
end: null == end ? _self._end : end // ignore: cast_nullable_to_non_nullable
as List<Condition>,win: null == win ? _self._win : win // ignore: cast_nullable_to_non_nullable
as List<Condition>,fail: null == fail ? _self._fail : fail // ignore: cast_nullable_to_non_nullable
as List<Condition>,
  ));
}


}


/// @nodoc
mixin _$Condition {

 ConditionType get type; JsonMap? get params;
/// Create a copy of Condition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConditionCopyWith<Condition> get copyWith => _$ConditionCopyWithImpl<Condition>(this as Condition, _$identity);

  /// Serializes this Condition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Condition&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'Condition(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class $ConditionCopyWith<$Res>  {
  factory $ConditionCopyWith(Condition value, $Res Function(Condition) _then) = _$ConditionCopyWithImpl;
@useResult
$Res call({
 ConditionType type, JsonMap? params
});




}
/// @nodoc
class _$ConditionCopyWithImpl<$Res>
    implements $ConditionCopyWith<$Res> {
  _$ConditionCopyWithImpl(this._self, this._then);

  final Condition _self;
  final $Res Function(Condition) _then;

/// Create a copy of Condition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? params = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConditionType,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}

}


/// Adds pattern-matching-related methods to [Condition].
extension ConditionPatterns on Condition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Condition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Condition() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Condition value)  $default,){
final _that = this;
switch (_that) {
case _Condition():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Condition value)?  $default,){
final _that = this;
switch (_that) {
case _Condition() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConditionType type,  JsonMap? params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Condition() when $default != null:
return $default(_that.type,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConditionType type,  JsonMap? params)  $default,) {final _that = this;
switch (_that) {
case _Condition():
return $default(_that.type,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConditionType type,  JsonMap? params)?  $default,) {final _that = this;
switch (_that) {
case _Condition() when $default != null:
return $default(_that.type,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Condition implements Condition {
  const _Condition({required this.type, final  JsonMap? params}): _params = params;
  factory _Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);

@override final  ConditionType type;
 final  JsonMap? _params;
@override JsonMap? get params {
  final value = _params;
  if (value == null) return null;
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Condition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConditionCopyWith<_Condition> get copyWith => __$ConditionCopyWithImpl<_Condition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Condition&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._params, _params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'Condition(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class _$ConditionCopyWith<$Res> implements $ConditionCopyWith<$Res> {
  factory _$ConditionCopyWith(_Condition value, $Res Function(_Condition) _then) = __$ConditionCopyWithImpl;
@override @useResult
$Res call({
 ConditionType type, JsonMap? params
});




}
/// @nodoc
class __$ConditionCopyWithImpl<$Res>
    implements _$ConditionCopyWith<$Res> {
  __$ConditionCopyWithImpl(this._self, this._then);

  final _Condition _self;
  final $Res Function(_Condition) _then;

/// Create a copy of Condition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? params = freezed,}) {
  return _then(_Condition(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConditionType,params: freezed == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}


}


/// @nodoc
mixin _$HintConfig {

 HintBudget get budget; List<HintTypeConfig> get types; Map<String, int>? get cooldownsSec;
/// Create a copy of HintConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintConfigCopyWith<HintConfig> get copyWith => _$HintConfigCopyWithImpl<HintConfig>(this as HintConfig, _$identity);

  /// Serializes this HintConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintConfig&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other.types, types)&&const DeepCollectionEquality().equals(other.cooldownsSec, cooldownsSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budget,const DeepCollectionEquality().hash(types),const DeepCollectionEquality().hash(cooldownsSec));

@override
String toString() {
  return 'HintConfig(budget: $budget, types: $types, cooldownsSec: $cooldownsSec)';
}


}

/// @nodoc
abstract mixin class $HintConfigCopyWith<$Res>  {
  factory $HintConfigCopyWith(HintConfig value, $Res Function(HintConfig) _then) = _$HintConfigCopyWithImpl;
@useResult
$Res call({
 HintBudget budget, List<HintTypeConfig> types, Map<String, int>? cooldownsSec
});


$HintBudgetCopyWith<$Res> get budget;

}
/// @nodoc
class _$HintConfigCopyWithImpl<$Res>
    implements $HintConfigCopyWith<$Res> {
  _$HintConfigCopyWithImpl(this._self, this._then);

  final HintConfig _self;
  final $Res Function(HintConfig) _then;

/// Create a copy of HintConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? budget = null,Object? types = null,Object? cooldownsSec = freezed,}) {
  return _then(_self.copyWith(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as HintBudget,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<HintTypeConfig>,cooldownsSec: freezed == cooldownsSec ? _self.cooldownsSec : cooldownsSec // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}
/// Create a copy of HintConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HintBudgetCopyWith<$Res> get budget {
  
  return $HintBudgetCopyWith<$Res>(_self.budget, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}


/// Adds pattern-matching-related methods to [HintConfig].
extension HintConfigPatterns on HintConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HintConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HintConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HintConfig value)  $default,){
final _that = this;
switch (_that) {
case _HintConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HintConfig value)?  $default,){
final _that = this;
switch (_that) {
case _HintConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HintBudget budget,  List<HintTypeConfig> types,  Map<String, int>? cooldownsSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HintConfig() when $default != null:
return $default(_that.budget,_that.types,_that.cooldownsSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HintBudget budget,  List<HintTypeConfig> types,  Map<String, int>? cooldownsSec)  $default,) {final _that = this;
switch (_that) {
case _HintConfig():
return $default(_that.budget,_that.types,_that.cooldownsSec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HintBudget budget,  List<HintTypeConfig> types,  Map<String, int>? cooldownsSec)?  $default,) {final _that = this;
switch (_that) {
case _HintConfig() when $default != null:
return $default(_that.budget,_that.types,_that.cooldownsSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HintConfig implements HintConfig {
  const _HintConfig({this.budget = const HintBudget(), final  List<HintTypeConfig> types = const <HintTypeConfig>[], final  Map<String, int>? cooldownsSec}): _types = types,_cooldownsSec = cooldownsSec;
  factory _HintConfig.fromJson(Map<String, dynamic> json) => _$HintConfigFromJson(json);

@override@JsonKey() final  HintBudget budget;
 final  List<HintTypeConfig> _types;
@override@JsonKey() List<HintTypeConfig> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

 final  Map<String, int>? _cooldownsSec;
@override Map<String, int>? get cooldownsSec {
  final value = _cooldownsSec;
  if (value == null) return null;
  if (_cooldownsSec is EqualUnmodifiableMapView) return _cooldownsSec;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of HintConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintConfigCopyWith<_HintConfig> get copyWith => __$HintConfigCopyWithImpl<_HintConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HintConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintConfig&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other._types, _types)&&const DeepCollectionEquality().equals(other._cooldownsSec, _cooldownsSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budget,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_cooldownsSec));

@override
String toString() {
  return 'HintConfig(budget: $budget, types: $types, cooldownsSec: $cooldownsSec)';
}


}

/// @nodoc
abstract mixin class _$HintConfigCopyWith<$Res> implements $HintConfigCopyWith<$Res> {
  factory _$HintConfigCopyWith(_HintConfig value, $Res Function(_HintConfig) _then) = __$HintConfigCopyWithImpl;
@override @useResult
$Res call({
 HintBudget budget, List<HintTypeConfig> types, Map<String, int>? cooldownsSec
});


@override $HintBudgetCopyWith<$Res> get budget;

}
/// @nodoc
class __$HintConfigCopyWithImpl<$Res>
    implements _$HintConfigCopyWith<$Res> {
  __$HintConfigCopyWithImpl(this._self, this._then);

  final _HintConfig _self;
  final $Res Function(_HintConfig) _then;

/// Create a copy of HintConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? budget = null,Object? types = null,Object? cooldownsSec = freezed,}) {
  return _then(_HintConfig(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as HintBudget,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<HintTypeConfig>,cooldownsSec: freezed == cooldownsSec ? _self._cooldownsSec : cooldownsSec // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}

/// Create a copy of HintConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HintBudgetCopyWith<$Res> get budget {
  
  return $HintBudgetCopyWith<$Res>(_self.budget, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}


/// @nodoc
mixin _$HintBudget {

 int get perPuzzle; int? get perRun;
/// Create a copy of HintBudget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintBudgetCopyWith<HintBudget> get copyWith => _$HintBudgetCopyWithImpl<HintBudget>(this as HintBudget, _$identity);

  /// Serializes this HintBudget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintBudget&&(identical(other.perPuzzle, perPuzzle) || other.perPuzzle == perPuzzle)&&(identical(other.perRun, perRun) || other.perRun == perRun));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,perPuzzle,perRun);

@override
String toString() {
  return 'HintBudget(perPuzzle: $perPuzzle, perRun: $perRun)';
}


}

/// @nodoc
abstract mixin class $HintBudgetCopyWith<$Res>  {
  factory $HintBudgetCopyWith(HintBudget value, $Res Function(HintBudget) _then) = _$HintBudgetCopyWithImpl;
@useResult
$Res call({
 int perPuzzle, int? perRun
});




}
/// @nodoc
class _$HintBudgetCopyWithImpl<$Res>
    implements $HintBudgetCopyWith<$Res> {
  _$HintBudgetCopyWithImpl(this._self, this._then);

  final HintBudget _self;
  final $Res Function(HintBudget) _then;

/// Create a copy of HintBudget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? perPuzzle = null,Object? perRun = freezed,}) {
  return _then(_self.copyWith(
perPuzzle: null == perPuzzle ? _self.perPuzzle : perPuzzle // ignore: cast_nullable_to_non_nullable
as int,perRun: freezed == perRun ? _self.perRun : perRun // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [HintBudget].
extension HintBudgetPatterns on HintBudget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HintBudget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HintBudget() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HintBudget value)  $default,){
final _that = this;
switch (_that) {
case _HintBudget():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HintBudget value)?  $default,){
final _that = this;
switch (_that) {
case _HintBudget() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int perPuzzle,  int? perRun)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HintBudget() when $default != null:
return $default(_that.perPuzzle,_that.perRun);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int perPuzzle,  int? perRun)  $default,) {final _that = this;
switch (_that) {
case _HintBudget():
return $default(_that.perPuzzle,_that.perRun);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int perPuzzle,  int? perRun)?  $default,) {final _that = this;
switch (_that) {
case _HintBudget() when $default != null:
return $default(_that.perPuzzle,_that.perRun);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HintBudget implements HintBudget {
  const _HintBudget({this.perPuzzle = 0, this.perRun});
  factory _HintBudget.fromJson(Map<String, dynamic> json) => _$HintBudgetFromJson(json);

@override@JsonKey() final  int perPuzzle;
@override final  int? perRun;

/// Create a copy of HintBudget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintBudgetCopyWith<_HintBudget> get copyWith => __$HintBudgetCopyWithImpl<_HintBudget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HintBudgetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintBudget&&(identical(other.perPuzzle, perPuzzle) || other.perPuzzle == perPuzzle)&&(identical(other.perRun, perRun) || other.perRun == perRun));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,perPuzzle,perRun);

@override
String toString() {
  return 'HintBudget(perPuzzle: $perPuzzle, perRun: $perRun)';
}


}

/// @nodoc
abstract mixin class _$HintBudgetCopyWith<$Res> implements $HintBudgetCopyWith<$Res> {
  factory _$HintBudgetCopyWith(_HintBudget value, $Res Function(_HintBudget) _then) = __$HintBudgetCopyWithImpl;
@override @useResult
$Res call({
 int perPuzzle, int? perRun
});




}
/// @nodoc
class __$HintBudgetCopyWithImpl<$Res>
    implements _$HintBudgetCopyWith<$Res> {
  __$HintBudgetCopyWithImpl(this._self, this._then);

  final _HintBudget _self;
  final $Res Function(_HintBudget) _then;

/// Create a copy of HintBudget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? perPuzzle = null,Object? perRun = freezed,}) {
  return _then(_HintBudget(
perPuzzle: null == perPuzzle ? _self.perPuzzle : perPuzzle // ignore: cast_nullable_to_non_nullable
as int,perRun: freezed == perRun ? _self.perRun : perRun // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$HintTypeConfig {

 HintType get type; int get cost; JsonMap? get params;
/// Create a copy of HintTypeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintTypeConfigCopyWith<HintTypeConfig> get copyWith => _$HintTypeConfigCopyWithImpl<HintTypeConfig>(this as HintTypeConfig, _$identity);

  /// Serializes this HintTypeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintTypeConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.cost, cost) || other.cost == cost)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,cost,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'HintTypeConfig(type: $type, cost: $cost, params: $params)';
}


}

/// @nodoc
abstract mixin class $HintTypeConfigCopyWith<$Res>  {
  factory $HintTypeConfigCopyWith(HintTypeConfig value, $Res Function(HintTypeConfig) _then) = _$HintTypeConfigCopyWithImpl;
@useResult
$Res call({
 HintType type, int cost, JsonMap? params
});




}
/// @nodoc
class _$HintTypeConfigCopyWithImpl<$Res>
    implements $HintTypeConfigCopyWith<$Res> {
  _$HintTypeConfigCopyWithImpl(this._self, this._then);

  final HintTypeConfig _self;
  final $Res Function(HintTypeConfig) _then;

/// Create a copy of HintTypeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? cost = null,Object? params = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HintType,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}

}


/// Adds pattern-matching-related methods to [HintTypeConfig].
extension HintTypeConfigPatterns on HintTypeConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HintTypeConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HintTypeConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HintTypeConfig value)  $default,){
final _that = this;
switch (_that) {
case _HintTypeConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HintTypeConfig value)?  $default,){
final _that = this;
switch (_that) {
case _HintTypeConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HintType type,  int cost,  JsonMap? params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HintTypeConfig() when $default != null:
return $default(_that.type,_that.cost,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HintType type,  int cost,  JsonMap? params)  $default,) {final _that = this;
switch (_that) {
case _HintTypeConfig():
return $default(_that.type,_that.cost,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HintType type,  int cost,  JsonMap? params)?  $default,) {final _that = this;
switch (_that) {
case _HintTypeConfig() when $default != null:
return $default(_that.type,_that.cost,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HintTypeConfig implements HintTypeConfig {
  const _HintTypeConfig({required this.type, this.cost = 1, final  JsonMap? params}): _params = params;
  factory _HintTypeConfig.fromJson(Map<String, dynamic> json) => _$HintTypeConfigFromJson(json);

@override final  HintType type;
@override@JsonKey() final  int cost;
 final  JsonMap? _params;
@override JsonMap? get params {
  final value = _params;
  if (value == null) return null;
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of HintTypeConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintTypeConfigCopyWith<_HintTypeConfig> get copyWith => __$HintTypeConfigCopyWithImpl<_HintTypeConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HintTypeConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintTypeConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.cost, cost) || other.cost == cost)&&const DeepCollectionEquality().equals(other._params, _params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,cost,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'HintTypeConfig(type: $type, cost: $cost, params: $params)';
}


}

/// @nodoc
abstract mixin class _$HintTypeConfigCopyWith<$Res> implements $HintTypeConfigCopyWith<$Res> {
  factory _$HintTypeConfigCopyWith(_HintTypeConfig value, $Res Function(_HintTypeConfig) _then) = __$HintTypeConfigCopyWithImpl;
@override @useResult
$Res call({
 HintType type, int cost, JsonMap? params
});




}
/// @nodoc
class __$HintTypeConfigCopyWithImpl<$Res>
    implements _$HintTypeConfigCopyWith<$Res> {
  __$HintTypeConfigCopyWithImpl(this._self, this._then);

  final _HintTypeConfig _self;
  final $Res Function(_HintTypeConfig) _then;

/// Create a copy of HintTypeConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? cost = null,Object? params = freezed,}) {
  return _then(_HintTypeConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HintType,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,params: freezed == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as JsonMap?,
  ));
}


}


/// @nodoc
mixin _$ScoringConfig {

 bool? get enabled; ScoringEvents get events; ComboConfig? get combo; MedalsConfig? get medals;
/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoringConfigCopyWith<ScoringConfig> get copyWith => _$ScoringConfigCopyWithImpl<ScoringConfig>(this as ScoringConfig, _$identity);

  /// Serializes this ScoringConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoringConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.events, events) || other.events == events)&&(identical(other.combo, combo) || other.combo == combo)&&(identical(other.medals, medals) || other.medals == medals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,events,combo,medals);

@override
String toString() {
  return 'ScoringConfig(enabled: $enabled, events: $events, combo: $combo, medals: $medals)';
}


}

/// @nodoc
abstract mixin class $ScoringConfigCopyWith<$Res>  {
  factory $ScoringConfigCopyWith(ScoringConfig value, $Res Function(ScoringConfig) _then) = _$ScoringConfigCopyWithImpl;
@useResult
$Res call({
 bool? enabled, ScoringEvents events, ComboConfig? combo, MedalsConfig? medals
});


$ScoringEventsCopyWith<$Res> get events;$ComboConfigCopyWith<$Res>? get combo;$MedalsConfigCopyWith<$Res>? get medals;

}
/// @nodoc
class _$ScoringConfigCopyWithImpl<$Res>
    implements $ScoringConfigCopyWith<$Res> {
  _$ScoringConfigCopyWithImpl(this._self, this._then);

  final ScoringConfig _self;
  final $Res Function(ScoringConfig) _then;

/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? events = null,Object? combo = freezed,Object? medals = freezed,}) {
  return _then(_self.copyWith(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as ScoringEvents,combo: freezed == combo ? _self.combo : combo // ignore: cast_nullable_to_non_nullable
as ComboConfig?,medals: freezed == medals ? _self.medals : medals // ignore: cast_nullable_to_non_nullable
as MedalsConfig?,
  ));
}
/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoringEventsCopyWith<$Res> get events {
  
  return $ScoringEventsCopyWith<$Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComboConfigCopyWith<$Res>? get combo {
    if (_self.combo == null) {
    return null;
  }

  return $ComboConfigCopyWith<$Res>(_self.combo!, (value) {
    return _then(_self.copyWith(combo: value));
  });
}/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MedalsConfigCopyWith<$Res>? get medals {
    if (_self.medals == null) {
    return null;
  }

  return $MedalsConfigCopyWith<$Res>(_self.medals!, (value) {
    return _then(_self.copyWith(medals: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScoringConfig].
extension ScoringConfigPatterns on ScoringConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoringConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoringConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoringConfig value)  $default,){
final _that = this;
switch (_that) {
case _ScoringConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoringConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ScoringConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? enabled,  ScoringEvents events,  ComboConfig? combo,  MedalsConfig? medals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoringConfig() when $default != null:
return $default(_that.enabled,_that.events,_that.combo,_that.medals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? enabled,  ScoringEvents events,  ComboConfig? combo,  MedalsConfig? medals)  $default,) {final _that = this;
switch (_that) {
case _ScoringConfig():
return $default(_that.enabled,_that.events,_that.combo,_that.medals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? enabled,  ScoringEvents events,  ComboConfig? combo,  MedalsConfig? medals)?  $default,) {final _that = this;
switch (_that) {
case _ScoringConfig() when $default != null:
return $default(_that.enabled,_that.events,_that.combo,_that.medals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoringConfig implements ScoringConfig {
  const _ScoringConfig({this.enabled, this.events = const ScoringEvents(), this.combo, this.medals});
  factory _ScoringConfig.fromJson(Map<String, dynamic> json) => _$ScoringConfigFromJson(json);

@override final  bool? enabled;
@override@JsonKey() final  ScoringEvents events;
@override final  ComboConfig? combo;
@override final  MedalsConfig? medals;

/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoringConfigCopyWith<_ScoringConfig> get copyWith => __$ScoringConfigCopyWithImpl<_ScoringConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoringConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoringConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.events, events) || other.events == events)&&(identical(other.combo, combo) || other.combo == combo)&&(identical(other.medals, medals) || other.medals == medals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,events,combo,medals);

@override
String toString() {
  return 'ScoringConfig(enabled: $enabled, events: $events, combo: $combo, medals: $medals)';
}


}

/// @nodoc
abstract mixin class _$ScoringConfigCopyWith<$Res> implements $ScoringConfigCopyWith<$Res> {
  factory _$ScoringConfigCopyWith(_ScoringConfig value, $Res Function(_ScoringConfig) _then) = __$ScoringConfigCopyWithImpl;
@override @useResult
$Res call({
 bool? enabled, ScoringEvents events, ComboConfig? combo, MedalsConfig? medals
});


@override $ScoringEventsCopyWith<$Res> get events;@override $ComboConfigCopyWith<$Res>? get combo;@override $MedalsConfigCopyWith<$Res>? get medals;

}
/// @nodoc
class __$ScoringConfigCopyWithImpl<$Res>
    implements _$ScoringConfigCopyWith<$Res> {
  __$ScoringConfigCopyWithImpl(this._self, this._then);

  final _ScoringConfig _self;
  final $Res Function(_ScoringConfig) _then;

/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? events = null,Object? combo = freezed,Object? medals = freezed,}) {
  return _then(_ScoringConfig(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as ScoringEvents,combo: freezed == combo ? _self.combo : combo // ignore: cast_nullable_to_non_nullable
as ComboConfig?,medals: freezed == medals ? _self.medals : medals // ignore: cast_nullable_to_non_nullable
as MedalsConfig?,
  ));
}

/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoringEventsCopyWith<$Res> get events {
  
  return $ScoringEventsCopyWith<$Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComboConfigCopyWith<$Res>? get combo {
    if (_self.combo == null) {
    return null;
  }

  return $ComboConfigCopyWith<$Res>(_self.combo!, (value) {
    return _then(_self.copyWith(combo: value));
  });
}/// Create a copy of ScoringConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MedalsConfigCopyWith<$Res>? get medals {
    if (_self.medals == null) {
    return null;
  }

  return $MedalsConfigCopyWith<$Res>(_self.medals!, (value) {
    return _then(_self.copyWith(medals: value));
  });
}
}


/// @nodoc
mixin _$ScoringEvents {

 ScoreWordFound get wordFound; ScoreWrongSelection get wrongSelection; ScoreHintUsed get hintUsed;
/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoringEventsCopyWith<ScoringEvents> get copyWith => _$ScoringEventsCopyWithImpl<ScoringEvents>(this as ScoringEvents, _$identity);

  /// Serializes this ScoringEvents to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoringEvents&&(identical(other.wordFound, wordFound) || other.wordFound == wordFound)&&(identical(other.wrongSelection, wrongSelection) || other.wrongSelection == wrongSelection)&&(identical(other.hintUsed, hintUsed) || other.hintUsed == hintUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordFound,wrongSelection,hintUsed);

@override
String toString() {
  return 'ScoringEvents(wordFound: $wordFound, wrongSelection: $wrongSelection, hintUsed: $hintUsed)';
}


}

/// @nodoc
abstract mixin class $ScoringEventsCopyWith<$Res>  {
  factory $ScoringEventsCopyWith(ScoringEvents value, $Res Function(ScoringEvents) _then) = _$ScoringEventsCopyWithImpl;
@useResult
$Res call({
 ScoreWordFound wordFound, ScoreWrongSelection wrongSelection, ScoreHintUsed hintUsed
});


$ScoreWordFoundCopyWith<$Res> get wordFound;$ScoreWrongSelectionCopyWith<$Res> get wrongSelection;$ScoreHintUsedCopyWith<$Res> get hintUsed;

}
/// @nodoc
class _$ScoringEventsCopyWithImpl<$Res>
    implements $ScoringEventsCopyWith<$Res> {
  _$ScoringEventsCopyWithImpl(this._self, this._then);

  final ScoringEvents _self;
  final $Res Function(ScoringEvents) _then;

/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wordFound = null,Object? wrongSelection = null,Object? hintUsed = null,}) {
  return _then(_self.copyWith(
wordFound: null == wordFound ? _self.wordFound : wordFound // ignore: cast_nullable_to_non_nullable
as ScoreWordFound,wrongSelection: null == wrongSelection ? _self.wrongSelection : wrongSelection // ignore: cast_nullable_to_non_nullable
as ScoreWrongSelection,hintUsed: null == hintUsed ? _self.hintUsed : hintUsed // ignore: cast_nullable_to_non_nullable
as ScoreHintUsed,
  ));
}
/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreWordFoundCopyWith<$Res> get wordFound {
  
  return $ScoreWordFoundCopyWith<$Res>(_self.wordFound, (value) {
    return _then(_self.copyWith(wordFound: value));
  });
}/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreWrongSelectionCopyWith<$Res> get wrongSelection {
  
  return $ScoreWrongSelectionCopyWith<$Res>(_self.wrongSelection, (value) {
    return _then(_self.copyWith(wrongSelection: value));
  });
}/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreHintUsedCopyWith<$Res> get hintUsed {
  
  return $ScoreHintUsedCopyWith<$Res>(_self.hintUsed, (value) {
    return _then(_self.copyWith(hintUsed: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScoringEvents].
extension ScoringEventsPatterns on ScoringEvents {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoringEvents value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoringEvents() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoringEvents value)  $default,){
final _that = this;
switch (_that) {
case _ScoringEvents():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoringEvents value)?  $default,){
final _that = this;
switch (_that) {
case _ScoringEvents() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScoreWordFound wordFound,  ScoreWrongSelection wrongSelection,  ScoreHintUsed hintUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoringEvents() when $default != null:
return $default(_that.wordFound,_that.wrongSelection,_that.hintUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScoreWordFound wordFound,  ScoreWrongSelection wrongSelection,  ScoreHintUsed hintUsed)  $default,) {final _that = this;
switch (_that) {
case _ScoringEvents():
return $default(_that.wordFound,_that.wrongSelection,_that.hintUsed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScoreWordFound wordFound,  ScoreWrongSelection wrongSelection,  ScoreHintUsed hintUsed)?  $default,) {final _that = this;
switch (_that) {
case _ScoringEvents() when $default != null:
return $default(_that.wordFound,_that.wrongSelection,_that.hintUsed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoringEvents implements ScoringEvents {
  const _ScoringEvents({this.wordFound = const ScoreWordFound(), this.wrongSelection = const ScoreWrongSelection(), this.hintUsed = const ScoreHintUsed()});
  factory _ScoringEvents.fromJson(Map<String, dynamic> json) => _$ScoringEventsFromJson(json);

@override@JsonKey() final  ScoreWordFound wordFound;
@override@JsonKey() final  ScoreWrongSelection wrongSelection;
@override@JsonKey() final  ScoreHintUsed hintUsed;

/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoringEventsCopyWith<_ScoringEvents> get copyWith => __$ScoringEventsCopyWithImpl<_ScoringEvents>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoringEventsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoringEvents&&(identical(other.wordFound, wordFound) || other.wordFound == wordFound)&&(identical(other.wrongSelection, wrongSelection) || other.wrongSelection == wrongSelection)&&(identical(other.hintUsed, hintUsed) || other.hintUsed == hintUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordFound,wrongSelection,hintUsed);

@override
String toString() {
  return 'ScoringEvents(wordFound: $wordFound, wrongSelection: $wrongSelection, hintUsed: $hintUsed)';
}


}

/// @nodoc
abstract mixin class _$ScoringEventsCopyWith<$Res> implements $ScoringEventsCopyWith<$Res> {
  factory _$ScoringEventsCopyWith(_ScoringEvents value, $Res Function(_ScoringEvents) _then) = __$ScoringEventsCopyWithImpl;
@override @useResult
$Res call({
 ScoreWordFound wordFound, ScoreWrongSelection wrongSelection, ScoreHintUsed hintUsed
});


@override $ScoreWordFoundCopyWith<$Res> get wordFound;@override $ScoreWrongSelectionCopyWith<$Res> get wrongSelection;@override $ScoreHintUsedCopyWith<$Res> get hintUsed;

}
/// @nodoc
class __$ScoringEventsCopyWithImpl<$Res>
    implements _$ScoringEventsCopyWith<$Res> {
  __$ScoringEventsCopyWithImpl(this._self, this._then);

  final _ScoringEvents _self;
  final $Res Function(_ScoringEvents) _then;

/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wordFound = null,Object? wrongSelection = null,Object? hintUsed = null,}) {
  return _then(_ScoringEvents(
wordFound: null == wordFound ? _self.wordFound : wordFound // ignore: cast_nullable_to_non_nullable
as ScoreWordFound,wrongSelection: null == wrongSelection ? _self.wrongSelection : wrongSelection // ignore: cast_nullable_to_non_nullable
as ScoreWrongSelection,hintUsed: null == hintUsed ? _self.hintUsed : hintUsed // ignore: cast_nullable_to_non_nullable
as ScoreHintUsed,
  ));
}

/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreWordFoundCopyWith<$Res> get wordFound {
  
  return $ScoreWordFoundCopyWith<$Res>(_self.wordFound, (value) {
    return _then(_self.copyWith(wordFound: value));
  });
}/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreWrongSelectionCopyWith<$Res> get wrongSelection {
  
  return $ScoreWrongSelectionCopyWith<$Res>(_self.wrongSelection, (value) {
    return _then(_self.copyWith(wrongSelection: value));
  });
}/// Create a copy of ScoringEvents
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreHintUsedCopyWith<$Res> get hintUsed {
  
  return $ScoreHintUsedCopyWith<$Res>(_self.hintUsed, (value) {
    return _then(_self.copyWith(hintUsed: value));
  });
}
}


/// @nodoc
mixin _$ScoreWordFound {

 int get base; int get perChar; Map<String, int>? get byTagBonus;
/// Create a copy of ScoreWordFound
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreWordFoundCopyWith<ScoreWordFound> get copyWith => _$ScoreWordFoundCopyWithImpl<ScoreWordFound>(this as ScoreWordFound, _$identity);

  /// Serializes this ScoreWordFound to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreWordFound&&(identical(other.base, base) || other.base == base)&&(identical(other.perChar, perChar) || other.perChar == perChar)&&const DeepCollectionEquality().equals(other.byTagBonus, byTagBonus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,base,perChar,const DeepCollectionEquality().hash(byTagBonus));

@override
String toString() {
  return 'ScoreWordFound(base: $base, perChar: $perChar, byTagBonus: $byTagBonus)';
}


}

/// @nodoc
abstract mixin class $ScoreWordFoundCopyWith<$Res>  {
  factory $ScoreWordFoundCopyWith(ScoreWordFound value, $Res Function(ScoreWordFound) _then) = _$ScoreWordFoundCopyWithImpl;
@useResult
$Res call({
 int base, int perChar, Map<String, int>? byTagBonus
});




}
/// @nodoc
class _$ScoreWordFoundCopyWithImpl<$Res>
    implements $ScoreWordFoundCopyWith<$Res> {
  _$ScoreWordFoundCopyWithImpl(this._self, this._then);

  final ScoreWordFound _self;
  final $Res Function(ScoreWordFound) _then;

/// Create a copy of ScoreWordFound
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? base = null,Object? perChar = null,Object? byTagBonus = freezed,}) {
  return _then(_self.copyWith(
base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as int,perChar: null == perChar ? _self.perChar : perChar // ignore: cast_nullable_to_non_nullable
as int,byTagBonus: freezed == byTagBonus ? _self.byTagBonus : byTagBonus // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreWordFound].
extension ScoreWordFoundPatterns on ScoreWordFound {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreWordFound value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreWordFound() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreWordFound value)  $default,){
final _that = this;
switch (_that) {
case _ScoreWordFound():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreWordFound value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreWordFound() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int base,  int perChar,  Map<String, int>? byTagBonus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreWordFound() when $default != null:
return $default(_that.base,_that.perChar,_that.byTagBonus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int base,  int perChar,  Map<String, int>? byTagBonus)  $default,) {final _that = this;
switch (_that) {
case _ScoreWordFound():
return $default(_that.base,_that.perChar,_that.byTagBonus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int base,  int perChar,  Map<String, int>? byTagBonus)?  $default,) {final _that = this;
switch (_that) {
case _ScoreWordFound() when $default != null:
return $default(_that.base,_that.perChar,_that.byTagBonus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreWordFound implements ScoreWordFound {
  const _ScoreWordFound({this.base = 100, this.perChar = 0, final  Map<String, int>? byTagBonus}): _byTagBonus = byTagBonus;
  factory _ScoreWordFound.fromJson(Map<String, dynamic> json) => _$ScoreWordFoundFromJson(json);

@override@JsonKey() final  int base;
@override@JsonKey() final  int perChar;
 final  Map<String, int>? _byTagBonus;
@override Map<String, int>? get byTagBonus {
  final value = _byTagBonus;
  if (value == null) return null;
  if (_byTagBonus is EqualUnmodifiableMapView) return _byTagBonus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ScoreWordFound
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreWordFoundCopyWith<_ScoreWordFound> get copyWith => __$ScoreWordFoundCopyWithImpl<_ScoreWordFound>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreWordFoundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreWordFound&&(identical(other.base, base) || other.base == base)&&(identical(other.perChar, perChar) || other.perChar == perChar)&&const DeepCollectionEquality().equals(other._byTagBonus, _byTagBonus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,base,perChar,const DeepCollectionEquality().hash(_byTagBonus));

@override
String toString() {
  return 'ScoreWordFound(base: $base, perChar: $perChar, byTagBonus: $byTagBonus)';
}


}

/// @nodoc
abstract mixin class _$ScoreWordFoundCopyWith<$Res> implements $ScoreWordFoundCopyWith<$Res> {
  factory _$ScoreWordFoundCopyWith(_ScoreWordFound value, $Res Function(_ScoreWordFound) _then) = __$ScoreWordFoundCopyWithImpl;
@override @useResult
$Res call({
 int base, int perChar, Map<String, int>? byTagBonus
});




}
/// @nodoc
class __$ScoreWordFoundCopyWithImpl<$Res>
    implements _$ScoreWordFoundCopyWith<$Res> {
  __$ScoreWordFoundCopyWithImpl(this._self, this._then);

  final _ScoreWordFound _self;
  final $Res Function(_ScoreWordFound) _then;

/// Create a copy of ScoreWordFound
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? base = null,Object? perChar = null,Object? byTagBonus = freezed,}) {
  return _then(_ScoreWordFound(
base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as int,perChar: null == perChar ? _self.perChar : perChar // ignore: cast_nullable_to_non_nullable
as int,byTagBonus: freezed == byTagBonus ? _self._byTagBonus : byTagBonus // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}


}


/// @nodoc
mixin _$ScoreWrongSelection {

 int get delta;
/// Create a copy of ScoreWrongSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreWrongSelectionCopyWith<ScoreWrongSelection> get copyWith => _$ScoreWrongSelectionCopyWithImpl<ScoreWrongSelection>(this as ScoreWrongSelection, _$identity);

  /// Serializes this ScoreWrongSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreWrongSelection&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'ScoreWrongSelection(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $ScoreWrongSelectionCopyWith<$Res>  {
  factory $ScoreWrongSelectionCopyWith(ScoreWrongSelection value, $Res Function(ScoreWrongSelection) _then) = _$ScoreWrongSelectionCopyWithImpl;
@useResult
$Res call({
 int delta
});




}
/// @nodoc
class _$ScoreWrongSelectionCopyWithImpl<$Res>
    implements $ScoreWrongSelectionCopyWith<$Res> {
  _$ScoreWrongSelectionCopyWithImpl(this._self, this._then);

  final ScoreWrongSelection _self;
  final $Res Function(ScoreWrongSelection) _then;

/// Create a copy of ScoreWrongSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = null,}) {
  return _then(_self.copyWith(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreWrongSelection].
extension ScoreWrongSelectionPatterns on ScoreWrongSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreWrongSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreWrongSelection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreWrongSelection value)  $default,){
final _that = this;
switch (_that) {
case _ScoreWrongSelection():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreWrongSelection value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreWrongSelection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreWrongSelection() when $default != null:
return $default(_that.delta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int delta)  $default,) {final _that = this;
switch (_that) {
case _ScoreWrongSelection():
return $default(_that.delta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int delta)?  $default,) {final _that = this;
switch (_that) {
case _ScoreWrongSelection() when $default != null:
return $default(_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreWrongSelection implements ScoreWrongSelection {
  const _ScoreWrongSelection({this.delta = 0});
  factory _ScoreWrongSelection.fromJson(Map<String, dynamic> json) => _$ScoreWrongSelectionFromJson(json);

@override@JsonKey() final  int delta;

/// Create a copy of ScoreWrongSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreWrongSelectionCopyWith<_ScoreWrongSelection> get copyWith => __$ScoreWrongSelectionCopyWithImpl<_ScoreWrongSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreWrongSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreWrongSelection&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'ScoreWrongSelection(delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$ScoreWrongSelectionCopyWith<$Res> implements $ScoreWrongSelectionCopyWith<$Res> {
  factory _$ScoreWrongSelectionCopyWith(_ScoreWrongSelection value, $Res Function(_ScoreWrongSelection) _then) = __$ScoreWrongSelectionCopyWithImpl;
@override @useResult
$Res call({
 int delta
});




}
/// @nodoc
class __$ScoreWrongSelectionCopyWithImpl<$Res>
    implements _$ScoreWrongSelectionCopyWith<$Res> {
  __$ScoreWrongSelectionCopyWithImpl(this._self, this._then);

  final _ScoreWrongSelection _self;
  final $Res Function(_ScoreWrongSelection) _then;

/// Create a copy of ScoreWrongSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(_ScoreWrongSelection(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ScoreHintUsed {

 int get delta;
/// Create a copy of ScoreHintUsed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreHintUsedCopyWith<ScoreHintUsed> get copyWith => _$ScoreHintUsedCopyWithImpl<ScoreHintUsed>(this as ScoreHintUsed, _$identity);

  /// Serializes this ScoreHintUsed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreHintUsed&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'ScoreHintUsed(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $ScoreHintUsedCopyWith<$Res>  {
  factory $ScoreHintUsedCopyWith(ScoreHintUsed value, $Res Function(ScoreHintUsed) _then) = _$ScoreHintUsedCopyWithImpl;
@useResult
$Res call({
 int delta
});




}
/// @nodoc
class _$ScoreHintUsedCopyWithImpl<$Res>
    implements $ScoreHintUsedCopyWith<$Res> {
  _$ScoreHintUsedCopyWithImpl(this._self, this._then);

  final ScoreHintUsed _self;
  final $Res Function(ScoreHintUsed) _then;

/// Create a copy of ScoreHintUsed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = null,}) {
  return _then(_self.copyWith(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreHintUsed].
extension ScoreHintUsedPatterns on ScoreHintUsed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreHintUsed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreHintUsed() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreHintUsed value)  $default,){
final _that = this;
switch (_that) {
case _ScoreHintUsed():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreHintUsed value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreHintUsed() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreHintUsed() when $default != null:
return $default(_that.delta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int delta)  $default,) {final _that = this;
switch (_that) {
case _ScoreHintUsed():
return $default(_that.delta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int delta)?  $default,) {final _that = this;
switch (_that) {
case _ScoreHintUsed() when $default != null:
return $default(_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreHintUsed implements ScoreHintUsed {
  const _ScoreHintUsed({this.delta = 0});
  factory _ScoreHintUsed.fromJson(Map<String, dynamic> json) => _$ScoreHintUsedFromJson(json);

@override@JsonKey() final  int delta;

/// Create a copy of ScoreHintUsed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreHintUsedCopyWith<_ScoreHintUsed> get copyWith => __$ScoreHintUsedCopyWithImpl<_ScoreHintUsed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreHintUsedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreHintUsed&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'ScoreHintUsed(delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$ScoreHintUsedCopyWith<$Res> implements $ScoreHintUsedCopyWith<$Res> {
  factory _$ScoreHintUsedCopyWith(_ScoreHintUsed value, $Res Function(_ScoreHintUsed) _then) = __$ScoreHintUsedCopyWithImpl;
@override @useResult
$Res call({
 int delta
});




}
/// @nodoc
class __$ScoreHintUsedCopyWithImpl<$Res>
    implements _$ScoreHintUsedCopyWith<$Res> {
  __$ScoreHintUsedCopyWithImpl(this._self, this._then);

  final _ScoreHintUsed _self;
  final $Res Function(_ScoreHintUsed) _then;

/// Create a copy of ScoreHintUsed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(_ScoreHintUsed(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ComboConfig {

 bool get enabled; int? get windowMs; int? get step; int? get max;
/// Create a copy of ComboConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComboConfigCopyWith<ComboConfig> get copyWith => _$ComboConfigCopyWithImpl<ComboConfig>(this as ComboConfig, _$identity);

  /// Serializes this ComboConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComboConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.windowMs, windowMs) || other.windowMs == windowMs)&&(identical(other.step, step) || other.step == step)&&(identical(other.max, max) || other.max == max));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,windowMs,step,max);

@override
String toString() {
  return 'ComboConfig(enabled: $enabled, windowMs: $windowMs, step: $step, max: $max)';
}


}

/// @nodoc
abstract mixin class $ComboConfigCopyWith<$Res>  {
  factory $ComboConfigCopyWith(ComboConfig value, $Res Function(ComboConfig) _then) = _$ComboConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, int? windowMs, int? step, int? max
});




}
/// @nodoc
class _$ComboConfigCopyWithImpl<$Res>
    implements $ComboConfigCopyWith<$Res> {
  _$ComboConfigCopyWithImpl(this._self, this._then);

  final ComboConfig _self;
  final $Res Function(ComboConfig) _then;

/// Create a copy of ComboConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? windowMs = freezed,Object? step = freezed,Object? max = freezed,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,windowMs: freezed == windowMs ? _self.windowMs : windowMs // ignore: cast_nullable_to_non_nullable
as int?,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComboConfig].
extension ComboConfigPatterns on ComboConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComboConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComboConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComboConfig value)  $default,){
final _that = this;
switch (_that) {
case _ComboConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComboConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ComboConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int? windowMs,  int? step,  int? max)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComboConfig() when $default != null:
return $default(_that.enabled,_that.windowMs,_that.step,_that.max);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int? windowMs,  int? step,  int? max)  $default,) {final _that = this;
switch (_that) {
case _ComboConfig():
return $default(_that.enabled,_that.windowMs,_that.step,_that.max);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int? windowMs,  int? step,  int? max)?  $default,) {final _that = this;
switch (_that) {
case _ComboConfig() when $default != null:
return $default(_that.enabled,_that.windowMs,_that.step,_that.max);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComboConfig implements ComboConfig {
  const _ComboConfig({this.enabled = false, this.windowMs, this.step, this.max});
  factory _ComboConfig.fromJson(Map<String, dynamic> json) => _$ComboConfigFromJson(json);

@override@JsonKey() final  bool enabled;
@override final  int? windowMs;
@override final  int? step;
@override final  int? max;

/// Create a copy of ComboConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComboConfigCopyWith<_ComboConfig> get copyWith => __$ComboConfigCopyWithImpl<_ComboConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComboConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComboConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.windowMs, windowMs) || other.windowMs == windowMs)&&(identical(other.step, step) || other.step == step)&&(identical(other.max, max) || other.max == max));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,windowMs,step,max);

@override
String toString() {
  return 'ComboConfig(enabled: $enabled, windowMs: $windowMs, step: $step, max: $max)';
}


}

/// @nodoc
abstract mixin class _$ComboConfigCopyWith<$Res> implements $ComboConfigCopyWith<$Res> {
  factory _$ComboConfigCopyWith(_ComboConfig value, $Res Function(_ComboConfig) _then) = __$ComboConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int? windowMs, int? step, int? max
});




}
/// @nodoc
class __$ComboConfigCopyWithImpl<$Res>
    implements _$ComboConfigCopyWith<$Res> {
  __$ComboConfigCopyWithImpl(this._self, this._then);

  final _ComboConfig _self;
  final $Res Function(_ComboConfig) _then;

/// Create a copy of ComboConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? windowMs = freezed,Object? step = freezed,Object? max = freezed,}) {
  return _then(_ComboConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,windowMs: freezed == windowMs ? _self.windowMs : windowMs // ignore: cast_nullable_to_non_nullable
as int?,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MedalsConfig {

 int? get bronze; int? get silver; int? get gold;
/// Create a copy of MedalsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedalsConfigCopyWith<MedalsConfig> get copyWith => _$MedalsConfigCopyWithImpl<MedalsConfig>(this as MedalsConfig, _$identity);

  /// Serializes this MedalsConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedalsConfig&&(identical(other.bronze, bronze) || other.bronze == bronze)&&(identical(other.silver, silver) || other.silver == silver)&&(identical(other.gold, gold) || other.gold == gold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bronze,silver,gold);

@override
String toString() {
  return 'MedalsConfig(bronze: $bronze, silver: $silver, gold: $gold)';
}


}

/// @nodoc
abstract mixin class $MedalsConfigCopyWith<$Res>  {
  factory $MedalsConfigCopyWith(MedalsConfig value, $Res Function(MedalsConfig) _then) = _$MedalsConfigCopyWithImpl;
@useResult
$Res call({
 int? bronze, int? silver, int? gold
});




}
/// @nodoc
class _$MedalsConfigCopyWithImpl<$Res>
    implements $MedalsConfigCopyWith<$Res> {
  _$MedalsConfigCopyWithImpl(this._self, this._then);

  final MedalsConfig _self;
  final $Res Function(MedalsConfig) _then;

/// Create a copy of MedalsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bronze = freezed,Object? silver = freezed,Object? gold = freezed,}) {
  return _then(_self.copyWith(
bronze: freezed == bronze ? _self.bronze : bronze // ignore: cast_nullable_to_non_nullable
as int?,silver: freezed == silver ? _self.silver : silver // ignore: cast_nullable_to_non_nullable
as int?,gold: freezed == gold ? _self.gold : gold // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedalsConfig].
extension MedalsConfigPatterns on MedalsConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedalsConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedalsConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedalsConfig value)  $default,){
final _that = this;
switch (_that) {
case _MedalsConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedalsConfig value)?  $default,){
final _that = this;
switch (_that) {
case _MedalsConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? bronze,  int? silver,  int? gold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedalsConfig() when $default != null:
return $default(_that.bronze,_that.silver,_that.gold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? bronze,  int? silver,  int? gold)  $default,) {final _that = this;
switch (_that) {
case _MedalsConfig():
return $default(_that.bronze,_that.silver,_that.gold);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? bronze,  int? silver,  int? gold)?  $default,) {final _that = this;
switch (_that) {
case _MedalsConfig() when $default != null:
return $default(_that.bronze,_that.silver,_that.gold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedalsConfig implements MedalsConfig {
  const _MedalsConfig({this.bronze, this.silver, this.gold});
  factory _MedalsConfig.fromJson(Map<String, dynamic> json) => _$MedalsConfigFromJson(json);

@override final  int? bronze;
@override final  int? silver;
@override final  int? gold;

/// Create a copy of MedalsConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedalsConfigCopyWith<_MedalsConfig> get copyWith => __$MedalsConfigCopyWithImpl<_MedalsConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedalsConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedalsConfig&&(identical(other.bronze, bronze) || other.bronze == bronze)&&(identical(other.silver, silver) || other.silver == silver)&&(identical(other.gold, gold) || other.gold == gold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bronze,silver,gold);

@override
String toString() {
  return 'MedalsConfig(bronze: $bronze, silver: $silver, gold: $gold)';
}


}

/// @nodoc
abstract mixin class _$MedalsConfigCopyWith<$Res> implements $MedalsConfigCopyWith<$Res> {
  factory _$MedalsConfigCopyWith(_MedalsConfig value, $Res Function(_MedalsConfig) _then) = __$MedalsConfigCopyWithImpl;
@override @useResult
$Res call({
 int? bronze, int? silver, int? gold
});




}
/// @nodoc
class __$MedalsConfigCopyWithImpl<$Res>
    implements _$MedalsConfigCopyWith<$Res> {
  __$MedalsConfigCopyWithImpl(this._self, this._then);

  final _MedalsConfig _self;
  final $Res Function(_MedalsConfig) _then;

/// Create a copy of MedalsConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bronze = freezed,Object? silver = freezed,Object? gold = freezed,}) {
  return _then(_MedalsConfig(
bronze: freezed == bronze ? _self.bronze : bronze // ignore: cast_nullable_to_non_nullable
as int?,silver: freezed == silver ? _self.silver : silver // ignore: cast_nullable_to_non_nullable
as int?,gold: freezed == gold ? _self.gold : gold // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$UIConfig {

 bool get showWordList; WordListMode get wordListMode; bool get showRemainingCount; bool? get showTimer; bool? get showScore; bool get showMistakes; bool? get showHints;
/// Create a copy of UIConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIConfigCopyWith<UIConfig> get copyWith => _$UIConfigCopyWithImpl<UIConfig>(this as UIConfig, _$identity);

  /// Serializes this UIConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIConfig&&(identical(other.showWordList, showWordList) || other.showWordList == showWordList)&&(identical(other.wordListMode, wordListMode) || other.wordListMode == wordListMode)&&(identical(other.showRemainingCount, showRemainingCount) || other.showRemainingCount == showRemainingCount)&&(identical(other.showTimer, showTimer) || other.showTimer == showTimer)&&(identical(other.showScore, showScore) || other.showScore == showScore)&&(identical(other.showMistakes, showMistakes) || other.showMistakes == showMistakes)&&(identical(other.showHints, showHints) || other.showHints == showHints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showWordList,wordListMode,showRemainingCount,showTimer,showScore,showMistakes,showHints);

@override
String toString() {
  return 'UIConfig(showWordList: $showWordList, wordListMode: $wordListMode, showRemainingCount: $showRemainingCount, showTimer: $showTimer, showScore: $showScore, showMistakes: $showMistakes, showHints: $showHints)';
}


}

/// @nodoc
abstract mixin class $UIConfigCopyWith<$Res>  {
  factory $UIConfigCopyWith(UIConfig value, $Res Function(UIConfig) _then) = _$UIConfigCopyWithImpl;
@useResult
$Res call({
 bool showWordList, WordListMode wordListMode, bool showRemainingCount, bool? showTimer, bool? showScore, bool showMistakes, bool? showHints
});




}
/// @nodoc
class _$UIConfigCopyWithImpl<$Res>
    implements $UIConfigCopyWith<$Res> {
  _$UIConfigCopyWithImpl(this._self, this._then);

  final UIConfig _self;
  final $Res Function(UIConfig) _then;

/// Create a copy of UIConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showWordList = null,Object? wordListMode = null,Object? showRemainingCount = null,Object? showTimer = freezed,Object? showScore = freezed,Object? showMistakes = null,Object? showHints = freezed,}) {
  return _then(_self.copyWith(
showWordList: null == showWordList ? _self.showWordList : showWordList // ignore: cast_nullable_to_non_nullable
as bool,wordListMode: null == wordListMode ? _self.wordListMode : wordListMode // ignore: cast_nullable_to_non_nullable
as WordListMode,showRemainingCount: null == showRemainingCount ? _self.showRemainingCount : showRemainingCount // ignore: cast_nullable_to_non_nullable
as bool,showTimer: freezed == showTimer ? _self.showTimer : showTimer // ignore: cast_nullable_to_non_nullable
as bool?,showScore: freezed == showScore ? _self.showScore : showScore // ignore: cast_nullable_to_non_nullable
as bool?,showMistakes: null == showMistakes ? _self.showMistakes : showMistakes // ignore: cast_nullable_to_non_nullable
as bool,showHints: freezed == showHints ? _self.showHints : showHints // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UIConfig].
extension UIConfigPatterns on UIConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UIConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UIConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UIConfig value)  $default,){
final _that = this;
switch (_that) {
case _UIConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UIConfig value)?  $default,){
final _that = this;
switch (_that) {
case _UIConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showWordList,  WordListMode wordListMode,  bool showRemainingCount,  bool? showTimer,  bool? showScore,  bool showMistakes,  bool? showHints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UIConfig() when $default != null:
return $default(_that.showWordList,_that.wordListMode,_that.showRemainingCount,_that.showTimer,_that.showScore,_that.showMistakes,_that.showHints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showWordList,  WordListMode wordListMode,  bool showRemainingCount,  bool? showTimer,  bool? showScore,  bool showMistakes,  bool? showHints)  $default,) {final _that = this;
switch (_that) {
case _UIConfig():
return $default(_that.showWordList,_that.wordListMode,_that.showRemainingCount,_that.showTimer,_that.showScore,_that.showMistakes,_that.showHints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showWordList,  WordListMode wordListMode,  bool showRemainingCount,  bool? showTimer,  bool? showScore,  bool showMistakes,  bool? showHints)?  $default,) {final _that = this;
switch (_that) {
case _UIConfig() when $default != null:
return $default(_that.showWordList,_that.wordListMode,_that.showRemainingCount,_that.showTimer,_that.showScore,_that.showMistakes,_that.showHints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UIConfig implements UIConfig {
  const _UIConfig({this.showWordList = true, this.wordListMode = WordListMode.full, this.showRemainingCount = true, this.showTimer, this.showScore, this.showMistakes = true, this.showHints});
  factory _UIConfig.fromJson(Map<String, dynamic> json) => _$UIConfigFromJson(json);

@override@JsonKey() final  bool showWordList;
@override@JsonKey() final  WordListMode wordListMode;
@override@JsonKey() final  bool showRemainingCount;
@override final  bool? showTimer;
@override final  bool? showScore;
@override@JsonKey() final  bool showMistakes;
@override final  bool? showHints;

/// Create a copy of UIConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UIConfigCopyWith<_UIConfig> get copyWith => __$UIConfigCopyWithImpl<_UIConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UIConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UIConfig&&(identical(other.showWordList, showWordList) || other.showWordList == showWordList)&&(identical(other.wordListMode, wordListMode) || other.wordListMode == wordListMode)&&(identical(other.showRemainingCount, showRemainingCount) || other.showRemainingCount == showRemainingCount)&&(identical(other.showTimer, showTimer) || other.showTimer == showTimer)&&(identical(other.showScore, showScore) || other.showScore == showScore)&&(identical(other.showMistakes, showMistakes) || other.showMistakes == showMistakes)&&(identical(other.showHints, showHints) || other.showHints == showHints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showWordList,wordListMode,showRemainingCount,showTimer,showScore,showMistakes,showHints);

@override
String toString() {
  return 'UIConfig(showWordList: $showWordList, wordListMode: $wordListMode, showRemainingCount: $showRemainingCount, showTimer: $showTimer, showScore: $showScore, showMistakes: $showMistakes, showHints: $showHints)';
}


}

/// @nodoc
abstract mixin class _$UIConfigCopyWith<$Res> implements $UIConfigCopyWith<$Res> {
  factory _$UIConfigCopyWith(_UIConfig value, $Res Function(_UIConfig) _then) = __$UIConfigCopyWithImpl;
@override @useResult
$Res call({
 bool showWordList, WordListMode wordListMode, bool showRemainingCount, bool? showTimer, bool? showScore, bool showMistakes, bool? showHints
});




}
/// @nodoc
class __$UIConfigCopyWithImpl<$Res>
    implements _$UIConfigCopyWith<$Res> {
  __$UIConfigCopyWithImpl(this._self, this._then);

  final _UIConfig _self;
  final $Res Function(_UIConfig) _then;

/// Create a copy of UIConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showWordList = null,Object? wordListMode = null,Object? showRemainingCount = null,Object? showTimer = freezed,Object? showScore = freezed,Object? showMistakes = null,Object? showHints = freezed,}) {
  return _then(_UIConfig(
showWordList: null == showWordList ? _self.showWordList : showWordList // ignore: cast_nullable_to_non_nullable
as bool,wordListMode: null == wordListMode ? _self.wordListMode : wordListMode // ignore: cast_nullable_to_non_nullable
as WordListMode,showRemainingCount: null == showRemainingCount ? _self.showRemainingCount : showRemainingCount // ignore: cast_nullable_to_non_nullable
as bool,showTimer: freezed == showTimer ? _self.showTimer : showTimer // ignore: cast_nullable_to_non_nullable
as bool?,showScore: freezed == showScore ? _self.showScore : showScore // ignore: cast_nullable_to_non_nullable
as bool?,showMistakes: null == showMistakes ? _self.showMistakes : showMistakes // ignore: cast_nullable_to_non_nullable
as bool,showHints: freezed == showHints ? _self.showHints : showHints // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

Modifier _$ModifierFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'fog':
          return ModifierFog.fromJson(
            json
          );
                case 'locked_cells':
          return ModifierLockedCells.fromJson(
            json
          );
                case 'portals':
          return ModifierPortals.fromJson(
            json
          );
                case 'ice_slide':
          return ModifierIceSlide.fromJson(
            json
          );
                case 'error_time_penalty':
          return ModifierErrorTimePenalty.fromJson(
            json
          );
                case 'hint_cooldown_override':
          return ModifierHintCooldownOverride.fromJson(
            json
          );
                case 'decoy_blink':
          return ModifierDecoyBlink.fromJson(
            json
          );
                case 'word_masking':
          return ModifierWordMasking.fromJson(
            json
          );
                case 'shuffle_word_list':
          return ModifierShuffleWordList.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Modifier',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Modifier {

 Object get params;

  /// Serializes this Modifier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Modifier&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'Modifier(params: $params)';
}


}

/// @nodoc
class $ModifierCopyWith<$Res>  {
$ModifierCopyWith(Modifier _, $Res Function(Modifier) __);
}


/// Adds pattern-matching-related methods to [Modifier].
extension ModifierPatterns on Modifier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ModifierFog value)?  fog,TResult Function( ModifierLockedCells value)?  lockedCells,TResult Function( ModifierPortals value)?  portals,TResult Function( ModifierIceSlide value)?  iceSlide,TResult Function( ModifierErrorTimePenalty value)?  errorTimePenalty,TResult Function( ModifierHintCooldownOverride value)?  hintCooldownOverride,TResult Function( ModifierDecoyBlink value)?  decoyBlink,TResult Function( ModifierWordMasking value)?  wordMasking,TResult Function( ModifierShuffleWordList value)?  shuffleWordList,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ModifierFog() when fog != null:
return fog(_that);case ModifierLockedCells() when lockedCells != null:
return lockedCells(_that);case ModifierPortals() when portals != null:
return portals(_that);case ModifierIceSlide() when iceSlide != null:
return iceSlide(_that);case ModifierErrorTimePenalty() when errorTimePenalty != null:
return errorTimePenalty(_that);case ModifierHintCooldownOverride() when hintCooldownOverride != null:
return hintCooldownOverride(_that);case ModifierDecoyBlink() when decoyBlink != null:
return decoyBlink(_that);case ModifierWordMasking() when wordMasking != null:
return wordMasking(_that);case ModifierShuffleWordList() when shuffleWordList != null:
return shuffleWordList(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ModifierFog value)  fog,required TResult Function( ModifierLockedCells value)  lockedCells,required TResult Function( ModifierPortals value)  portals,required TResult Function( ModifierIceSlide value)  iceSlide,required TResult Function( ModifierErrorTimePenalty value)  errorTimePenalty,required TResult Function( ModifierHintCooldownOverride value)  hintCooldownOverride,required TResult Function( ModifierDecoyBlink value)  decoyBlink,required TResult Function( ModifierWordMasking value)  wordMasking,required TResult Function( ModifierShuffleWordList value)  shuffleWordList,}){
final _that = this;
switch (_that) {
case ModifierFog():
return fog(_that);case ModifierLockedCells():
return lockedCells(_that);case ModifierPortals():
return portals(_that);case ModifierIceSlide():
return iceSlide(_that);case ModifierErrorTimePenalty():
return errorTimePenalty(_that);case ModifierHintCooldownOverride():
return hintCooldownOverride(_that);case ModifierDecoyBlink():
return decoyBlink(_that);case ModifierWordMasking():
return wordMasking(_that);case ModifierShuffleWordList():
return shuffleWordList(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ModifierFog value)?  fog,TResult? Function( ModifierLockedCells value)?  lockedCells,TResult? Function( ModifierPortals value)?  portals,TResult? Function( ModifierIceSlide value)?  iceSlide,TResult? Function( ModifierErrorTimePenalty value)?  errorTimePenalty,TResult? Function( ModifierHintCooldownOverride value)?  hintCooldownOverride,TResult? Function( ModifierDecoyBlink value)?  decoyBlink,TResult? Function( ModifierWordMasking value)?  wordMasking,TResult? Function( ModifierShuffleWordList value)?  shuffleWordList,}){
final _that = this;
switch (_that) {
case ModifierFog() when fog != null:
return fog(_that);case ModifierLockedCells() when lockedCells != null:
return lockedCells(_that);case ModifierPortals() when portals != null:
return portals(_that);case ModifierIceSlide() when iceSlide != null:
return iceSlide(_that);case ModifierErrorTimePenalty() when errorTimePenalty != null:
return errorTimePenalty(_that);case ModifierHintCooldownOverride() when hintCooldownOverride != null:
return hintCooldownOverride(_that);case ModifierDecoyBlink() when decoyBlink != null:
return decoyBlink(_that);case ModifierWordMasking() when wordMasking != null:
return wordMasking(_that);case ModifierShuffleWordList() when shuffleWordList != null:
return shuffleWordList(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( FogParams params)?  fog,TResult Function( LockedCellsParams params)?  lockedCells,TResult Function( PortalsParams params)?  portals,TResult Function( IceSlideParams params)?  iceSlide,TResult Function( ErrorTimePenaltyParams params)?  errorTimePenalty,TResult Function( HintCooldownOverrideParams params)?  hintCooldownOverride,TResult Function( DecoyBlinkParams params)?  decoyBlink,TResult Function( WordMaskingParams params)?  wordMasking,TResult Function( ShuffleWordListParams params)?  shuffleWordList,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ModifierFog() when fog != null:
return fog(_that.params);case ModifierLockedCells() when lockedCells != null:
return lockedCells(_that.params);case ModifierPortals() when portals != null:
return portals(_that.params);case ModifierIceSlide() when iceSlide != null:
return iceSlide(_that.params);case ModifierErrorTimePenalty() when errorTimePenalty != null:
return errorTimePenalty(_that.params);case ModifierHintCooldownOverride() when hintCooldownOverride != null:
return hintCooldownOverride(_that.params);case ModifierDecoyBlink() when decoyBlink != null:
return decoyBlink(_that.params);case ModifierWordMasking() when wordMasking != null:
return wordMasking(_that.params);case ModifierShuffleWordList() when shuffleWordList != null:
return shuffleWordList(_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( FogParams params)  fog,required TResult Function( LockedCellsParams params)  lockedCells,required TResult Function( PortalsParams params)  portals,required TResult Function( IceSlideParams params)  iceSlide,required TResult Function( ErrorTimePenaltyParams params)  errorTimePenalty,required TResult Function( HintCooldownOverrideParams params)  hintCooldownOverride,required TResult Function( DecoyBlinkParams params)  decoyBlink,required TResult Function( WordMaskingParams params)  wordMasking,required TResult Function( ShuffleWordListParams params)  shuffleWordList,}) {final _that = this;
switch (_that) {
case ModifierFog():
return fog(_that.params);case ModifierLockedCells():
return lockedCells(_that.params);case ModifierPortals():
return portals(_that.params);case ModifierIceSlide():
return iceSlide(_that.params);case ModifierErrorTimePenalty():
return errorTimePenalty(_that.params);case ModifierHintCooldownOverride():
return hintCooldownOverride(_that.params);case ModifierDecoyBlink():
return decoyBlink(_that.params);case ModifierWordMasking():
return wordMasking(_that.params);case ModifierShuffleWordList():
return shuffleWordList(_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( FogParams params)?  fog,TResult? Function( LockedCellsParams params)?  lockedCells,TResult? Function( PortalsParams params)?  portals,TResult? Function( IceSlideParams params)?  iceSlide,TResult? Function( ErrorTimePenaltyParams params)?  errorTimePenalty,TResult? Function( HintCooldownOverrideParams params)?  hintCooldownOverride,TResult? Function( DecoyBlinkParams params)?  decoyBlink,TResult? Function( WordMaskingParams params)?  wordMasking,TResult? Function( ShuffleWordListParams params)?  shuffleWordList,}) {final _that = this;
switch (_that) {
case ModifierFog() when fog != null:
return fog(_that.params);case ModifierLockedCells() when lockedCells != null:
return lockedCells(_that.params);case ModifierPortals() when portals != null:
return portals(_that.params);case ModifierIceSlide() when iceSlide != null:
return iceSlide(_that.params);case ModifierErrorTimePenalty() when errorTimePenalty != null:
return errorTimePenalty(_that.params);case ModifierHintCooldownOverride() when hintCooldownOverride != null:
return hintCooldownOverride(_that.params);case ModifierDecoyBlink() when decoyBlink != null:
return decoyBlink(_that.params);case ModifierWordMasking() when wordMasking != null:
return wordMasking(_that.params);case ModifierShuffleWordList() when shuffleWordList != null:
return shuffleWordList(_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ModifierFog implements Modifier {
  const ModifierFog({this.params = const FogParams(), final  String? $type}): $type = $type ?? 'fog';
  factory ModifierFog.fromJson(Map<String, dynamic> json) => _$ModifierFogFromJson(json);

@override@JsonKey() final  FogParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierFogCopyWith<ModifierFog> get copyWith => _$ModifierFogCopyWithImpl<ModifierFog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierFogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierFog&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.fog(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierFogCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierFogCopyWith(ModifierFog value, $Res Function(ModifierFog) _then) = _$ModifierFogCopyWithImpl;
@useResult
$Res call({
 FogParams params
});


$FogParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierFogCopyWithImpl<$Res>
    implements $ModifierFogCopyWith<$Res> {
  _$ModifierFogCopyWithImpl(this._self, this._then);

  final ModifierFog _self;
  final $Res Function(ModifierFog) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierFog(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as FogParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FogParamsCopyWith<$Res> get params {
  
  return $FogParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierLockedCells implements Modifier {
  const ModifierLockedCells({required this.params, final  String? $type}): $type = $type ?? 'locked_cells';
  factory ModifierLockedCells.fromJson(Map<String, dynamic> json) => _$ModifierLockedCellsFromJson(json);

@override final  LockedCellsParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierLockedCellsCopyWith<ModifierLockedCells> get copyWith => _$ModifierLockedCellsCopyWithImpl<ModifierLockedCells>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierLockedCellsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierLockedCells&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.lockedCells(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierLockedCellsCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierLockedCellsCopyWith(ModifierLockedCells value, $Res Function(ModifierLockedCells) _then) = _$ModifierLockedCellsCopyWithImpl;
@useResult
$Res call({
 LockedCellsParams params
});


$LockedCellsParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierLockedCellsCopyWithImpl<$Res>
    implements $ModifierLockedCellsCopyWith<$Res> {
  _$ModifierLockedCellsCopyWithImpl(this._self, this._then);

  final ModifierLockedCells _self;
  final $Res Function(ModifierLockedCells) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierLockedCells(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as LockedCellsParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LockedCellsParamsCopyWith<$Res> get params {
  
  return $LockedCellsParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierPortals implements Modifier {
  const ModifierPortals({required this.params, final  String? $type}): $type = $type ?? 'portals';
  factory ModifierPortals.fromJson(Map<String, dynamic> json) => _$ModifierPortalsFromJson(json);

@override final  PortalsParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierPortalsCopyWith<ModifierPortals> get copyWith => _$ModifierPortalsCopyWithImpl<ModifierPortals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierPortalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierPortals&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.portals(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierPortalsCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierPortalsCopyWith(ModifierPortals value, $Res Function(ModifierPortals) _then) = _$ModifierPortalsCopyWithImpl;
@useResult
$Res call({
 PortalsParams params
});


$PortalsParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierPortalsCopyWithImpl<$Res>
    implements $ModifierPortalsCopyWith<$Res> {
  _$ModifierPortalsCopyWithImpl(this._self, this._then);

  final ModifierPortals _self;
  final $Res Function(ModifierPortals) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierPortals(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as PortalsParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortalsParamsCopyWith<$Res> get params {
  
  return $PortalsParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierIceSlide implements Modifier {
  const ModifierIceSlide({required this.params, final  String? $type}): $type = $type ?? 'ice_slide';
  factory ModifierIceSlide.fromJson(Map<String, dynamic> json) => _$ModifierIceSlideFromJson(json);

@override final  IceSlideParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierIceSlideCopyWith<ModifierIceSlide> get copyWith => _$ModifierIceSlideCopyWithImpl<ModifierIceSlide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierIceSlideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierIceSlide&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.iceSlide(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierIceSlideCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierIceSlideCopyWith(ModifierIceSlide value, $Res Function(ModifierIceSlide) _then) = _$ModifierIceSlideCopyWithImpl;
@useResult
$Res call({
 IceSlideParams params
});


$IceSlideParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierIceSlideCopyWithImpl<$Res>
    implements $ModifierIceSlideCopyWith<$Res> {
  _$ModifierIceSlideCopyWithImpl(this._self, this._then);

  final ModifierIceSlide _self;
  final $Res Function(ModifierIceSlide) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierIceSlide(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as IceSlideParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IceSlideParamsCopyWith<$Res> get params {
  
  return $IceSlideParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierErrorTimePenalty implements Modifier {
  const ModifierErrorTimePenalty({required this.params, final  String? $type}): $type = $type ?? 'error_time_penalty';
  factory ModifierErrorTimePenalty.fromJson(Map<String, dynamic> json) => _$ModifierErrorTimePenaltyFromJson(json);

@override final  ErrorTimePenaltyParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierErrorTimePenaltyCopyWith<ModifierErrorTimePenalty> get copyWith => _$ModifierErrorTimePenaltyCopyWithImpl<ModifierErrorTimePenalty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierErrorTimePenaltyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierErrorTimePenalty&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.errorTimePenalty(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierErrorTimePenaltyCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierErrorTimePenaltyCopyWith(ModifierErrorTimePenalty value, $Res Function(ModifierErrorTimePenalty) _then) = _$ModifierErrorTimePenaltyCopyWithImpl;
@useResult
$Res call({
 ErrorTimePenaltyParams params
});


$ErrorTimePenaltyParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierErrorTimePenaltyCopyWithImpl<$Res>
    implements $ModifierErrorTimePenaltyCopyWith<$Res> {
  _$ModifierErrorTimePenaltyCopyWithImpl(this._self, this._then);

  final ModifierErrorTimePenalty _self;
  final $Res Function(ModifierErrorTimePenalty) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierErrorTimePenalty(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as ErrorTimePenaltyParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ErrorTimePenaltyParamsCopyWith<$Res> get params {
  
  return $ErrorTimePenaltyParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierHintCooldownOverride implements Modifier {
  const ModifierHintCooldownOverride({required this.params, final  String? $type}): $type = $type ?? 'hint_cooldown_override';
  factory ModifierHintCooldownOverride.fromJson(Map<String, dynamic> json) => _$ModifierHintCooldownOverrideFromJson(json);

@override final  HintCooldownOverrideParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierHintCooldownOverrideCopyWith<ModifierHintCooldownOverride> get copyWith => _$ModifierHintCooldownOverrideCopyWithImpl<ModifierHintCooldownOverride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierHintCooldownOverrideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierHintCooldownOverride&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.hintCooldownOverride(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierHintCooldownOverrideCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierHintCooldownOverrideCopyWith(ModifierHintCooldownOverride value, $Res Function(ModifierHintCooldownOverride) _then) = _$ModifierHintCooldownOverrideCopyWithImpl;
@useResult
$Res call({
 HintCooldownOverrideParams params
});


$HintCooldownOverrideParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierHintCooldownOverrideCopyWithImpl<$Res>
    implements $ModifierHintCooldownOverrideCopyWith<$Res> {
  _$ModifierHintCooldownOverrideCopyWithImpl(this._self, this._then);

  final ModifierHintCooldownOverride _self;
  final $Res Function(ModifierHintCooldownOverride) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierHintCooldownOverride(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as HintCooldownOverrideParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HintCooldownOverrideParamsCopyWith<$Res> get params {
  
  return $HintCooldownOverrideParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierDecoyBlink implements Modifier {
  const ModifierDecoyBlink({required this.params, final  String? $type}): $type = $type ?? 'decoy_blink';
  factory ModifierDecoyBlink.fromJson(Map<String, dynamic> json) => _$ModifierDecoyBlinkFromJson(json);

@override final  DecoyBlinkParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierDecoyBlinkCopyWith<ModifierDecoyBlink> get copyWith => _$ModifierDecoyBlinkCopyWithImpl<ModifierDecoyBlink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierDecoyBlinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierDecoyBlink&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.decoyBlink(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierDecoyBlinkCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierDecoyBlinkCopyWith(ModifierDecoyBlink value, $Res Function(ModifierDecoyBlink) _then) = _$ModifierDecoyBlinkCopyWithImpl;
@useResult
$Res call({
 DecoyBlinkParams params
});


$DecoyBlinkParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierDecoyBlinkCopyWithImpl<$Res>
    implements $ModifierDecoyBlinkCopyWith<$Res> {
  _$ModifierDecoyBlinkCopyWithImpl(this._self, this._then);

  final ModifierDecoyBlink _self;
  final $Res Function(ModifierDecoyBlink) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierDecoyBlink(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as DecoyBlinkParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DecoyBlinkParamsCopyWith<$Res> get params {
  
  return $DecoyBlinkParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierWordMasking implements Modifier {
  const ModifierWordMasking({required this.params, final  String? $type}): $type = $type ?? 'word_masking';
  factory ModifierWordMasking.fromJson(Map<String, dynamic> json) => _$ModifierWordMaskingFromJson(json);

@override final  WordMaskingParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierWordMaskingCopyWith<ModifierWordMasking> get copyWith => _$ModifierWordMaskingCopyWithImpl<ModifierWordMasking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierWordMaskingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierWordMasking&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.wordMasking(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierWordMaskingCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierWordMaskingCopyWith(ModifierWordMasking value, $Res Function(ModifierWordMasking) _then) = _$ModifierWordMaskingCopyWithImpl;
@useResult
$Res call({
 WordMaskingParams params
});


$WordMaskingParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierWordMaskingCopyWithImpl<$Res>
    implements $ModifierWordMaskingCopyWith<$Res> {
  _$ModifierWordMaskingCopyWithImpl(this._self, this._then);

  final ModifierWordMasking _self;
  final $Res Function(ModifierWordMasking) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierWordMasking(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as WordMaskingParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordMaskingParamsCopyWith<$Res> get params {
  
  return $WordMaskingParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ModifierShuffleWordList implements Modifier {
  const ModifierShuffleWordList({this.params = const ShuffleWordListParams(), final  String? $type}): $type = $type ?? 'shuffle_word_list';
  factory ModifierShuffleWordList.fromJson(Map<String, dynamic> json) => _$ModifierShuffleWordListFromJson(json);

@override@JsonKey() final  ShuffleWordListParams params;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModifierShuffleWordListCopyWith<ModifierShuffleWordList> get copyWith => _$ModifierShuffleWordListCopyWithImpl<ModifierShuffleWordList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModifierShuffleWordListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModifierShuffleWordList&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'Modifier.shuffleWordList(params: $params)';
}


}

/// @nodoc
abstract mixin class $ModifierShuffleWordListCopyWith<$Res> implements $ModifierCopyWith<$Res> {
  factory $ModifierShuffleWordListCopyWith(ModifierShuffleWordList value, $Res Function(ModifierShuffleWordList) _then) = _$ModifierShuffleWordListCopyWithImpl;
@useResult
$Res call({
 ShuffleWordListParams params
});


$ShuffleWordListParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ModifierShuffleWordListCopyWithImpl<$Res>
    implements $ModifierShuffleWordListCopyWith<$Res> {
  _$ModifierShuffleWordListCopyWithImpl(this._self, this._then);

  final ModifierShuffleWordList _self;
  final $Res Function(ModifierShuffleWordList) _then;

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ModifierShuffleWordList(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as ShuffleWordListParams,
  ));
}

/// Create a copy of Modifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShuffleWordListParamsCopyWith<$Res> get params {
  
  return $ShuffleWordListParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// @nodoc
mixin _$FogParams {

 int get revealRadius; FogReveal get reveal; bool get persist; FogStartRevealed get startRevealed;
/// Create a copy of FogParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FogParamsCopyWith<FogParams> get copyWith => _$FogParamsCopyWithImpl<FogParams>(this as FogParams, _$identity);

  /// Serializes this FogParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FogParams&&(identical(other.revealRadius, revealRadius) || other.revealRadius == revealRadius)&&(identical(other.reveal, reveal) || other.reveal == reveal)&&(identical(other.persist, persist) || other.persist == persist)&&(identical(other.startRevealed, startRevealed) || other.startRevealed == startRevealed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revealRadius,reveal,persist,startRevealed);

@override
String toString() {
  return 'FogParams(revealRadius: $revealRadius, reveal: $reveal, persist: $persist, startRevealed: $startRevealed)';
}


}

/// @nodoc
abstract mixin class $FogParamsCopyWith<$Res>  {
  factory $FogParamsCopyWith(FogParams value, $Res Function(FogParams) _then) = _$FogParamsCopyWithImpl;
@useResult
$Res call({
 int revealRadius, FogReveal reveal, bool persist, FogStartRevealed startRevealed
});




}
/// @nodoc
class _$FogParamsCopyWithImpl<$Res>
    implements $FogParamsCopyWith<$Res> {
  _$FogParamsCopyWithImpl(this._self, this._then);

  final FogParams _self;
  final $Res Function(FogParams) _then;

/// Create a copy of FogParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revealRadius = null,Object? reveal = null,Object? persist = null,Object? startRevealed = null,}) {
  return _then(_self.copyWith(
revealRadius: null == revealRadius ? _self.revealRadius : revealRadius // ignore: cast_nullable_to_non_nullable
as int,reveal: null == reveal ? _self.reveal : reveal // ignore: cast_nullable_to_non_nullable
as FogReveal,persist: null == persist ? _self.persist : persist // ignore: cast_nullable_to_non_nullable
as bool,startRevealed: null == startRevealed ? _self.startRevealed : startRevealed // ignore: cast_nullable_to_non_nullable
as FogStartRevealed,
  ));
}

}


/// Adds pattern-matching-related methods to [FogParams].
extension FogParamsPatterns on FogParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FogParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FogParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FogParams value)  $default,){
final _that = this;
switch (_that) {
case _FogParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FogParams value)?  $default,){
final _that = this;
switch (_that) {
case _FogParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int revealRadius,  FogReveal reveal,  bool persist,  FogStartRevealed startRevealed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FogParams() when $default != null:
return $default(_that.revealRadius,_that.reveal,_that.persist,_that.startRevealed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int revealRadius,  FogReveal reveal,  bool persist,  FogStartRevealed startRevealed)  $default,) {final _that = this;
switch (_that) {
case _FogParams():
return $default(_that.revealRadius,_that.reveal,_that.persist,_that.startRevealed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int revealRadius,  FogReveal reveal,  bool persist,  FogStartRevealed startRevealed)?  $default,) {final _that = this;
switch (_that) {
case _FogParams() when $default != null:
return $default(_that.revealRadius,_that.reveal,_that.persist,_that.startRevealed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FogParams implements FogParams {
  const _FogParams({this.revealRadius = 1, this.reveal = FogReveal.touch, this.persist = true, this.startRevealed = FogStartRevealed.none});
  factory _FogParams.fromJson(Map<String, dynamic> json) => _$FogParamsFromJson(json);

@override@JsonKey() final  int revealRadius;
@override@JsonKey() final  FogReveal reveal;
@override@JsonKey() final  bool persist;
@override@JsonKey() final  FogStartRevealed startRevealed;

/// Create a copy of FogParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FogParamsCopyWith<_FogParams> get copyWith => __$FogParamsCopyWithImpl<_FogParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FogParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FogParams&&(identical(other.revealRadius, revealRadius) || other.revealRadius == revealRadius)&&(identical(other.reveal, reveal) || other.reveal == reveal)&&(identical(other.persist, persist) || other.persist == persist)&&(identical(other.startRevealed, startRevealed) || other.startRevealed == startRevealed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revealRadius,reveal,persist,startRevealed);

@override
String toString() {
  return 'FogParams(revealRadius: $revealRadius, reveal: $reveal, persist: $persist, startRevealed: $startRevealed)';
}


}

/// @nodoc
abstract mixin class _$FogParamsCopyWith<$Res> implements $FogParamsCopyWith<$Res> {
  factory _$FogParamsCopyWith(_FogParams value, $Res Function(_FogParams) _then) = __$FogParamsCopyWithImpl;
@override @useResult
$Res call({
 int revealRadius, FogReveal reveal, bool persist, FogStartRevealed startRevealed
});




}
/// @nodoc
class __$FogParamsCopyWithImpl<$Res>
    implements _$FogParamsCopyWith<$Res> {
  __$FogParamsCopyWithImpl(this._self, this._then);

  final _FogParams _self;
  final $Res Function(_FogParams) _then;

/// Create a copy of FogParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revealRadius = null,Object? reveal = null,Object? persist = null,Object? startRevealed = null,}) {
  return _then(_FogParams(
revealRadius: null == revealRadius ? _self.revealRadius : revealRadius // ignore: cast_nullable_to_non_nullable
as int,reveal: null == reveal ? _self.reveal : reveal // ignore: cast_nullable_to_non_nullable
as FogReveal,persist: null == persist ? _self.persist : persist // ignore: cast_nullable_to_non_nullable
as bool,startRevealed: null == startRevealed ? _self.startRevealed : startRevealed // ignore: cast_nullable_to_non_nullable
as FogStartRevealed,
  ));
}


}


/// @nodoc
mixin _$LockedCellsParams {

 List<Coord> get cells; UnlockOn? get unlockOn;
/// Create a copy of LockedCellsParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockedCellsParamsCopyWith<LockedCellsParams> get copyWith => _$LockedCellsParamsCopyWithImpl<LockedCellsParams>(this as LockedCellsParams, _$identity);

  /// Serializes this LockedCellsParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockedCellsParams&&const DeepCollectionEquality().equals(other.cells, cells)&&(identical(other.unlockOn, unlockOn) || other.unlockOn == unlockOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cells),unlockOn);

@override
String toString() {
  return 'LockedCellsParams(cells: $cells, unlockOn: $unlockOn)';
}


}

/// @nodoc
abstract mixin class $LockedCellsParamsCopyWith<$Res>  {
  factory $LockedCellsParamsCopyWith(LockedCellsParams value, $Res Function(LockedCellsParams) _then) = _$LockedCellsParamsCopyWithImpl;
@useResult
$Res call({
 List<Coord> cells, UnlockOn? unlockOn
});


$UnlockOnCopyWith<$Res>? get unlockOn;

}
/// @nodoc
class _$LockedCellsParamsCopyWithImpl<$Res>
    implements $LockedCellsParamsCopyWith<$Res> {
  _$LockedCellsParamsCopyWithImpl(this._self, this._then);

  final LockedCellsParams _self;
  final $Res Function(LockedCellsParams) _then;

/// Create a copy of LockedCellsParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cells = null,Object? unlockOn = freezed,}) {
  return _then(_self.copyWith(
cells: null == cells ? _self.cells : cells // ignore: cast_nullable_to_non_nullable
as List<Coord>,unlockOn: freezed == unlockOn ? _self.unlockOn : unlockOn // ignore: cast_nullable_to_non_nullable
as UnlockOn?,
  ));
}
/// Create a copy of LockedCellsParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnlockOnCopyWith<$Res>? get unlockOn {
    if (_self.unlockOn == null) {
    return null;
  }

  return $UnlockOnCopyWith<$Res>(_self.unlockOn!, (value) {
    return _then(_self.copyWith(unlockOn: value));
  });
}
}


/// Adds pattern-matching-related methods to [LockedCellsParams].
extension LockedCellsParamsPatterns on LockedCellsParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LockedCellsParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LockedCellsParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LockedCellsParams value)  $default,){
final _that = this;
switch (_that) {
case _LockedCellsParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LockedCellsParams value)?  $default,){
final _that = this;
switch (_that) {
case _LockedCellsParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Coord> cells,  UnlockOn? unlockOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LockedCellsParams() when $default != null:
return $default(_that.cells,_that.unlockOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Coord> cells,  UnlockOn? unlockOn)  $default,) {final _that = this;
switch (_that) {
case _LockedCellsParams():
return $default(_that.cells,_that.unlockOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Coord> cells,  UnlockOn? unlockOn)?  $default,) {final _that = this;
switch (_that) {
case _LockedCellsParams() when $default != null:
return $default(_that.cells,_that.unlockOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LockedCellsParams implements LockedCellsParams {
  const _LockedCellsParams({required final  List<Coord> cells, this.unlockOn}): _cells = cells;
  factory _LockedCellsParams.fromJson(Map<String, dynamic> json) => _$LockedCellsParamsFromJson(json);

 final  List<Coord> _cells;
@override List<Coord> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}

@override final  UnlockOn? unlockOn;

/// Create a copy of LockedCellsParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockedCellsParamsCopyWith<_LockedCellsParams> get copyWith => __$LockedCellsParamsCopyWithImpl<_LockedCellsParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LockedCellsParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockedCellsParams&&const DeepCollectionEquality().equals(other._cells, _cells)&&(identical(other.unlockOn, unlockOn) || other.unlockOn == unlockOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cells),unlockOn);

@override
String toString() {
  return 'LockedCellsParams(cells: $cells, unlockOn: $unlockOn)';
}


}

/// @nodoc
abstract mixin class _$LockedCellsParamsCopyWith<$Res> implements $LockedCellsParamsCopyWith<$Res> {
  factory _$LockedCellsParamsCopyWith(_LockedCellsParams value, $Res Function(_LockedCellsParams) _then) = __$LockedCellsParamsCopyWithImpl;
@override @useResult
$Res call({
 List<Coord> cells, UnlockOn? unlockOn
});


@override $UnlockOnCopyWith<$Res>? get unlockOn;

}
/// @nodoc
class __$LockedCellsParamsCopyWithImpl<$Res>
    implements _$LockedCellsParamsCopyWith<$Res> {
  __$LockedCellsParamsCopyWithImpl(this._self, this._then);

  final _LockedCellsParams _self;
  final $Res Function(_LockedCellsParams) _then;

/// Create a copy of LockedCellsParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cells = null,Object? unlockOn = freezed,}) {
  return _then(_LockedCellsParams(
cells: null == cells ? _self._cells : cells // ignore: cast_nullable_to_non_nullable
as List<Coord>,unlockOn: freezed == unlockOn ? _self.unlockOn : unlockOn // ignore: cast_nullable_to_non_nullable
as UnlockOn?,
  ));
}

/// Create a copy of LockedCellsParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnlockOnCopyWith<$Res>? get unlockOn {
    if (_self.unlockOn == null) {
    return null;
  }

  return $UnlockOnCopyWith<$Res>(_self.unlockOn!, (value) {
    return _then(_self.copyWith(unlockOn: value));
  });
}
}

UnlockOn _$UnlockOnFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'wordFound':
          return UnlockOnWordFound.fromJson(
            json
          );
                case 'wordsFoundAtLeast':
          return UnlockOnWordsFoundAtLeast.fromJson(
            json
          );
                case 'timeElapsed':
          return UnlockOnTimeElapsed.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'UnlockOn',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$UnlockOn {



  /// Serializes this UnlockOn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockOn);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UnlockOn()';
}


}

/// @nodoc
class $UnlockOnCopyWith<$Res>  {
$UnlockOnCopyWith(UnlockOn _, $Res Function(UnlockOn) __);
}


/// Adds pattern-matching-related methods to [UnlockOn].
extension UnlockOnPatterns on UnlockOn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UnlockOnWordFound value)?  wordFound,TResult Function( UnlockOnWordsFoundAtLeast value)?  wordsFoundAtLeast,TResult Function( UnlockOnTimeElapsed value)?  timeElapsed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UnlockOnWordFound() when wordFound != null:
return wordFound(_that);case UnlockOnWordsFoundAtLeast() when wordsFoundAtLeast != null:
return wordsFoundAtLeast(_that);case UnlockOnTimeElapsed() when timeElapsed != null:
return timeElapsed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UnlockOnWordFound value)  wordFound,required TResult Function( UnlockOnWordsFoundAtLeast value)  wordsFoundAtLeast,required TResult Function( UnlockOnTimeElapsed value)  timeElapsed,}){
final _that = this;
switch (_that) {
case UnlockOnWordFound():
return wordFound(_that);case UnlockOnWordsFoundAtLeast():
return wordsFoundAtLeast(_that);case UnlockOnTimeElapsed():
return timeElapsed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UnlockOnWordFound value)?  wordFound,TResult? Function( UnlockOnWordsFoundAtLeast value)?  wordsFoundAtLeast,TResult? Function( UnlockOnTimeElapsed value)?  timeElapsed,}){
final _that = this;
switch (_that) {
case UnlockOnWordFound() when wordFound != null:
return wordFound(_that);case UnlockOnWordsFoundAtLeast() when wordsFoundAtLeast != null:
return wordsFoundAtLeast(_that);case UnlockOnTimeElapsed() when timeElapsed != null:
return timeElapsed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String wordId)?  wordFound,TResult Function( int count)?  wordsFoundAtLeast,TResult Function( int seconds)?  timeElapsed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UnlockOnWordFound() when wordFound != null:
return wordFound(_that.wordId);case UnlockOnWordsFoundAtLeast() when wordsFoundAtLeast != null:
return wordsFoundAtLeast(_that.count);case UnlockOnTimeElapsed() when timeElapsed != null:
return timeElapsed(_that.seconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String wordId)  wordFound,required TResult Function( int count)  wordsFoundAtLeast,required TResult Function( int seconds)  timeElapsed,}) {final _that = this;
switch (_that) {
case UnlockOnWordFound():
return wordFound(_that.wordId);case UnlockOnWordsFoundAtLeast():
return wordsFoundAtLeast(_that.count);case UnlockOnTimeElapsed():
return timeElapsed(_that.seconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String wordId)?  wordFound,TResult? Function( int count)?  wordsFoundAtLeast,TResult? Function( int seconds)?  timeElapsed,}) {final _that = this;
switch (_that) {
case UnlockOnWordFound() when wordFound != null:
return wordFound(_that.wordId);case UnlockOnWordsFoundAtLeast() when wordsFoundAtLeast != null:
return wordsFoundAtLeast(_that.count);case UnlockOnTimeElapsed() when timeElapsed != null:
return timeElapsed(_that.seconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UnlockOnWordFound implements UnlockOn {
  const UnlockOnWordFound({required this.wordId, final  String? $type}): $type = $type ?? 'wordFound';
  factory UnlockOnWordFound.fromJson(Map<String, dynamic> json) => _$UnlockOnWordFoundFromJson(json);

 final  String wordId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of UnlockOn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockOnWordFoundCopyWith<UnlockOnWordFound> get copyWith => _$UnlockOnWordFoundCopyWithImpl<UnlockOnWordFound>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnlockOnWordFoundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockOnWordFound&&(identical(other.wordId, wordId) || other.wordId == wordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId);

@override
String toString() {
  return 'UnlockOn.wordFound(wordId: $wordId)';
}


}

/// @nodoc
abstract mixin class $UnlockOnWordFoundCopyWith<$Res> implements $UnlockOnCopyWith<$Res> {
  factory $UnlockOnWordFoundCopyWith(UnlockOnWordFound value, $Res Function(UnlockOnWordFound) _then) = _$UnlockOnWordFoundCopyWithImpl;
@useResult
$Res call({
 String wordId
});




}
/// @nodoc
class _$UnlockOnWordFoundCopyWithImpl<$Res>
    implements $UnlockOnWordFoundCopyWith<$Res> {
  _$UnlockOnWordFoundCopyWithImpl(this._self, this._then);

  final UnlockOnWordFound _self;
  final $Res Function(UnlockOnWordFound) _then;

/// Create a copy of UnlockOn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? wordId = null,}) {
  return _then(UnlockOnWordFound(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnlockOnWordsFoundAtLeast implements UnlockOn {
  const UnlockOnWordsFoundAtLeast({required this.count, final  String? $type}): $type = $type ?? 'wordsFoundAtLeast';
  factory UnlockOnWordsFoundAtLeast.fromJson(Map<String, dynamic> json) => _$UnlockOnWordsFoundAtLeastFromJson(json);

 final  int count;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of UnlockOn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockOnWordsFoundAtLeastCopyWith<UnlockOnWordsFoundAtLeast> get copyWith => _$UnlockOnWordsFoundAtLeastCopyWithImpl<UnlockOnWordsFoundAtLeast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnlockOnWordsFoundAtLeastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockOnWordsFoundAtLeast&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'UnlockOn.wordsFoundAtLeast(count: $count)';
}


}

/// @nodoc
abstract mixin class $UnlockOnWordsFoundAtLeastCopyWith<$Res> implements $UnlockOnCopyWith<$Res> {
  factory $UnlockOnWordsFoundAtLeastCopyWith(UnlockOnWordsFoundAtLeast value, $Res Function(UnlockOnWordsFoundAtLeast) _then) = _$UnlockOnWordsFoundAtLeastCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$UnlockOnWordsFoundAtLeastCopyWithImpl<$Res>
    implements $UnlockOnWordsFoundAtLeastCopyWith<$Res> {
  _$UnlockOnWordsFoundAtLeastCopyWithImpl(this._self, this._then);

  final UnlockOnWordsFoundAtLeast _self;
  final $Res Function(UnlockOnWordsFoundAtLeast) _then;

/// Create a copy of UnlockOn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(UnlockOnWordsFoundAtLeast(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnlockOnTimeElapsed implements UnlockOn {
  const UnlockOnTimeElapsed({required this.seconds, final  String? $type}): $type = $type ?? 'timeElapsed';
  factory UnlockOnTimeElapsed.fromJson(Map<String, dynamic> json) => _$UnlockOnTimeElapsedFromJson(json);

 final  int seconds;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of UnlockOn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockOnTimeElapsedCopyWith<UnlockOnTimeElapsed> get copyWith => _$UnlockOnTimeElapsedCopyWithImpl<UnlockOnTimeElapsed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnlockOnTimeElapsedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockOnTimeElapsed&&(identical(other.seconds, seconds) || other.seconds == seconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seconds);

@override
String toString() {
  return 'UnlockOn.timeElapsed(seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class $UnlockOnTimeElapsedCopyWith<$Res> implements $UnlockOnCopyWith<$Res> {
  factory $UnlockOnTimeElapsedCopyWith(UnlockOnTimeElapsed value, $Res Function(UnlockOnTimeElapsed) _then) = _$UnlockOnTimeElapsedCopyWithImpl;
@useResult
$Res call({
 int seconds
});




}
/// @nodoc
class _$UnlockOnTimeElapsedCopyWithImpl<$Res>
    implements $UnlockOnTimeElapsedCopyWith<$Res> {
  _$UnlockOnTimeElapsedCopyWithImpl(this._self, this._then);

  final UnlockOnTimeElapsed _self;
  final $Res Function(UnlockOnTimeElapsed) _then;

/// Create a copy of UnlockOn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? seconds = null,}) {
  return _then(UnlockOnTimeElapsed(
seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PortalsParams {

 List<PortalPair> get pairs; bool get bidirectional;
/// Create a copy of PortalsParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortalsParamsCopyWith<PortalsParams> get copyWith => _$PortalsParamsCopyWithImpl<PortalsParams>(this as PortalsParams, _$identity);

  /// Serializes this PortalsParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortalsParams&&const DeepCollectionEquality().equals(other.pairs, pairs)&&(identical(other.bidirectional, bidirectional) || other.bidirectional == bidirectional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pairs),bidirectional);

@override
String toString() {
  return 'PortalsParams(pairs: $pairs, bidirectional: $bidirectional)';
}


}

/// @nodoc
abstract mixin class $PortalsParamsCopyWith<$Res>  {
  factory $PortalsParamsCopyWith(PortalsParams value, $Res Function(PortalsParams) _then) = _$PortalsParamsCopyWithImpl;
@useResult
$Res call({
 List<PortalPair> pairs, bool bidirectional
});




}
/// @nodoc
class _$PortalsParamsCopyWithImpl<$Res>
    implements $PortalsParamsCopyWith<$Res> {
  _$PortalsParamsCopyWithImpl(this._self, this._then);

  final PortalsParams _self;
  final $Res Function(PortalsParams) _then;

/// Create a copy of PortalsParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pairs = null,Object? bidirectional = null,}) {
  return _then(_self.copyWith(
pairs: null == pairs ? _self.pairs : pairs // ignore: cast_nullable_to_non_nullable
as List<PortalPair>,bidirectional: null == bidirectional ? _self.bidirectional : bidirectional // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PortalsParams].
extension PortalsParamsPatterns on PortalsParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortalsParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortalsParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortalsParams value)  $default,){
final _that = this;
switch (_that) {
case _PortalsParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortalsParams value)?  $default,){
final _that = this;
switch (_that) {
case _PortalsParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PortalPair> pairs,  bool bidirectional)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortalsParams() when $default != null:
return $default(_that.pairs,_that.bidirectional);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PortalPair> pairs,  bool bidirectional)  $default,) {final _that = this;
switch (_that) {
case _PortalsParams():
return $default(_that.pairs,_that.bidirectional);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PortalPair> pairs,  bool bidirectional)?  $default,) {final _that = this;
switch (_that) {
case _PortalsParams() when $default != null:
return $default(_that.pairs,_that.bidirectional);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortalsParams implements PortalsParams {
  const _PortalsParams({required final  List<PortalPair> pairs, this.bidirectional = true}): _pairs = pairs;
  factory _PortalsParams.fromJson(Map<String, dynamic> json) => _$PortalsParamsFromJson(json);

 final  List<PortalPair> _pairs;
@override List<PortalPair> get pairs {
  if (_pairs is EqualUnmodifiableListView) return _pairs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pairs);
}

@override@JsonKey() final  bool bidirectional;

/// Create a copy of PortalsParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortalsParamsCopyWith<_PortalsParams> get copyWith => __$PortalsParamsCopyWithImpl<_PortalsParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortalsParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortalsParams&&const DeepCollectionEquality().equals(other._pairs, _pairs)&&(identical(other.bidirectional, bidirectional) || other.bidirectional == bidirectional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pairs),bidirectional);

@override
String toString() {
  return 'PortalsParams(pairs: $pairs, bidirectional: $bidirectional)';
}


}

/// @nodoc
abstract mixin class _$PortalsParamsCopyWith<$Res> implements $PortalsParamsCopyWith<$Res> {
  factory _$PortalsParamsCopyWith(_PortalsParams value, $Res Function(_PortalsParams) _then) = __$PortalsParamsCopyWithImpl;
@override @useResult
$Res call({
 List<PortalPair> pairs, bool bidirectional
});




}
/// @nodoc
class __$PortalsParamsCopyWithImpl<$Res>
    implements _$PortalsParamsCopyWith<$Res> {
  __$PortalsParamsCopyWithImpl(this._self, this._then);

  final _PortalsParams _self;
  final $Res Function(_PortalsParams) _then;

/// Create a copy of PortalsParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pairs = null,Object? bidirectional = null,}) {
  return _then(_PortalsParams(
pairs: null == pairs ? _self._pairs : pairs // ignore: cast_nullable_to_non_nullable
as List<PortalPair>,bidirectional: null == bidirectional ? _self.bidirectional : bidirectional // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PortalPair {

 Coord get a; Coord get b;
/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortalPairCopyWith<PortalPair> get copyWith => _$PortalPairCopyWithImpl<PortalPair>(this as PortalPair, _$identity);

  /// Serializes this PortalPair to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortalPair&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString() {
  return 'PortalPair(a: $a, b: $b)';
}


}

/// @nodoc
abstract mixin class $PortalPairCopyWith<$Res>  {
  factory $PortalPairCopyWith(PortalPair value, $Res Function(PortalPair) _then) = _$PortalPairCopyWithImpl;
@useResult
$Res call({
 Coord a, Coord b
});


$CoordCopyWith<$Res> get a;$CoordCopyWith<$Res> get b;

}
/// @nodoc
class _$PortalPairCopyWithImpl<$Res>
    implements $PortalPairCopyWith<$Res> {
  _$PortalPairCopyWithImpl(this._self, this._then);

  final PortalPair _self;
  final $Res Function(PortalPair) _then;

/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? a = null,Object? b = null,}) {
  return _then(_self.copyWith(
a: null == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as Coord,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as Coord,
  ));
}
/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get a {
  
  return $CoordCopyWith<$Res>(_self.a, (value) {
    return _then(_self.copyWith(a: value));
  });
}/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get b {
  
  return $CoordCopyWith<$Res>(_self.b, (value) {
    return _then(_self.copyWith(b: value));
  });
}
}


/// Adds pattern-matching-related methods to [PortalPair].
extension PortalPairPatterns on PortalPair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortalPair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortalPair() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortalPair value)  $default,){
final _that = this;
switch (_that) {
case _PortalPair():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortalPair value)?  $default,){
final _that = this;
switch (_that) {
case _PortalPair() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Coord a,  Coord b)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortalPair() when $default != null:
return $default(_that.a,_that.b);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Coord a,  Coord b)  $default,) {final _that = this;
switch (_that) {
case _PortalPair():
return $default(_that.a,_that.b);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Coord a,  Coord b)?  $default,) {final _that = this;
switch (_that) {
case _PortalPair() when $default != null:
return $default(_that.a,_that.b);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortalPair implements PortalPair {
  const _PortalPair({required this.a, required this.b});
  factory _PortalPair.fromJson(Map<String, dynamic> json) => _$PortalPairFromJson(json);

@override final  Coord a;
@override final  Coord b;

/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortalPairCopyWith<_PortalPair> get copyWith => __$PortalPairCopyWithImpl<_PortalPair>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortalPairToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortalPair&&(identical(other.a, a) || other.a == a)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,a,b);

@override
String toString() {
  return 'PortalPair(a: $a, b: $b)';
}


}

/// @nodoc
abstract mixin class _$PortalPairCopyWith<$Res> implements $PortalPairCopyWith<$Res> {
  factory _$PortalPairCopyWith(_PortalPair value, $Res Function(_PortalPair) _then) = __$PortalPairCopyWithImpl;
@override @useResult
$Res call({
 Coord a, Coord b
});


@override $CoordCopyWith<$Res> get a;@override $CoordCopyWith<$Res> get b;

}
/// @nodoc
class __$PortalPairCopyWithImpl<$Res>
    implements _$PortalPairCopyWith<$Res> {
  __$PortalPairCopyWithImpl(this._self, this._then);

  final _PortalPair _self;
  final $Res Function(_PortalPair) _then;

/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? a = null,Object? b = null,}) {
  return _then(_PortalPair(
a: null == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as Coord,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as Coord,
  ));
}

/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get a {
  
  return $CoordCopyWith<$Res>(_self.a, (value) {
    return _then(_self.copyWith(a: value));
  });
}/// Create a copy of PortalPair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get b {
  
  return $CoordCopyWith<$Res>(_self.b, (value) {
    return _then(_self.copyWith(b: value));
  });
}
}


/// @nodoc
mixin _$IceSlideParams {

 IceStopOn get stopOn; bool get allowDiagonal;
/// Create a copy of IceSlideParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IceSlideParamsCopyWith<IceSlideParams> get copyWith => _$IceSlideParamsCopyWithImpl<IceSlideParams>(this as IceSlideParams, _$identity);

  /// Serializes this IceSlideParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IceSlideParams&&(identical(other.stopOn, stopOn) || other.stopOn == stopOn)&&(identical(other.allowDiagonal, allowDiagonal) || other.allowDiagonal == allowDiagonal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stopOn,allowDiagonal);

@override
String toString() {
  return 'IceSlideParams(stopOn: $stopOn, allowDiagonal: $allowDiagonal)';
}


}

/// @nodoc
abstract mixin class $IceSlideParamsCopyWith<$Res>  {
  factory $IceSlideParamsCopyWith(IceSlideParams value, $Res Function(IceSlideParams) _then) = _$IceSlideParamsCopyWithImpl;
@useResult
$Res call({
 IceStopOn stopOn, bool allowDiagonal
});




}
/// @nodoc
class _$IceSlideParamsCopyWithImpl<$Res>
    implements $IceSlideParamsCopyWith<$Res> {
  _$IceSlideParamsCopyWithImpl(this._self, this._then);

  final IceSlideParams _self;
  final $Res Function(IceSlideParams) _then;

/// Create a copy of IceSlideParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stopOn = null,Object? allowDiagonal = null,}) {
  return _then(_self.copyWith(
stopOn: null == stopOn ? _self.stopOn : stopOn // ignore: cast_nullable_to_non_nullable
as IceStopOn,allowDiagonal: null == allowDiagonal ? _self.allowDiagonal : allowDiagonal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IceSlideParams].
extension IceSlideParamsPatterns on IceSlideParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IceSlideParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IceSlideParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IceSlideParams value)  $default,){
final _that = this;
switch (_that) {
case _IceSlideParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IceSlideParams value)?  $default,){
final _that = this;
switch (_that) {
case _IceSlideParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IceStopOn stopOn,  bool allowDiagonal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IceSlideParams() when $default != null:
return $default(_that.stopOn,_that.allowDiagonal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IceStopOn stopOn,  bool allowDiagonal)  $default,) {final _that = this;
switch (_that) {
case _IceSlideParams():
return $default(_that.stopOn,_that.allowDiagonal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IceStopOn stopOn,  bool allowDiagonal)?  $default,) {final _that = this;
switch (_that) {
case _IceSlideParams() when $default != null:
return $default(_that.stopOn,_that.allowDiagonal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IceSlideParams implements IceSlideParams {
  const _IceSlideParams({required this.stopOn, this.allowDiagonal = true});
  factory _IceSlideParams.fromJson(Map<String, dynamic> json) => _$IceSlideParamsFromJson(json);

@override final  IceStopOn stopOn;
@override@JsonKey() final  bool allowDiagonal;

/// Create a copy of IceSlideParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IceSlideParamsCopyWith<_IceSlideParams> get copyWith => __$IceSlideParamsCopyWithImpl<_IceSlideParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IceSlideParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IceSlideParams&&(identical(other.stopOn, stopOn) || other.stopOn == stopOn)&&(identical(other.allowDiagonal, allowDiagonal) || other.allowDiagonal == allowDiagonal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stopOn,allowDiagonal);

@override
String toString() {
  return 'IceSlideParams(stopOn: $stopOn, allowDiagonal: $allowDiagonal)';
}


}

/// @nodoc
abstract mixin class _$IceSlideParamsCopyWith<$Res> implements $IceSlideParamsCopyWith<$Res> {
  factory _$IceSlideParamsCopyWith(_IceSlideParams value, $Res Function(_IceSlideParams) _then) = __$IceSlideParamsCopyWithImpl;
@override @useResult
$Res call({
 IceStopOn stopOn, bool allowDiagonal
});




}
/// @nodoc
class __$IceSlideParamsCopyWithImpl<$Res>
    implements _$IceSlideParamsCopyWith<$Res> {
  __$IceSlideParamsCopyWithImpl(this._self, this._then);

  final _IceSlideParams _self;
  final $Res Function(_IceSlideParams) _then;

/// Create a copy of IceSlideParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stopOn = null,Object? allowDiagonal = null,}) {
  return _then(_IceSlideParams(
stopOn: null == stopOn ? _self.stopOn : stopOn // ignore: cast_nullable_to_non_nullable
as IceStopOn,allowDiagonal: null == allowDiagonal ? _self.allowDiagonal : allowDiagonal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ErrorTimePenaltyParams {

 int get seconds;
/// Create a copy of ErrorTimePenaltyParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTimePenaltyParamsCopyWith<ErrorTimePenaltyParams> get copyWith => _$ErrorTimePenaltyParamsCopyWithImpl<ErrorTimePenaltyParams>(this as ErrorTimePenaltyParams, _$identity);

  /// Serializes this ErrorTimePenaltyParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTimePenaltyParams&&(identical(other.seconds, seconds) || other.seconds == seconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seconds);

@override
String toString() {
  return 'ErrorTimePenaltyParams(seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class $ErrorTimePenaltyParamsCopyWith<$Res>  {
  factory $ErrorTimePenaltyParamsCopyWith(ErrorTimePenaltyParams value, $Res Function(ErrorTimePenaltyParams) _then) = _$ErrorTimePenaltyParamsCopyWithImpl;
@useResult
$Res call({
 int seconds
});




}
/// @nodoc
class _$ErrorTimePenaltyParamsCopyWithImpl<$Res>
    implements $ErrorTimePenaltyParamsCopyWith<$Res> {
  _$ErrorTimePenaltyParamsCopyWithImpl(this._self, this._then);

  final ErrorTimePenaltyParams _self;
  final $Res Function(ErrorTimePenaltyParams) _then;

/// Create a copy of ErrorTimePenaltyParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seconds = null,}) {
  return _then(_self.copyWith(
seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorTimePenaltyParams].
extension ErrorTimePenaltyParamsPatterns on ErrorTimePenaltyParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorTimePenaltyParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorTimePenaltyParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorTimePenaltyParams value)  $default,){
final _that = this;
switch (_that) {
case _ErrorTimePenaltyParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorTimePenaltyParams value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorTimePenaltyParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorTimePenaltyParams() when $default != null:
return $default(_that.seconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seconds)  $default,) {final _that = this;
switch (_that) {
case _ErrorTimePenaltyParams():
return $default(_that.seconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seconds)?  $default,) {final _that = this;
switch (_that) {
case _ErrorTimePenaltyParams() when $default != null:
return $default(_that.seconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorTimePenaltyParams implements ErrorTimePenaltyParams {
  const _ErrorTimePenaltyParams({required this.seconds});
  factory _ErrorTimePenaltyParams.fromJson(Map<String, dynamic> json) => _$ErrorTimePenaltyParamsFromJson(json);

@override final  int seconds;

/// Create a copy of ErrorTimePenaltyParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorTimePenaltyParamsCopyWith<_ErrorTimePenaltyParams> get copyWith => __$ErrorTimePenaltyParamsCopyWithImpl<_ErrorTimePenaltyParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorTimePenaltyParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorTimePenaltyParams&&(identical(other.seconds, seconds) || other.seconds == seconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seconds);

@override
String toString() {
  return 'ErrorTimePenaltyParams(seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class _$ErrorTimePenaltyParamsCopyWith<$Res> implements $ErrorTimePenaltyParamsCopyWith<$Res> {
  factory _$ErrorTimePenaltyParamsCopyWith(_ErrorTimePenaltyParams value, $Res Function(_ErrorTimePenaltyParams) _then) = __$ErrorTimePenaltyParamsCopyWithImpl;
@override @useResult
$Res call({
 int seconds
});




}
/// @nodoc
class __$ErrorTimePenaltyParamsCopyWithImpl<$Res>
    implements _$ErrorTimePenaltyParamsCopyWith<$Res> {
  __$ErrorTimePenaltyParamsCopyWithImpl(this._self, this._then);

  final _ErrorTimePenaltyParams _self;
  final $Res Function(_ErrorTimePenaltyParams) _then;

/// Create a copy of ErrorTimePenaltyParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seconds = null,}) {
  return _then(_ErrorTimePenaltyParams(
seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HintCooldownOverrideParams {

 Map<String, int> get cooldownsSec;
/// Create a copy of HintCooldownOverrideParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintCooldownOverrideParamsCopyWith<HintCooldownOverrideParams> get copyWith => _$HintCooldownOverrideParamsCopyWithImpl<HintCooldownOverrideParams>(this as HintCooldownOverrideParams, _$identity);

  /// Serializes this HintCooldownOverrideParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintCooldownOverrideParams&&const DeepCollectionEquality().equals(other.cooldownsSec, cooldownsSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cooldownsSec));

@override
String toString() {
  return 'HintCooldownOverrideParams(cooldownsSec: $cooldownsSec)';
}


}

/// @nodoc
abstract mixin class $HintCooldownOverrideParamsCopyWith<$Res>  {
  factory $HintCooldownOverrideParamsCopyWith(HintCooldownOverrideParams value, $Res Function(HintCooldownOverrideParams) _then) = _$HintCooldownOverrideParamsCopyWithImpl;
@useResult
$Res call({
 Map<String, int> cooldownsSec
});




}
/// @nodoc
class _$HintCooldownOverrideParamsCopyWithImpl<$Res>
    implements $HintCooldownOverrideParamsCopyWith<$Res> {
  _$HintCooldownOverrideParamsCopyWithImpl(this._self, this._then);

  final HintCooldownOverrideParams _self;
  final $Res Function(HintCooldownOverrideParams) _then;

/// Create a copy of HintCooldownOverrideParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cooldownsSec = null,}) {
  return _then(_self.copyWith(
cooldownsSec: null == cooldownsSec ? _self.cooldownsSec : cooldownsSec // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [HintCooldownOverrideParams].
extension HintCooldownOverrideParamsPatterns on HintCooldownOverrideParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HintCooldownOverrideParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HintCooldownOverrideParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HintCooldownOverrideParams value)  $default,){
final _that = this;
switch (_that) {
case _HintCooldownOverrideParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HintCooldownOverrideParams value)?  $default,){
final _that = this;
switch (_that) {
case _HintCooldownOverrideParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, int> cooldownsSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HintCooldownOverrideParams() when $default != null:
return $default(_that.cooldownsSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, int> cooldownsSec)  $default,) {final _that = this;
switch (_that) {
case _HintCooldownOverrideParams():
return $default(_that.cooldownsSec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, int> cooldownsSec)?  $default,) {final _that = this;
switch (_that) {
case _HintCooldownOverrideParams() when $default != null:
return $default(_that.cooldownsSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HintCooldownOverrideParams implements HintCooldownOverrideParams {
  const _HintCooldownOverrideParams({required final  Map<String, int> cooldownsSec}): _cooldownsSec = cooldownsSec;
  factory _HintCooldownOverrideParams.fromJson(Map<String, dynamic> json) => _$HintCooldownOverrideParamsFromJson(json);

 final  Map<String, int> _cooldownsSec;
@override Map<String, int> get cooldownsSec {
  if (_cooldownsSec is EqualUnmodifiableMapView) return _cooldownsSec;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_cooldownsSec);
}


/// Create a copy of HintCooldownOverrideParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintCooldownOverrideParamsCopyWith<_HintCooldownOverrideParams> get copyWith => __$HintCooldownOverrideParamsCopyWithImpl<_HintCooldownOverrideParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HintCooldownOverrideParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintCooldownOverrideParams&&const DeepCollectionEquality().equals(other._cooldownsSec, _cooldownsSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cooldownsSec));

@override
String toString() {
  return 'HintCooldownOverrideParams(cooldownsSec: $cooldownsSec)';
}


}

/// @nodoc
abstract mixin class _$HintCooldownOverrideParamsCopyWith<$Res> implements $HintCooldownOverrideParamsCopyWith<$Res> {
  factory _$HintCooldownOverrideParamsCopyWith(_HintCooldownOverrideParams value, $Res Function(_HintCooldownOverrideParams) _then) = __$HintCooldownOverrideParamsCopyWithImpl;
@override @useResult
$Res call({
 Map<String, int> cooldownsSec
});




}
/// @nodoc
class __$HintCooldownOverrideParamsCopyWithImpl<$Res>
    implements _$HintCooldownOverrideParamsCopyWith<$Res> {
  __$HintCooldownOverrideParamsCopyWithImpl(this._self, this._then);

  final _HintCooldownOverrideParams _self;
  final $Res Function(_HintCooldownOverrideParams) _then;

/// Create a copy of HintCooldownOverrideParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cooldownsSec = null,}) {
  return _then(_HintCooldownOverrideParams(
cooldownsSec: null == cooldownsSec ? _self._cooldownsSec : cooldownsSec // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}


/// @nodoc
mixin _$DecoyBlinkParams {

 int get count; int get intervalMs;
/// Create a copy of DecoyBlinkParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecoyBlinkParamsCopyWith<DecoyBlinkParams> get copyWith => _$DecoyBlinkParamsCopyWithImpl<DecoyBlinkParams>(this as DecoyBlinkParams, _$identity);

  /// Serializes this DecoyBlinkParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecoyBlinkParams&&(identical(other.count, count) || other.count == count)&&(identical(other.intervalMs, intervalMs) || other.intervalMs == intervalMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,intervalMs);

@override
String toString() {
  return 'DecoyBlinkParams(count: $count, intervalMs: $intervalMs)';
}


}

/// @nodoc
abstract mixin class $DecoyBlinkParamsCopyWith<$Res>  {
  factory $DecoyBlinkParamsCopyWith(DecoyBlinkParams value, $Res Function(DecoyBlinkParams) _then) = _$DecoyBlinkParamsCopyWithImpl;
@useResult
$Res call({
 int count, int intervalMs
});




}
/// @nodoc
class _$DecoyBlinkParamsCopyWithImpl<$Res>
    implements $DecoyBlinkParamsCopyWith<$Res> {
  _$DecoyBlinkParamsCopyWithImpl(this._self, this._then);

  final DecoyBlinkParams _self;
  final $Res Function(DecoyBlinkParams) _then;

/// Create a copy of DecoyBlinkParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? intervalMs = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,intervalMs: null == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DecoyBlinkParams].
extension DecoyBlinkParamsPatterns on DecoyBlinkParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecoyBlinkParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecoyBlinkParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecoyBlinkParams value)  $default,){
final _that = this;
switch (_that) {
case _DecoyBlinkParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecoyBlinkParams value)?  $default,){
final _that = this;
switch (_that) {
case _DecoyBlinkParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int intervalMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecoyBlinkParams() when $default != null:
return $default(_that.count,_that.intervalMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int intervalMs)  $default,) {final _that = this;
switch (_that) {
case _DecoyBlinkParams():
return $default(_that.count,_that.intervalMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int intervalMs)?  $default,) {final _that = this;
switch (_that) {
case _DecoyBlinkParams() when $default != null:
return $default(_that.count,_that.intervalMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DecoyBlinkParams implements DecoyBlinkParams {
  const _DecoyBlinkParams({required this.count, required this.intervalMs});
  factory _DecoyBlinkParams.fromJson(Map<String, dynamic> json) => _$DecoyBlinkParamsFromJson(json);

@override final  int count;
@override final  int intervalMs;

/// Create a copy of DecoyBlinkParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecoyBlinkParamsCopyWith<_DecoyBlinkParams> get copyWith => __$DecoyBlinkParamsCopyWithImpl<_DecoyBlinkParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DecoyBlinkParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecoyBlinkParams&&(identical(other.count, count) || other.count == count)&&(identical(other.intervalMs, intervalMs) || other.intervalMs == intervalMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,intervalMs);

@override
String toString() {
  return 'DecoyBlinkParams(count: $count, intervalMs: $intervalMs)';
}


}

/// @nodoc
abstract mixin class _$DecoyBlinkParamsCopyWith<$Res> implements $DecoyBlinkParamsCopyWith<$Res> {
  factory _$DecoyBlinkParamsCopyWith(_DecoyBlinkParams value, $Res Function(_DecoyBlinkParams) _then) = __$DecoyBlinkParamsCopyWithImpl;
@override @useResult
$Res call({
 int count, int intervalMs
});




}
/// @nodoc
class __$DecoyBlinkParamsCopyWithImpl<$Res>
    implements _$DecoyBlinkParamsCopyWith<$Res> {
  __$DecoyBlinkParamsCopyWithImpl(this._self, this._then);

  final _DecoyBlinkParams _self;
  final $Res Function(_DecoyBlinkParams) _then;

/// Create a copy of DecoyBlinkParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? intervalMs = null,}) {
  return _then(_DecoyBlinkParams(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,intervalMs: null == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WordMaskingParams {

 WordMaskMode get maskMode; bool get revealOnFound;
/// Create a copy of WordMaskingParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordMaskingParamsCopyWith<WordMaskingParams> get copyWith => _$WordMaskingParamsCopyWithImpl<WordMaskingParams>(this as WordMaskingParams, _$identity);

  /// Serializes this WordMaskingParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordMaskingParams&&(identical(other.maskMode, maskMode) || other.maskMode == maskMode)&&(identical(other.revealOnFound, revealOnFound) || other.revealOnFound == revealOnFound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maskMode,revealOnFound);

@override
String toString() {
  return 'WordMaskingParams(maskMode: $maskMode, revealOnFound: $revealOnFound)';
}


}

/// @nodoc
abstract mixin class $WordMaskingParamsCopyWith<$Res>  {
  factory $WordMaskingParamsCopyWith(WordMaskingParams value, $Res Function(WordMaskingParams) _then) = _$WordMaskingParamsCopyWithImpl;
@useResult
$Res call({
 WordMaskMode maskMode, bool revealOnFound
});




}
/// @nodoc
class _$WordMaskingParamsCopyWithImpl<$Res>
    implements $WordMaskingParamsCopyWith<$Res> {
  _$WordMaskingParamsCopyWithImpl(this._self, this._then);

  final WordMaskingParams _self;
  final $Res Function(WordMaskingParams) _then;

/// Create a copy of WordMaskingParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maskMode = null,Object? revealOnFound = null,}) {
  return _then(_self.copyWith(
maskMode: null == maskMode ? _self.maskMode : maskMode // ignore: cast_nullable_to_non_nullable
as WordMaskMode,revealOnFound: null == revealOnFound ? _self.revealOnFound : revealOnFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WordMaskingParams].
extension WordMaskingParamsPatterns on WordMaskingParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordMaskingParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordMaskingParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordMaskingParams value)  $default,){
final _that = this;
switch (_that) {
case _WordMaskingParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordMaskingParams value)?  $default,){
final _that = this;
switch (_that) {
case _WordMaskingParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WordMaskMode maskMode,  bool revealOnFound)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordMaskingParams() when $default != null:
return $default(_that.maskMode,_that.revealOnFound);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WordMaskMode maskMode,  bool revealOnFound)  $default,) {final _that = this;
switch (_that) {
case _WordMaskingParams():
return $default(_that.maskMode,_that.revealOnFound);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WordMaskMode maskMode,  bool revealOnFound)?  $default,) {final _that = this;
switch (_that) {
case _WordMaskingParams() when $default != null:
return $default(_that.maskMode,_that.revealOnFound);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordMaskingParams implements WordMaskingParams {
  const _WordMaskingParams({required this.maskMode, this.revealOnFound = true});
  factory _WordMaskingParams.fromJson(Map<String, dynamic> json) => _$WordMaskingParamsFromJson(json);

@override final  WordMaskMode maskMode;
@override@JsonKey() final  bool revealOnFound;

/// Create a copy of WordMaskingParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordMaskingParamsCopyWith<_WordMaskingParams> get copyWith => __$WordMaskingParamsCopyWithImpl<_WordMaskingParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordMaskingParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordMaskingParams&&(identical(other.maskMode, maskMode) || other.maskMode == maskMode)&&(identical(other.revealOnFound, revealOnFound) || other.revealOnFound == revealOnFound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maskMode,revealOnFound);

@override
String toString() {
  return 'WordMaskingParams(maskMode: $maskMode, revealOnFound: $revealOnFound)';
}


}

/// @nodoc
abstract mixin class _$WordMaskingParamsCopyWith<$Res> implements $WordMaskingParamsCopyWith<$Res> {
  factory _$WordMaskingParamsCopyWith(_WordMaskingParams value, $Res Function(_WordMaskingParams) _then) = __$WordMaskingParamsCopyWithImpl;
@override @useResult
$Res call({
 WordMaskMode maskMode, bool revealOnFound
});




}
/// @nodoc
class __$WordMaskingParamsCopyWithImpl<$Res>
    implements _$WordMaskingParamsCopyWith<$Res> {
  __$WordMaskingParamsCopyWithImpl(this._self, this._then);

  final _WordMaskingParams _self;
  final $Res Function(_WordMaskingParams) _then;

/// Create a copy of WordMaskingParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maskMode = null,Object? revealOnFound = null,}) {
  return _then(_WordMaskingParams(
maskMode: null == maskMode ? _self.maskMode : maskMode // ignore: cast_nullable_to_non_nullable
as WordMaskMode,revealOnFound: null == revealOnFound ? _self.revealOnFound : revealOnFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ShuffleWordListParams {

 ShuffleWordListOn get on; bool get enabled;
/// Create a copy of ShuffleWordListParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShuffleWordListParamsCopyWith<ShuffleWordListParams> get copyWith => _$ShuffleWordListParamsCopyWithImpl<ShuffleWordListParams>(this as ShuffleWordListParams, _$identity);

  /// Serializes this ShuffleWordListParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShuffleWordListParams&&(identical(other.on, on) || other.on == on)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,on,enabled);

@override
String toString() {
  return 'ShuffleWordListParams(on: $on, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $ShuffleWordListParamsCopyWith<$Res>  {
  factory $ShuffleWordListParamsCopyWith(ShuffleWordListParams value, $Res Function(ShuffleWordListParams) _then) = _$ShuffleWordListParamsCopyWithImpl;
@useResult
$Res call({
 ShuffleWordListOn on, bool enabled
});




}
/// @nodoc
class _$ShuffleWordListParamsCopyWithImpl<$Res>
    implements $ShuffleWordListParamsCopyWith<$Res> {
  _$ShuffleWordListParamsCopyWithImpl(this._self, this._then);

  final ShuffleWordListParams _self;
  final $Res Function(ShuffleWordListParams) _then;

/// Create a copy of ShuffleWordListParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? on = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
on: null == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as ShuffleWordListOn,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ShuffleWordListParams].
extension ShuffleWordListParamsPatterns on ShuffleWordListParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShuffleWordListParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShuffleWordListParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShuffleWordListParams value)  $default,){
final _that = this;
switch (_that) {
case _ShuffleWordListParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShuffleWordListParams value)?  $default,){
final _that = this;
switch (_that) {
case _ShuffleWordListParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ShuffleWordListOn on,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShuffleWordListParams() when $default != null:
return $default(_that.on,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ShuffleWordListOn on,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _ShuffleWordListParams():
return $default(_that.on,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ShuffleWordListOn on,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _ShuffleWordListParams() when $default != null:
return $default(_that.on,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShuffleWordListParams implements ShuffleWordListParams {
  const _ShuffleWordListParams({this.on = ShuffleWordListOn.start, this.enabled = true});
  factory _ShuffleWordListParams.fromJson(Map<String, dynamic> json) => _$ShuffleWordListParamsFromJson(json);

@override@JsonKey() final  ShuffleWordListOn on;
@override@JsonKey() final  bool enabled;

/// Create a copy of ShuffleWordListParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShuffleWordListParamsCopyWith<_ShuffleWordListParams> get copyWith => __$ShuffleWordListParamsCopyWithImpl<_ShuffleWordListParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShuffleWordListParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShuffleWordListParams&&(identical(other.on, on) || other.on == on)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,on,enabled);

@override
String toString() {
  return 'ShuffleWordListParams(on: $on, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ShuffleWordListParamsCopyWith<$Res> implements $ShuffleWordListParamsCopyWith<$Res> {
  factory _$ShuffleWordListParamsCopyWith(_ShuffleWordListParams value, $Res Function(_ShuffleWordListParams) _then) = __$ShuffleWordListParamsCopyWithImpl;
@override @useResult
$Res call({
 ShuffleWordListOn on, bool enabled
});




}
/// @nodoc
class __$ShuffleWordListParamsCopyWithImpl<$Res>
    implements _$ShuffleWordListParamsCopyWith<$Res> {
  __$ShuffleWordListParamsCopyWithImpl(this._self, this._then);

  final _ShuffleWordListParams _self;
  final $Res Function(_ShuffleWordListParams) _then;

/// Create a copy of ShuffleWordListParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? on = null,Object? enabled = null,}) {
  return _then(_ShuffleWordListParams(
on: null == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as ShuffleWordListOn,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
