import 'package:Testing/models/quotes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
test('quotes json test', () {
  final quote = Quotes(1, '', '');

  expect(quote.id, 1);
  expect(quote.author, '');
  expect(quote.quote, '');
});
}
