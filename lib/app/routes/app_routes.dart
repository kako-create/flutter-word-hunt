import 'package:flutter/material.dart';

import '../screens/start_screen.dart';
import '../screens/themes_screen.dart';
import '../../features/content_catalog_v1/presentation/screens/catalog_folder_screen.dart';
import '../../features/content_catalog_v1/presentation/screens/catalog_root_screen.dart';
import '../../features/content_catalog_v1/presentation/screens/catalog_route_args.dart';
import '../../features/word_hunt/presentation/screens/word_hunt_screen.dart';
import '../../features/word_hunt/domain/entities/word_hunt_session.dart';

class AppRoutes {
  static const String start = '/';
  static const String wordHunt = '/word_hunt';
  static const String themes = '/themes';
  static const String catalog = '/catalog';
  static const String catalogFolder = '/catalog/folder';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case wordHunt:
        final arg = settings.arguments;
        final session = arg is WordHuntSession ? arg : null;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => WordHuntScreen(session: session),
        );
      case themes:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ThemesScreen(),
        );
      case catalog:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CatalogRootScreen(),
        );
      case catalogFolder:
        final arg = settings.arguments;
        final args = arg is CatalogFolderRouteArgs ? arg : null;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CatalogFolderScreen(
            args: args ?? const CatalogFolderRouteArgs(absNodeId: ''),
          ),
        );
      case start:
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => StartScreen(
            onStart: (session) => Navigator.of(context).pushReplacementNamed(
              wordHunt,
              arguments: session,
            ),
          ),
        );
    }
  }
}
