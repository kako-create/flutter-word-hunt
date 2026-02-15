import 'package:flutter/material.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../domain/entities/word_target.dart';

class WordList extends StatelessWidget {
  final List<WordTarget> targets;
  final Map<String, int> foundWordColorsById;
  final String? nextOrderedWordId;

  const WordList({
    super.key,
    required this.targets,
    required this.foundWordColorsById,
    this.nextOrderedWordId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Wrap(
        spacing: AppUiConstants.chipSpacing,
        runSpacing: AppUiConstants.chipSpacing,
        children: [
          for (final target in targets)
            _WordChip(
              word: target.display,
              colorValue: foundWordColorsById[target.id],
              defaultColor: colorScheme.surfaceContainerHighest,
              isNext: nextOrderedWordId != null && nextOrderedWordId == target.id,
              nextColor: colorScheme.primary,
            ),
        ],
      ),
    );
  }
}

class _WordChip extends StatelessWidget {
  final String word;
  final int? colorValue;
  final Color defaultColor;
  final bool isNext;
  final Color nextColor;

  const _WordChip({
    required this.word,
    required this.colorValue,
    required this.defaultColor,
    required this.isNext,
    required this.nextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isFound = colorValue != null;
    final baseColor = colorValue == null ? null : Color(colorValue!);

    final backgroundColor = isFound
        ? baseColor!.withAlpha((AppUiConstants.foundFillOpacity * 255).round())
        : defaultColor;

    final sideColor = isFound
        ? baseColor!.withAlpha((AppUiConstants.foundBorderOpacity * 255).round())
        : (isNext ? nextColor : Colors.transparent);

    return Chip(
      backgroundColor: backgroundColor,
      avatar: isNext && !isFound
          ? Icon(Icons.play_arrow, size: 18, color: nextColor)
          : null,
      label: Text(
        word,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          decoration: isFound ? TextDecoration.lineThrough : null,
        ),
      ),
      side: BorderSide(
        color: sideColor,
        width: (isFound || isNext) ? 1 : 0,
      ),
    );
  }
}
