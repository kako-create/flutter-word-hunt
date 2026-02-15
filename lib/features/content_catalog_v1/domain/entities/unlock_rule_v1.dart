enum UnlockRuleTypeV1 {
  always,
  completionPercent,
  unknown,
}

UnlockRuleTypeV1 parseUnlockRuleType(Object? raw) {
  if (raw is! String) return UnlockRuleTypeV1.unknown;
  switch (raw) {
    case 'always':
      return UnlockRuleTypeV1.always;
    case 'completion_percent':
      return UnlockRuleTypeV1.completionPercent;
    default:
      return UnlockRuleTypeV1.unknown;
  }
}

enum UnlockScopeV1 {
  self,
  parent,
  node,
  unknown,
}

UnlockScopeV1 parseUnlockScope(Object? raw) {
  if (raw is! String) return UnlockScopeV1.unknown;
  switch (raw) {
    case 'self':
      return UnlockScopeV1.self;
    case 'parent':
      return UnlockScopeV1.parent;
    case 'node':
      return UnlockScopeV1.node;
    default:
      return UnlockScopeV1.unknown;
  }
}

enum ThresholdModeV1 {
  descendants,
  directChildren,
  unknown,
}

ThresholdModeV1 parseThresholdMode(Object? raw) {
  if (raw is! String) return ThresholdModeV1.unknown;
  switch (raw) {
    case 'descendants':
      return ThresholdModeV1.descendants;
    case 'directChildren':
      return ThresholdModeV1.directChildren;
    default:
      return ThresholdModeV1.unknown;
  }
}

sealed class UnlockRuleV1 {
  UnlockRuleTypeV1 get type;

  const UnlockRuleV1();

  factory UnlockRuleV1.fromJson(Object? raw) {
    if (raw == null) return const UnlockAlwaysV1();
    if (raw is! Map) return const UnlockUnknownV1();

    final type = parseUnlockRuleType(raw['type']);
    switch (type) {
      case UnlockRuleTypeV1.always:
        return const UnlockAlwaysV1();
      case UnlockRuleTypeV1.completionPercent:
        return UnlockCompletionPercentV1.fromJson(raw);
      case UnlockRuleTypeV1.unknown:
        return const UnlockUnknownV1();
    }
  }
}

final class UnlockAlwaysV1 extends UnlockRuleV1 {
  const UnlockAlwaysV1();

  @override
  UnlockRuleTypeV1 get type => UnlockRuleTypeV1.always;
}

final class UnlockCompletionPercentV1 extends UnlockRuleV1 {
  final UnlockScopeV1 scope;
  final String? nodeAbsId;
  final int pct; // 0..100
  final ThresholdModeV1 thresholdMode;

  const UnlockCompletionPercentV1({
    required this.scope,
    required this.nodeAbsId,
    required this.pct,
    required this.thresholdMode,
  });

  factory UnlockCompletionPercentV1.fromJson(Map raw) {
    final scope = parseUnlockScope(raw['scope']);
    final nodeAbsIdRaw = raw['nodeAbsId'];
    final pctRaw = raw['pct'];
    final thresholdMode = parseThresholdMode(raw['thresholdMode']);

    final pct = pctRaw is int ? pctRaw : (pctRaw is num ? pctRaw.round() : 0);

    return UnlockCompletionPercentV1(
      scope: scope,
      nodeAbsId: nodeAbsIdRaw is String && nodeAbsIdRaw.trim().isNotEmpty
          ? nodeAbsIdRaw
          : null,
      pct: pct.clamp(0, 100),
      thresholdMode: thresholdMode,
    );
  }

  @override
  UnlockRuleTypeV1 get type => UnlockRuleTypeV1.completionPercent;
}

final class UnlockUnknownV1 extends UnlockRuleV1 {
  const UnlockUnknownV1();

  @override
  UnlockRuleTypeV1 get type => UnlockRuleTypeV1.unknown;
}

