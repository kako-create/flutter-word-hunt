import 'package:flutter/material.dart';

import '../../core/i18n/app_strings_pt_br.dart';

class AppFooterBar extends StatelessWidget {
  final String text;

  const AppFooterBar({
    super.key,
    this.text = AppStringsPtBr.appTitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colorScheme.primary,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 44,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

