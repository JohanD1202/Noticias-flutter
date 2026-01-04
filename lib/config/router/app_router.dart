import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noticias/presentation/screens/new/home_screen.dart';


final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: Container(height: 20, width: 20, color: Colors.red)
        );
      },
      routes: [
        GoRoute(
          path: '/',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen()
        )
      ]
    )
  ]
);