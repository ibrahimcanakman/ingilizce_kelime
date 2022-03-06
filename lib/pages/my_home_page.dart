import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ingilizce_kelime/data/providers.dart';
import 'package:ingilizce_kelime/models/word_model.dart';
import 'package:ingilizce_kelime/pages/random_word_page.dart';
import 'package:ingilizce_kelime/widgets/custom_search_delegate.dart';
import 'package:ingilizce_kelime/widgets/word_list_item.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}) : super(key: key);
  final TextEditingController _kelimeController = TextEditingController();
  final TextEditingController _anlamController = TextEditingController();
  final TextEditingController _cumleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Word> _allWords = ref.watch(wordProvider);
    var kelimeSayisi = _allWords.length;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '$kelimeSayisi Kelime Kayıtlı',
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showSearchPage(context);
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  _showAddWordBottomSheet(context, ref);
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RandomWordPage(),
                  ));
                },
                icon: const Icon(Icons.workspaces_outlined))
          ],
        ),
        body: ref.watch(wordProvider).isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var _oAnkiListeElemani = _allWords[index];
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
                    onDismissed: (direction) {
                      ref
                          .read(wordProvider.notifier)
                          .deleteWord(word: _oAnkiListeElemani);
                    },
                    child: WordItem(
                      word: _oAnkiListeElemani,
                    ),
                  );
                },
                itemCount: _allWords.length,
              )
            : const Center(
                child: Text('Kelime yok...'),
              ));
  }

  void _showAddWordBottomSheet(BuildContext context, WidgetRef ref) {
    //List<Word> _allWords = ref.watch(wordProvider);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextField(
                      maxLines: null,
                      autofocus: true,
                      controller: _kelimeController,
                      decoration: InputDecoration(
                          label: const Text('Kelime'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    TextField(
                      maxLines: null,
                      controller: _anlamController,
                      decoration: InputDecoration(
                          label: const Text('Anlamı'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    TextField(
                      maxLines: null,
                      minLines: 1,
                      controller: _cumleController,
                      decoration: InputDecoration(
                          label: const Text('Örnek Cümle'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var yeniKelime = Word.create(
                              kelime: _kelimeController.text,
                              anlam: _anlamController.text,
                              cumle: _cumleController.text);
                          //_allWords.insert(0, yeniKelime);
                          await ref
                              .read(wordProvider.notifier)
                              .addWord(word: yeniKelime);

                          Navigator.pop(context);
                          _kelimeController.clear();
                          _anlamController.clear();
                          _cumleController.clear();
                        },
                        child: const Text('Save'))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showSearchPage(BuildContext context) async {
    await showSearch(context: context, delegate: CustomSearchDelegate());
  }
}
