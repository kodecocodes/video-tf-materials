
import 'package:mocktail/mocktail.dart';
import '../lib/notifiers/quotes_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/services/quotes_service.dart';

// class MockQuotesService implements QuotesService {
//   @override
// Future<List<Quotes>> getQuotes() async {
//    return [
//   Quotes(
//     1,
//     'Test Quote 1',
//     'Test Author 1',
//   ),
//   Quotes(
//     2,
//     'Test Quote 2',
//     'Test Author 2',
//   ),
//   Quotes(
//     3,
//     'Test Quote 3',
//     'Test Author 3',
//   ),
// ];
// }
// }

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  late QuotesNotifier sut_quotesNotifier;
  late MockQuotesService mockQuotesService;

  setUp(() {
    sut_quotesNotifier = QuotesNotifier();
  });
}
