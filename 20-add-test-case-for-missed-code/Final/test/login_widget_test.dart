import 'package:Testing/key_constants.dart';
import 'package:Testing/notifiers/quotes_notifier.dart';
import 'package:Testing/pages/all_quotes_screen.dart';
import 'package:Testing/pages/login_screen.dart';
import 'package:Testing/services/quotes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'widget_tester_extension.dart';

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  testWidgetsMultipleScreenSizes('Login Widget Test', loginWidgetTest);
}

Future<void> loginWidgetTest(
    WidgetTester tester, TestCaseScreenInfo? testCaseScreenInfo) async {
  MockQuotesService mockQuotesService = MockQuotesService();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        quotesNotifierProvider
            .overrideWith((ref) => QuotesNotifier(mockQuotesService))
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    ),
  );

  when(() => mockQuotesService.getQuotes())
      .thenAnswer((_) async => mockQuotesForTesting);
  await tester.pumpAndSettle();

  await doGolden('Login-Page', 'All Widgets on screen', testCaseScreenInfo);

  final loginText = find.byKey(loginScreenTextKey);
  final emailTextField = find.byKey(emailTextFormKey);
  final passwordTextField = find.byKey(passwordTextFormKey);
  final loginButton = find.byKey(loginButtonKey);

  expect(loginText, findsOneWidget);
  expect(emailTextField, findsOneWidget);
  expect(passwordTextField, findsOneWidget);
  expect(loginButton, findsOneWidget);

  await tester.enterText(emailTextField, 'abcd');
  await tester.enterText(passwordTextField, '1234');

  await tester.tap(loginButton);

  await tester.pumpAndSettle();
  final emailErrorText = find.text(kEmailErrorText);
  final passwordErrorText = find.text(kPasswordErrorText);

  expect(emailErrorText, findsOneWidget);
  expect(passwordErrorText, findsOneWidget);

  await doGolden('Login-Page', 'Invalid Credentials', testCaseScreenInfo);

  await tester.enterText(emailTextField, 'abcd@mail.com');
  await tester.enterText(passwordTextField, 'abcd1234');

  await tester.tap(loginButton);

  await tester.pump(const Duration(seconds: 1));

  await doGolden('Login-Page', 'Valid Credentials', testCaseScreenInfo);

  await doGolden('Login-Page', 'Show Loading Indicator', testCaseScreenInfo);

  await tester.pump(Duration(seconds: 1));
  expect(find.byKey(loginCircularProgressKey), findsNothing);

  expect(emailErrorText, findsNothing);
  expect(passwordErrorText, findsNothing);
  await doGolden('Login-Page', 'Hide Loading Indicator', testCaseScreenInfo);

  await tester.pumpAndSettle();

  var quotesPageTitle = find.text('All Quotes');

}
