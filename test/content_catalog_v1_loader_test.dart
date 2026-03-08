import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/content_catalog_v1/data/repositories/asset_content_catalog_repository_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/entities/catalog_index_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/entities/catalog_item_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/entities/catalog_ui_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/errors/catalog_exceptions.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/sources/catalog_source.dart';

class InMemoryCatalogSource implements CatalogSource {
  final Map<String, String> files;

  InMemoryCatalogSource(this.files);

  @override
  String get sourceId => 'mem';

  @override
  Future<String> loadString(String path) async {
    final v = files[path];
    if (v == null) {
      throw CatalogNotFoundException('Arquivo nao encontrado: "$path"');
    }
    return v;
  }
}

void main() {
  group('ContentCatalogLoaderV1', () {
    test('resolve refs relativos e indexa por absNodeId', () async {
      final src = InMemoryCatalogSource({
        'assets/puzzles/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'global',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'temas', 'ref': 'temas/index.json'},
          ],
        }),
        'assets/puzzles/temas/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'root',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'starter', 'ref': 'starter/index.json'},
          ],
        }),
        'assets/puzzles/temas/starter/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'starter',
          'contentVersion': 1,
          'items': [],
        }),
      });

      final repo = AssetContentCatalogRepositoryV1(source: src);
      final catalog = await repo.load(
        globalIndexPath: 'assets/puzzles/index.json',
      );

      expect(catalog.packRootAbsNodeIdByPackId['temas'], 'temas/root');
      expect(catalog.nodesByAbsId.containsKey('temas/root'), isTrue);
      expect(catalog.nodesByAbsId.containsKey('temas/starter'), isTrue);

      final root = catalog.nodesByAbsId['temas/root']!;
      expect(root.childAbsNodeIdByItemId['starter'], 'temas/starter');
    });

    test('ref invalido (..) falha', () async {
      final src = InMemoryCatalogSource({
        'assets/puzzles/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'global',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'temas', 'ref': 'temas/index.json'},
          ],
        }),
        'assets/puzzles/temas/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'root',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'x', 'ref': '../evil.json'},
          ],
        }),
      });

      final repo = AssetContentCatalogRepositoryV1(source: src);
      expect(
        () => repo.load(globalIndexPath: 'assets/puzzles/index.json'),
        throwsA(isA<CatalogValidationException>()),
      );
    });

    test('ref invalido (:) falha', () async {
      final src = InMemoryCatalogSource({
        'assets/puzzles/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'global',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'temas', 'ref': 'temas/index.json'},
          ],
        }),
        'assets/puzzles/temas/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'root',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'x', 'ref': 'C:/evil.json'},
          ],
        }),
      });

      final repo = AssetContentCatalogRepositoryV1(source: src);
      expect(
        () => repo.load(globalIndexPath: 'assets/puzzles/index.json'),
        throwsA(isA<CatalogValidationException>()),
      );
    });

    test('ref invalido (absoluto) falha', () async {
      final src = InMemoryCatalogSource({
        'assets/puzzles/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'global',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'temas', 'ref': 'temas/index.json'},
          ],
        }),
        'assets/puzzles/temas/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'root',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'x', 'ref': '/evil.json'},
          ],
        }),
      });

      final repo = AssetContentCatalogRepositoryV1(source: src);
      expect(
        () => repo.load(globalIndexPath: 'assets/puzzles/index.json'),
        throwsA(isA<CatalogValidationException>()),
      );
    });

    test('ref invalido (sem .json) falha', () async {
      final src = InMemoryCatalogSource({
        'assets/puzzles/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'global',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'temas', 'ref': 'temas/index.json'},
          ],
        }),
        'assets/puzzles/temas/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'root',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'x', 'ref': 'evil.txt'},
          ],
        }),
      });

      final repo = AssetContentCatalogRepositoryV1(source: src);
      expect(
        () => repo.load(globalIndexPath: 'assets/puzzles/index.json'),
        throwsA(isA<CatalogValidationException>()),
      );
    });

    test('ciclo A -> B -> A falha (CatalogCycleException)', () async {
      final src = InMemoryCatalogSource({
        'assets/puzzles/index.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'global',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'temas', 'ref': 'temas/a.json'},
          ],
        }),
        'assets/puzzles/temas/a.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'a',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'b', 'ref': 'b.json'},
          ],
        }),
        'assets/puzzles/temas/b.json': jsonEncode({
          'schema': wordsearchCatalogSchemaV1,
          'id': 'b',
          'contentVersion': 1,
          'items': [
            {'kind': 'folder', 'id': 'a2', 'ref': 'a.json'},
          ],
        }),
      });

      final repo = AssetContentCatalogRepositoryV1(source: src);
      expect(
        () => repo.load(globalIndexPath: 'assets/puzzles/index.json'),
        throwsA(isA<CatalogCycleException>()),
      );
    });

    test('unknown layout faz fallback para list', () {
      final index = CatalogIndexV1.fromJson({
        'schema': wordsearchCatalogSchemaV1,
        'id': 'global',
        'contentVersion': 1,
        'ui': {'layout': 'nao_existe'},
        'items': [],
      });

      expect(index.ui.layout, CatalogLayout.unknown);
      expect(index.ui.effectiveLayout, CatalogLayout.list);
    });

    test('folder parseia extensions.education', () {
      final index = CatalogIndexV1.fromJson({
        'schema': wordsearchCatalogSchemaV1,
        'id': 'root',
        'contentVersion': 1,
        'items': [
          {
            'kind': 'folder',
            'id': 'cap_1',
            'ref': 'cap_1/index.json',
            'extensions': {
              'education': {
                'trackId': 'kids_track',
                'order': 1,
                'minCompleted': 7,
              },
            },
          },
        ],
      });

      final folder = index.items.single as CatalogFolderItemV1;
      final education = folder.education;
      expect(education, isNotNull);
      expect(education!.trackId, 'kids_track');
      expect(education.order, 1);
      expect(education.minCompleted, 7);
      expect(education.minCompletedOrNull, 7);
      expect(education.hasMinCompleted, isTrue);
    });

    test('folder education sem minCompleted preserva fallback por total', () {
      final index = CatalogIndexV1.fromJson({
        'schema': wordsearchCatalogSchemaV1,
        'id': 'root',
        'contentVersion': 1,
        'items': [
          {
            'kind': 'folder',
            'id': 'cap_2',
            'ref': 'cap_2/index.json',
            'extensions': {
              'education': {'trackId': 'kids_track', 'order': 2},
            },
          },
        ],
      });

      final folder = index.items.single as CatalogFolderItemV1;
      final education = folder.education;
      expect(education, isNotNull);
      expect(education!.minCompleted, 0);
      expect(education.minCompletedOrNull, isNull);
      expect(education.hasMinCompleted, isFalse);
    });
  });
}
