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
  'HomeScreen muestra mensaje de error cuando falla la carga',
  (tester) async {
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
            (ref, category) =>
                Future<List<Article>>.error(Exception('Network error')),
          ),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.textContaining('error'), findsOneWidget);
    expect(find.byType(SkeletonNews), findsNothing);
  },
);

}