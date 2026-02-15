import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/i18n/app_strings_pt_br.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class WordHuntApp extends StatelessWidget {
  const WordHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStringsPtBr.appTitle,
      theme: AppTheme.light(),
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.start,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
