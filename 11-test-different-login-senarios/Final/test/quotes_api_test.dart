import 'dart:io';

import 'package:Testing/key_constants.dart';
import 'package:Testing/models/quotes.dart';
import 'package:Testing/services/quotes_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
test('quotes json test', () {
  final quote = Quotes(1, '', '');

  expect(quote.id, 1);
  expect(quote.author, '');
  expect(quote.quote, '');
});

test('Quotes Service MOCK API Test', () async{
  Future<Response> _mockHTTP(Request request) async {
  if (request.url.toString().startsWith('https://dummyjson.com/quotes')) {
        return Response(mockQuotes, 200,
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

return throw Exception('failed');
}
final client = (MockClient(_mockHTTP));
final apiService = QuotesService(client);
final quotes = await apiService.getQuotes();

expect(quotes.first.id, 1);
expect(quotes.first.author, 'Shree');
expect(quotes.first.quote, 'I am best');
});
}
