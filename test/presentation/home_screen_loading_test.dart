import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:noticias/config/config.dart';
import 'package:noticias/domain/domain.dart';
import 'package:noticias/presentation/providers/providers.dart';
import 'package:noticias/presentation/screens/screens.dart';
import 'package:noticias/presentation/widgets/widgets.dart';


class FakeSelectedCategoryNotifier extends SelectedCategoryNotifier {
  @override
  NewsCategory build() => NewsCategory.general;
}

void main() {
  testWidgets(
    'HomeScreen muestra SkeletonNews mientras se cargan los artículos',
    (tester) async {

      final completer = Completer<List<Article>>();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            connectivityStatusProvider.overrideWith(
              (ref) => Stream.value(ConnectivityResult.wifi),
            ),

            selectedCategoryProvider.overrideWith(
              FakeSelectedCategoryNotifier.new,
            ),

            articleProvider.overrideWith(
              (ref, category) => completer.future,
            ),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(SkeletonNews), findsOneWidget);
      expect(find.text('No news available.'), findsNothing);
    },
  );
}
