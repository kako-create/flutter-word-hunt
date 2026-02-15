import '../../domain/entities/cell_coord.dart';

class FoundWordSpan {
  final CellCoord start;
  final CellCoord end;

  const FoundWordSpan({
    required this.start,
    required this.end,
  });
}
