import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/di.dart';
import 'core/navigation/router.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(Phase 4): await dotenv.load(fileName: '.env', isOptional: true);
  await configureDependencies();
  runApp(const ProviderScope(child: PitboxWallApp()));
}

class PitboxWallApp extends StatelessWidget {
  const PitboxWallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pitbox Wall',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
