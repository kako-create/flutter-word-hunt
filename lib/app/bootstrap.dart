import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_widget.dart';

void bootstrap() {
  runApp(
    const ProviderScope(
      child: WordHuntApp(),
    ),
  );
}

