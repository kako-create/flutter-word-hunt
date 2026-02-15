class AccessRuleV1 {
  final String type; // free | entitlement | unknown
  final String? productId;

  const AccessRuleV1({
    required this.type,
    this.productId,
  });

  factory AccessRuleV1.free() => const AccessRuleV1(type: 'free');

  factory AccessRuleV1.fromJson(Object? raw) {
    if (raw == null) return AccessRuleV1.free();
    if (raw is! Map) return const AccessRuleV1(type: 'unknown');

    final type = raw['type'];
    if (type is! String || type.trim().isEmpty) {
      return const AccessRuleV1(type: 'unknown');
    }

    final productId = raw['productId'];
    return AccessRuleV1(
      type: type,
      productId: productId is String && productId.trim().isNotEmpty ? productId : null,
    );
  }
}

