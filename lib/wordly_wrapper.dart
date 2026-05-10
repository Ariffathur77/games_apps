import 'package:flutter/material.dart';
import 'package:wordly/src/feature/app/logic/composition_root.dart';
import 'package:wordly/src/feature/app/widget/dependencies_scope.dart';
import 'package:wordly/src/feature/app/widget/bloc_scope.dart';
import 'package:wordly/src/core/ui_lib/ui_library.dart';
import 'package:wordly/src/feature/game/widget/game_page.dart';
import 'package:wordly/src/feature/settings/settings.dart';
import 'package:wordly/src/core/resources/resources.dart';
import 'package:wordly/src/core/constant/generated/fonts.gen.dart';

class WordlyWrapper extends StatelessWidget {
  const WordlyWrapper({required this.compositionResult, super.key});
  final CompositionResult compositionResult;

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: compositionResult.dependencies,
      child: SettingsBuilder(
        builder: (context, settings) {
          return BlocScope(
            child: WindowSizeScope(
              child: Theme(
                data: ThemeData(
                  colorSchemeSeed: AppColors.green,
                  fontFamily: FontFamily.nunito,
                ),
                child: const GamePage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
