import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/login_widget_test.dart';
import '../test/quotes_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration', () {
    WidgetController.hitTestWarningShouldBeFatal = true;
    testWidgets('Login-Page', (tester) => loginWidgetTest(tester, null));
    testWidgets(
        'All-Quotes-Page', (tester) => allQuotesWidgetTest(tester, null));
  });
}
