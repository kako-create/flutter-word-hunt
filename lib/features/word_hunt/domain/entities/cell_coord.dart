class CellCoord {
  final int row;
  final int col;

  const CellCoord(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CellCoord && runtimeType == other.runtimeType && row == other.row && col == other.col;

  @override
  int get hashCode => Object.hash(row, col);

  @override
  String toString() => 'CellCoord(row: $row, col: $col)';
}

