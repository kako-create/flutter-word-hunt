class PuzzleSummary {
  final String id;
  final String title;
  final int rows;
  final int cols;

  const PuzzleSummary({
    required this.id,
    required this.title,
    required this.rows,
    required this.cols,
  });

  String get sizeLabel => '${cols}x$rows';
}

