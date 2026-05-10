import 'package:flutter/material.dart';
import 'package:games_apps/wordly_wrapper.dart';
//! Ludo Game
import 'package:ludo_game/main.dart' as ludo;
import 'package:ludo_game/injection.dart';
//! Wordly Game
import 'package:wordly/src/feature/app/widget/root_context.dart';
import 'package:wordly/src/feature/app/logic/composition_root.dart';
import 'package:wordly/src/feature/app/model/application_config.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:bloc/bloc.dart' show Bloc;
import 'package:wordly/src/feature/app/bloc/app_bloc_observer.dart';
import 'package:wordly/src/feature/app/bloc/bloc_transformer.dart';
import 'package:logger/logger.dart' as l;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wordly/src/core/constant/localization/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: [
        GeneratedLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ru')],

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Games App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // Tombol Game Ludo
            GestureDetector(
              onTap: () {
                setupDependencyInjection();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ludo.LudoGame()),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.casino, size: 60, color: Colors.deepPurple),
                    SizedBox(height: 8),
                    Text(
                      'Ludo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                l.createAppLogger(observers: []);
                const config = ApplicationConfig();
                Bloc.observer = AppBlocObserver(l.logger);
                Bloc.transformer =
                    SequentialBlocTransformer<Object?>().transform;
                final compositionResult = await composeDependencies(
                  config: config,
                );
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WordlyWrapper(compositionResult: compositionResult),
                    ),
                  );
                }
              },

              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.casino, size: 60, color: Colors.deepPurple),
                    SizedBox(height: 8),
                    Text(
                      'Wordly',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tambah game lain nanti di sini
          ],
        ),
      ),
    );
  }
}
