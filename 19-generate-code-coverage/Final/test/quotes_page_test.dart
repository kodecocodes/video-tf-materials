import 'package:Testing/key_constants.dart';
import 'package:Testing/notifiers/quotes_notifier.dart';
import 'package:Testing/pages/all_quotes_screen.dart';
import 'package:Testing/services/quotes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'widget_tester_extension.dart';

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  testWidgetsMultipleScreenSizes('All Quotes Widget Test', allQuotesWidgetTest);
}

Future<void> allQuotesWidgetTest(WidgetTester tester, TestCaseScreenInfo? testCaseScreenInfo) async {
  MockQuotesService mockQuotesService = MockQuotesService();

  void getQuotesAfter2SecondsDelay() {
    when(() => mockQuotesService.getQuotes()).thenAnswer((_) async {
      return await Future.delayed(
          const Duration(seconds: 2), () => mockQuotesForTesting);
    });
  }

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        quotesNotifierProvider.overrideWith(
          (ref) => QuotesNotifier(mockQuotesService),
        ),
      ],
      child: MaterialApp(
        home: AllQuotesScreen(),
      ),
    );
  }

  getQuotesAfter2SecondsDelay();
  await tester.pumpWidget(createWidgetUnderTest());

  expect(find.text('All Quotes'), findsOneWidget);
  await doGolden(
  'Quotes-Page', 'Pumped Quotes Page Screen', testCaseScreenInfo);

  await tester.pump(const Duration(seconds: 1));
  expect(find.byKey(quotesCircularProgressKey), findsOneWidget);
  await doGolden(
  'Quotes-Page', 'Check for circular progress indicator', testCaseScreenInfo);
  await tester.pumpAndSettle();
  expect(find.byKey(quotesCircularProgressKey), findsNothing);
  await doGolden(
      'Quotes-Page', 'Check for mock quotes on screen', testCaseScreenInfo);

  expect(find.text('Test Quote 1'), findsOneWidget);
  expect(find.text('Test Quote 2'), findsOneWidget);
  expect(find.text('Test Quote 3'), findsOneWidget);
}
