enum SpellTapAssistLevel {
  full,
  medium,
  low,
  adaptive;

  static SpellTapAssistLevel? tryParse(String? raw) {
    switch (raw?.trim().toLowerCase()) {
      case 'full':
        return SpellTapAssistLevel.full;
      case 'medium':
        return SpellTapAssistLevel.medium;
      case 'low':
        return SpellTapAssistLevel.low;
      case 'adaptive':
        return SpellTapAssistLevel.adaptive;
      default:
        return null;
    }
  }
}

