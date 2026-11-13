import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_teste/main.dart';

void main() {
  testWidgets('adds and removes a favorite from the Favorites page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final currentPair = tester.widget<BigCard>(find.byType(BigCard)).pair;
    final pairText = currentPair.asLowerCase;

    await tester.tap(find.text('Like'));
    await tester.pump();
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('You have 1 favorites:'), findsOneWidget);
    expect(find.text(pairText), findsOneWidget);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Like'));
    await tester.pump();
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('No favorites yet.'), findsOneWidget);
  });

  testWidgets('adapts the navigation rail to the available width',
      (WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(400, 800)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
      isFalse,
    );

    tester.view.physicalSize = const Size(800, 800);
    await tester.pumpAndSettle();
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
      isTrue,
    );
  });
}
