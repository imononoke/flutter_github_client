import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  void doSearch(String key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(children: const <Widget>[
            Text('search repo'),
            TextField(
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
            )
          ])),
    );
  }
}
