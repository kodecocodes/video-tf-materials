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
import '../key_constants.dart';
import '../notifiers/quotes_notifier.dart';

class AllQuotesScreen extends ConsumerStatefulWidget {
  const AllQuotesScreen( {super.key});

  @override
  ConsumerState<AllQuotesScreen> createState() => _AllQuotesScreenState();
}

class _AllQuotesScreenState extends ConsumerState<AllQuotesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(quotesNotifierProvider).getQuotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Quotes'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final quotesNotifier = ref.watch(quotesNotifierProvider);
            return quotesNotifier.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    key: quotesCircularProgressKey,
                  ))
                : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: quotesNotifier.quotes.length,
                  itemBuilder: (context, index) {
                    final quote = quotesNotifier.quotes[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                      child: Card(
                        color: Color.fromARGB(255, 224, 222, 222),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(quote.quote!),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '~ ' + quote.author!,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
          },
        ));
  }
}
