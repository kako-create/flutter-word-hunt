enum ProgressionModeV1 {
  none,
  sequential,
}

ProgressionModeV1 parseProgressionMode(Object? raw) {
  if (raw is! String) return ProgressionModeV1.none;
  switch (raw) {
    case 'sequential':
      return ProgressionModeV1.sequential;
    case 'none':
    default:
      return ProgressionModeV1.none;
  }
}

class ProgressionV1 {
  final ProgressionModeV1 mode;
  final int clearThresholdPct; // 0..100

  const ProgressionV1({
    required this.mode,
    required this.clearThresholdPct,
  });

  factory ProgressionV1.none() =>
      const ProgressionV1(mode: ProgressionModeV1.none, clearThresholdPct: 100);

  factory ProgressionV1.fromJson(Object? raw) {
    if (raw == null) return ProgressionV1.none();
    if (raw is! Map) return ProgressionV1.none();

    final mode = parseProgressionMode(raw['mode']);
    final clearThresholdPctRaw = raw['clearThresholdPct'];

    final clearThresholdPct = clearThresholdPctRaw is int
        ? clearThresholdPctRaw
        : (clearThresholdPctRaw is num ? clearThresholdPctRaw.round() : 100);

    return ProgressionV1(
      mode: mode,
      clearThresholdPct: clearThresholdPct.clamp(0, 100),
    );
  }
}

