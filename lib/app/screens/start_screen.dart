import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/ui_constants.dart';
import '../../core/i18n/app_strings_pt_br.dart';
import '../../features/word_hunt/domain/entities/word_hunt_session.dart';
import '../../features/word_hunt/presentation/state/word_hunt_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/app_footer_bar.dart';

class StartScreen extends ConsumerWidget {
  final ValueChanged<WordHuntSession?> onStart;

  const StartScreen({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final lastSessionAsync = ref.watch(lastSessionProvider);

    return Scaffold(
      bottomNavigationBar: const AppFooterBar(),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(AppUiConstants.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppUiConstants.startTopSpacing),
              Center(
                child: Icon(
                  Icons.grid_on,
                  size: AppUiConstants.startHeroIconSize,
                ),
              ),
              const SizedBox(height: AppUiConstants.sectionSpacing),
              Text(
                AppStringsPtBr.appTitle,
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppUiConstants.sectionSpacing),
              Text(
                AppStringsPtBr.startSubtitle,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: AppUiConstants.sectionSpacing),
              lastSessionAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (session) {
                  if (session == null) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppUiConstants.sectionSpacing,
                    ),
                    child: FilledButton.icon(
                      onPressed: () => onStart(session),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text(AppStringsPtBr.continueLastGame),
                    ),
                  );
                },
              ),
              Text(
                AppStringsPtBr.choosePuzzle,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppUiConstants.sectionSpacing),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.themes),
                icon: const Icon(Icons.category),
                label: const Text(AppStringsPtBr.themes),
              ),
              const SizedBox(height: AppUiConstants.sectionSpacing),
              const Spacer(),
              const SizedBox(height: AppUiConstants.sectionSpacing),
              FilledButton.icon(
                onPressed: () => onStart(null),
                icon: const Icon(Icons.shuffle),
                label: const Text(AppStringsPtBr.playRandom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
