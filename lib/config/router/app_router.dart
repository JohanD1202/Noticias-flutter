import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noticias/presentation/screens/settings_screen.dart';
import '/presentation/screens/screens.dart';
import '/presentation/widgets/widgets.dart';
import '/domain/domain.dart';


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
          path: '/saved-news',
          name: SavedNewsScreen.name,
          builder: (context, state) => const SavedNewsScreen()
        ),
        GoRoute(
          path: '/settings',
          name: SettingsScreen.name,
          builder: (context, state) => const SettingsScreen()
        ),
        GoRoute(
          path: '/detail',
          name: ArticleDetailScreen.name,
          builder: (context, state) {
            final article = state.extra as Article;
            return ArticleDetailScreen(article: article);
          }
        ),
      ]
    )
  ]
);