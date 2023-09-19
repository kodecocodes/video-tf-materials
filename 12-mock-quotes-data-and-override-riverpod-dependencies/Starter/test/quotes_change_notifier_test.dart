
import 'package:Testing/key_constants.dart';
import 'package:Testing/notifiers/quotes_notifier.dart';
import 'package:Testing/services/quotes_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockQuotesService implements QuotesService {
//   bool getQuotesCalled = false;
//   @override
//   Future<List<Quotes>> getQuotes() async {
//     getQuotesCalled = true;
//     return [
//       Quotes(
//         1,
//         'Test Quote 1',
//         'Test Author 1',
//       ),
//       Quotes(
//         2,
//         'Test Quote 2',
//         'Test Author 2',
//       ),
//       Quotes(
//         3,
//         'Test Quote 3',
//         'Test Author 3',
//       ),
//     ];
//   }
// }

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  late QuotesNotifier sut_quotesNotifier;
  late MockQuotesService mockQuotesService;

  /// Initialise or set up everything needed for the test.
  /// runs everytime before each and every test
  setUp(() {
    mockQuotesService = MockQuotesService();
    sut_quotesNotifier = QuotesNotifier(mockQuotesService);
  });

  test('Should check initial values are correct', () {
    expect(sut_quotesNotifier.isLoading, false);
    expect(sut_quotesNotifier.quotes, []);
  });

  group('getQuotes', () {

    void arrageQuotesServiceReturnsQuotes() {
      when(() => mockQuotesService.getQuotes())
          .thenAnswer((_) async => mockQuotesForTesting);
    }

    test('Get Quotes using the QuotesService', () async {
      arrageQuotesServiceReturnsQuotes();
      await sut_quotesNotifier.getQuotes();
      verify(() => mockQuotesService.getQuotes()).called(1);
    });

    test('''Loading data indicator, 
      sets quotes, indicates data is not loaded anymore''', () async {
      arrageQuotesServiceReturnsQuotes();
      final future = sut_quotesNotifier.getQuotes();
      expect(sut_quotesNotifier.isLoading, true);
      await future;
      expect(sut_quotesNotifier.quotes, mockQuotesForTesting);
      expect(sut_quotesNotifier.isLoading, false);
    });
  });
}
