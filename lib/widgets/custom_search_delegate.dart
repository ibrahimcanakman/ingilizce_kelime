import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ingilizce_kelime/data/providers.dart';

import '../models/word_model.dart';
import 'word_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  

  
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

  Widget _metod (BuildContext context)  {

    return Consumer(builder: (context, ref, child) {
      List<Word> allWord = ref.watch(wordProvider);
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
                direction: DismissDirection.startToEnd,
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
                  await ref.read(wordProvider.notifier)
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


    },);



    

    
  }
}
