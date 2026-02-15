import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/asset_puzzle_repository_v1.dart';
import '../domain/repositories/puzzle_repository_v1.dart';

final puzzleRepositoryV1Provider = Provider<PuzzleRepositoryV1>(
  (ref) => AssetPuzzleRepositoryV1(),
);

