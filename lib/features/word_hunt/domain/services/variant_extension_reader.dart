import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

class VariantExtensionReader {
  final Map<String, Object?> _root;

  VariantExtensionReader._(this._root);

  factory VariantExtensionReader.fromVariant(PuzzleVariant variant) {
    return VariantExtensionReader.fromExtensions(variant.extensions);
  }

  factory VariantExtensionReader.fromExtensions(JsonMap? extensions) {
    return VariantExtensionReader._(_asStringMap(extensions) ?? const {});
  }

  Map<String, Object?> get root => Map.unmodifiable(_root);

  String? string(String key) => _asString(_root[key]);

  bool? boolValue(String key) => _asBool(_root[key]);

  int? intValue(String key) => _asInt(_root[key]);

  double? doubleValue(String key) => _asDouble(_root[key]);

  VariantExtensionReader? nested(String key) {
    final map = _asStringMap(_root[key]);
    if (map == null) return null;
    return VariantExtensionReader._(map);
  }

  static Map<String, Object?>? _asStringMap(Object? raw) {
    if (raw is! Map) return null;

    final out = <String, Object?>{};
    for (final entry in raw.entries) {
      final key = entry.key;
      if (key is! String) return null;
      out[key] = entry.value;
    }
    return out;
  }

  static String? _asString(Object? raw) {
    if (raw is! String) return null;
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  static bool? _asBool(Object? raw) {
    if (raw is bool) return raw;
    if (raw is num) return raw != 0;
    if (raw is String) {
      final value = raw.trim().toLowerCase();
      if (value == 'true' || value == '1') return true;
      if (value == 'false' || value == '0') return false;
    }
    return null;
  }

  static int? _asInt(Object? raw) {
    if (raw is int) return raw;
    if (raw is num) return raw.round();
    if (raw is String) return int.tryParse(raw.trim());
    return null;
  }

  static double? _asDouble(Object? raw) {
    if (raw is double) return raw;
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw.trim());
    return null;
  }
}
