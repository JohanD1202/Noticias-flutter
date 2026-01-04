import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/presentation/screens/screens.dart';
import '/presentation/widgets/widgets.dart';


final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavWrapper(state: state)
        );
      },
      routes: [
        GoRoute(
          path: '/',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen()
        ),
        GoRoute(
          path: '/library',
          name: LibraryScreen.name,
          builder: (context, state) => const LibraryScreen()
        ),
      ]
    )
  ]
);