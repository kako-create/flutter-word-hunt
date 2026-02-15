import 'package:flutter/material.dart';

class AppUiConstants {
  static const int gridFlex = 7;
  static const int wordsFlex = 3;

  static const double screenPadding = 16;
  static const double sectionSpacing = 12;

  static const double startTopSpacing = 48;
  static const double startHeroIconSize = 72;

  static const double gridCornerRadius = 12;
  static const double cellBorderWidth = 0.6;
  static const double cellSelectedBorderWidth = 1.6;
  static const double cellFoundBorderWidth = 1.2;

  // Mais "respiro" entre letras: fonte escala + padding interno.
  static const double cellInnerPadding = 1.0;
  static const double cellFontScale = 0.72;
  static const double minCellFontSize = 10;
  static const double maxCellFontSize = 20;

  static const Duration cellAnimationDuration = Duration(milliseconds: 80);

  static const double chipSpacing = 8;

  static const double foundFillOpacity = 0.22;
  static const double foundBorderOpacity = 0.85;

  // Destaque arredondado ("pill") para selecao e palavras encontradas.
  // A espessura eh proporcional ao tamanho da celula do grid.
  static const double pathOuterStrokeScale = 0.92;
  static const double pathInnerStrokeScale = 0.78;

  static const double foundPathFillOpacity = 0.65;
  static const double foundPathBorderOpacity = 0.92;

  static const double selectionPathFillOpacity = 0.35;
  static const double selectionPathBorderOpacity = 0.90;

  static const List<Color> foundWordPalette = [
    Color(0xFFE53935),
    Color(0xFFD81B60),
    Color(0xFF8E24AA),
    Color(0xFF3949AB),
    Color(0xFF1E88E5),
    Color(0xFF00897B),
    Color(0xFF43A047),
    Color(0xFF7CB342),
    Color(0xFFFB8C00),
    Color(0xFFF4511E),
    Color(0xFF6D4C41),
    Color(0xFF546E7A),
  ];

  static const Color seedColor = Color(0xFF0B57D0);
  static const Color scaffoldBackgroundColor = Color(0xFFF6F5F2);
  static const Color gridBackgroundColor = Colors.white;
}
