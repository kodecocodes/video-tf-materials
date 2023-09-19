import 'package:Testing/key_constants.dart';
import 'package:Testing/notifiers/quotes_notifier.dart';
import 'package:Testing/pages/login_screen.dart';
import 'package:Testing/services/quotes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  testWidgets('Login Widget Test', (WidgetTester tester) async {
    MockQuotesService mockQuotesService = MockQuotesService();

    await tester.pumpWidget(
      ProviderScope(
          overrides: [
            quotesNotifierProvider
                .overrideWith((ref) => QuotesNotifier(mockQuotesService)),
          ],
          child: MaterialApp(
            home: LoginScreen(),
          )),
    );

    when(() => mockQuotesService.getQuotes())
        .thenAnswer((_) async => mockQuotesForTesting);
    await tester.pumpAndSettle();

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
    var emailErrorText = find.text(kEmailErrorText);
    var passwordErrorText = find.text(kPasswordErrorText);

    expect(emailErrorText, findsOneWidget);
    expect(passwordErrorText, findsOneWidget);
    await tester.enterText(emailTextField, 'abcd@mail.com');
    await tester.enterText(passwordTextField, 'abcd1234');

    await tester.tap(loginButton);
    await tester.pump(const Duration(seconds: 1));
    expect(find.byKey(loginCircularProgressKey), findsOneWidget);

    await tester.pump(Duration(seconds: 1));
    expect(find.byKey(loginCircularProgressKey), findsNothing);

    await tester.pumpAndSettle();
    var quotesPageTitle = find.text('All Quotes');
    expect(quotesPageTitle, findsOneWidget);
  });
}
