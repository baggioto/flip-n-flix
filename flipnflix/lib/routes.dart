import 'package:flipnflix/home_components/home.dart';
import 'package:flipnflix/home_page.dart';
import 'package:flipnflix/landing_page.dart';
import 'package:flipnflix/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router =
    GoRouter(initialLocation: '/landing', debugLogDiagnostics: true, routes: [
  GoRoute(
    path: '/landing',
    builder: (context, state) {
      return const LandingPage();
    },
  ),
  ShellRoute(
      builder: (context, state, child) {
        int? index;
        if (state.extra is int) {
          index = state.extra as int;
        }
        return HomePage(index: index ?? 0, child: child);
      },
      routes: [
        GoRoute(
            builder: (context, state) => const Home(),
            path: '/home',
            routes: [
              GoRoute(
                  path: '/moviedetail',
                  builder: (context, state) {
                    final id = state.extra as int;
                    return HomeDetailScreen(id: id);
                  })
            ]),
        GoRoute(builder: (context, state) => Text("Search"), path: '/search'),
        GoRoute(
            builder: (context, state) => Text("Favorites"), path: '/favorites'),
        GoRoute(
            builder: (context, state) => Text("Settings"), path: '/settings')
      ])
]);
