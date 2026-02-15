import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/validation/puzzle_validator.dart';

void main() {
  test('assets/puzzles/**/*.json seguem schema v1 e validam', () async {
    final dir = Directory('assets/puzzles');
    expect(await dir.exists(), isTrue);

    final files = <File>[];
    for (final entity in dir.listSync(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.toLowerCase().endsWith('.json')) {
        files.add(entity);
      }
    }
    files.sort((a, b) => a.path.compareTo(b.path));

    expect(files, isNotEmpty);

    for (final file in files) {
      final decoded = jsonDecode(await file.readAsString());
      expect(decoded, isA<Map>());

      final raw = (decoded as Map).cast<String, Object?>();
      expect(raw['schema'], wordsearchPuzzleSchemaV1, reason: file.path);

      final parsed = PuzzleV1.fromJson(raw.cast<String, dynamic>());
      final withDefaults = PuzzleDefaults.apply(parsed);

      final errors = PuzzleValidator.validate(withDefaults);
      expect(errors, isEmpty, reason: file.path);
    }
  });
}
