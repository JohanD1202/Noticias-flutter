import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavWrapper extends StatelessWidget {
  final GoRouterState state;

  const BottomNavWrapper({
    super.key, 
    required this.state
  });

  int _getCurrentIndex() {
    final location = state.uri.toString();

    if(location == '/') return 0;
    if(location == '/library') return 1;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return _NewBottomNavigationBar(
      currentIndex: _getCurrentIndex(),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/library');
            break;
        }
      },
    );
  }
}


class _NewBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const _NewBottomNavigationBar({
    required this.currentIndex,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: Theme.of(context).colorScheme.surface,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodySmall?.color,
        showUnselectedLabels: true,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.library),
            label: '',
          ),
        ],
      ),
    );
  }
}
