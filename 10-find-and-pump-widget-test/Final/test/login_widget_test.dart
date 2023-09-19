import 'package:Testing/key_constants.dart';
import 'package:Testing/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
          child: MaterialApp(
        home: LoginScreen(),
      )),
    );
    final loginText = find.byKey(loginScreenTextKey);
    final emailTextField = find.byKey(emailTextFormKey);
    final passwordTextField = find.byKey(passwordTextFormKey);
    final loginButton = find.byKey(loginButtonKey);

    expect(loginText, findsOneWidget);
    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });
}
