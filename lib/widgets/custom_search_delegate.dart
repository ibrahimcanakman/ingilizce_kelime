import 'package:flutter/material.dart';
import 'package:ingilizce_kelime/data/local_storage.dart';
import 'package:ingilizce_kelime/main.dart';

import '../models/word_model.dart';
import 'word_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Word> allWord;

  CustomSearchDelegate({required this.allWord});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _metod(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _metod(context);
  }

  Widget _metod(BuildContext context) {
    List<Word> filteredList = allWord
        .where(
          (element) =>
              element.kelime.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return filteredList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              var _oAnkiListeElemani = filteredList[index];
              return Dismissible(
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.delete),
                    Text(' Bu Kelime Silindi')
                  ],
                ),
                key: Key(_oAnkiListeElemani.id),
                onDismissed: (direction) async {
                  filteredList.removeAt(index);
                  await locator<LocalStorage>()
                      .deleteWord(word: _oAnkiListeElemani);
                },
                child: WordItem(
                  word: _oAnkiListeElemani,
                ),
              );
            },
            itemCount: filteredList.length,
          )
        : const Center(
            child: Text('Aranan Kelime Yok...'),
          );
  }
}
