import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:noticias/infrastructure/services/shared_preferences/theme_notifier_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const name = "settings-screen";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 20
    );
    final styleIcon = Theme.of(context).iconTheme.color;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: styleTitle),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            child: Icon(
              LucideIcons.arrowLeft,
              color: styleIcon,
            ),
            onTap: () => context.pop(),
          ),
        ),
      ),
      body: const _SettingsView(),
    );
  }
}

class _SettingsView extends ConsumerWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final styleText = Theme.of(context).textTheme.bodyLarge;

    return ListView(
      children: [
        ListTile(
          title: Text("Modo Oscuro", style: styleText),
          trailing: Switch(
            value: ref.watch(themeProvider) == ThemeMode.dark,
            onChanged: (_) => ref.read(themeProvider.notifier).toggle()
          ),
        ),
      ],
    );
  }
}