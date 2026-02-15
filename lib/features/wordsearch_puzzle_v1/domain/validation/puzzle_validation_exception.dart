import '../../../../core/errors/app_exception.dart';

import 'puzzle_validator.dart';

class PuzzleV1ValidationException extends AppException {
  final List<PuzzleValidationError> errors;

  PuzzleV1ValidationException({
    required String puzzleId,
    required this.errors,
  }) : super('Puzzle "$puzzleId" invalido: ${errors.length} erro(s).');

  @override
  String toString() {
    final details = errors.map((e) => e.toString()).join('\n');
    return '${super.toString()}\n$details';
  }
}
