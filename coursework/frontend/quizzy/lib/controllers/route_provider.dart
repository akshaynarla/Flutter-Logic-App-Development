import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/views/screens/helpers/quiz_exit.dart';
import 'package:quizzy/views/screens/screens.dart';

import '../views/utils/screen_utils/scaffold_with_nested_navigation.dart';

// Code inspired and modelled around: https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _guideNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'guide');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');

// global goRoute provider, so that all routes can be accessed globally.
// Concept of routerProvider similar to the weekly task week9/dicey
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch: StatefulShellBranch allows for BottomNavigationBar usage of the root branch
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'stats',
                    builder: (context, state) => const StatScreen(),
                  ),
                  GoRoute(
                    path: 'appguide',
                    builder: (context, state) => const GuideScreen(),
                  ),
                  GoRoute(
                    path: 'mode',
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: ModeScreen()),
                    routes: [
                      GoRoute(
                        path: 'timed',
                        builder: (context, state) => const TimedSessionScreen(),
                      ),
                      GoRoute(
                        path: 'normal',
                        builder: (context, state) =>
                            const NormalSessionScreen(),
                      ),
                      // main quiz session screen
                      GoRoute(
                        path: 'init',
                        builder: (context, state) => const InitSessionScreen(),
                      ),
                      GoRoute(
                        path: 'exit',
                        builder: (context, state) => const QuizExit(),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _guideNavigatorKey,
            routes: [
              GoRoute(
                path: '/guide',
                builder: (context, state) => const GuidePop(),
              ),
            ],
          ),
        ],
      ),
      // Not part of Nested Navigation, hence kept out of the StatefulShellBranch
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: InitScreen()),
        routes: [
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginScreen()),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(
            path: 'resetpw',
            builder: (context, state) => const ResetPasscode(),
          ),
        ],
      ),
    ],
  );
});
