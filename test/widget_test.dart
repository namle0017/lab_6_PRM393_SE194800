import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab6_se194800/main.dart';

void main() {
  testWidgets('Renders Find a Movie header, search bar, genres, and sort bar',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();

    expect(find.text('Find a Movie'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search by movie title...'), findsOneWidget);
    expect(find.text('Genres'), findsOneWidget);
    expect(find.text('Action'), findsWidgets);
    expect(find.text('Sci-Fi'), findsWidgets);
    expect(find.text('Sort:'), findsOneWidget);
    expect(find.text('A–Z'), findsOneWidget);
  });

  testWidgets('Search query filters movie list', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();

    expect(find.text('Inception'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Dark Knight');
    await tester.pump();

    expect(find.text('The Dark Knight'), findsOneWidget);
    expect(find.text('Inception'), findsNothing);
  });

  testWidgets('Genre chip filter filters movie list',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();

    final animationChip = find.widgetWithText(FilterChip, 'Animation');
    expect(animationChip, findsOneWidget);

    await tester.tap(animationChip);
    await tester.pump();

    expect(find.text('Spirited Away'), findsOneWidget);
    expect(find.text('Spider-Man: Into the Spider-Verse'), findsOneWidget);
    expect(find.text('The Dark Knight'), findsNothing);
  });

  testWidgets('Responsive Layout adapts at 800px breakpoint',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(600, 1000);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();

    expect(find.byKey(const ValueKey('movie_list_phone')), findsOneWidget);
    expect(find.byKey(const ValueKey('movie_grid_tablet')), findsNothing);
    expect(find.text('Phone View'), findsOneWidget);

    tester.view.physicalSize = const Size(900, 1200);
    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();

    expect(find.byKey(const ValueKey('movie_grid_tablet')), findsOneWidget);
    expect(find.byKey(const ValueKey('movie_list_phone')), findsNothing);
    expect(find.text('Tablet / Web'), findsOneWidget);

    tester.view.resetPhysicalSize();
  });
}
