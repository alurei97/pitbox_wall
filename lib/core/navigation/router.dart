import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai_assistant/presentation/pages/ai_page.dart';
import '../../features/constructor/presentation/pages/constructor_card_page.dart';
import '../../features/driver/presentation/pages/driver_card_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/results/presentation/pages/race_weekend_page.dart';
import '../../features/schedule/domain/entities/race.dart';
import '../../features/schedule/presentation/pages/schedule_page.dart';
import '../../features/standings/domain/entities/driver_standing.dart';
import '../../features/standings/presentation/pages/standings_page.dart';
import '../../shared/widgets/app_scaffold.dart';

final _homeKey = GlobalKey<NavigatorState>();
final _scheduleKey = GlobalKey<NavigatorState>();
final _standingsKey = GlobalKey<NavigatorState>();
final _aiKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    // Shell wraps the 4 tab screens — nav always visible here.
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) => AppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeKey,
          routes: [GoRoute(path: '/home', builder: (_, _) => const HomePage())],
        ),
        StatefulShellBranch(
          navigatorKey: _scheduleKey,
          routes: [GoRoute(path: '/schedule', builder: (_, _) => const SchedulePage())],
        ),
        StatefulShellBranch(
          navigatorKey: _standingsKey,
          routes: [GoRoute(path: '/standings', builder: (_, _) => const StandingsPage())],
        ),
        StatefulShellBranch(
          navigatorKey: _aiKey,
          routes: [GoRoute(path: '/ai', builder: (_, _) => const AiPage())],
        ),
      ],
    ),

    // Detail routes OUTSIDE the shell → bottom nav not rendered.
    GoRoute(
      path: '/race/:round',
      builder: (_, state) => RaceWeekendPage(
        round: state.pathParameters['round']!,
        race: state.extra as Race?,
      ),
    ),
    GoRoute(
      path: '/driver/:id',
      builder: (_, state) => DriverCardPage(
        id: state.pathParameters['id']!,
        driver: state.extra as DriverStanding?,
      ),
    ),
    GoRoute(
      path: '/constructor/:id',
      builder: (_, state) => ConstructorCardPage(id: state.pathParameters['id']!),
    ),
  ],
);
