/*
Copyright (c) 2023 Kodeco LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../models/quotes.dart';
import '../services/quotes_service.dart';

class QuotesNotifier extends ChangeNotifier {
  final QuotesService _quotesService;

  QuotesNotifier(this._quotesService);

  List<Quotes> _quotes = [];
  List<Quotes> get quotes => _quotes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoader(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getQuotes() async {
    setLoader(true);

    _quotes = await _quotesService.getQuotes();
    setLoader(false);
  }
}

final _client = Client();
final quotesNotifierProvider =
    ChangeNotifierProvider((ref) => QuotesNotifier(QuotesService(_client)));
