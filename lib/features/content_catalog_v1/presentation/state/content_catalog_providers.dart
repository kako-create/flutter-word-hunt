import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../word_hunt/di/word_hunt_progress_providers.dart';
import '../../../wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import '../../data/repositories/asset_content_catalog_repository_v1.dart';
import '../../data/sources/asset_catalog_source.dart';
import '../../domain/entities/content_catalog_v1.dart';
import '../../domain/repositories/content_catalog_repository.dart';
import '../../domain/services/puzzle_completion_service.dart';

final catalogSourceProvider = Provider((ref) => AssetCatalogSource());

final contentCatalogRepositoryProvider = Provider<ContentCatalogRepository>(
  (ref) =>
      AssetContentCatalogRepositoryV1(source: ref.read(catalogSourceProvider)),
);

final contentCatalogProvider = FutureProvider<ContentCatalogV1>((ref) async {
  final repo = ref.read(contentCatalogRepositoryProvider);
  return repo.load();
});

final puzzleCompletionServiceProvider =
    Provider.autoDispose<PuzzleCompletionService>((ref) {
      final catalogRepo = ref.read(contentCatalogRepositoryProvider);
      final puzzleRepo = ref.read(puzzleRepositoryV1Provider);
      final progressRepo = ref.read(progressRepositoryProvider);

      return PuzzleCompletionService(
        catalogRepository: catalogRepo,
        puzzleRepository: puzzleRepo,
        progressRepository: progressRepo,
      );
    });
