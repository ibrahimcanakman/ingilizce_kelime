import 'package:flutter/material.dart';
import 'package:ingilizce_kelime/data/local_storage.dart';
import 'package:ingilizce_kelime/main.dart';
import 'package:ingilizce_kelime/models/word_model.dart';
import 'package:ingilizce_kelime/pages/random_card.dart';
import 'package:ingilizce_kelime/widgets/custom_search_delegate.dart';
import 'package:ingilizce_kelime/widgets/word_list_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _kelimeController = TextEditingController();
  final TextEditingController _anlamController = TextEditingController();
  final TextEditingController _cumleController = TextEditingController();

  late List<Word> _allWords;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allWords = <Word>[];
    _getAllWordFromDb();
  }

  @override
  Widget build(BuildContext context) {
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
                  _showSearchPage();
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  _showAddWordBottomSheet();
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RandomWordCard(),
                  ));
                },
                icon: const Icon(Icons.workspaces_outlined))
          ],
        ),
        body: _allWords.isNotEmpty
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
                      _allWords.removeAt(index);
                      _localStorage.deleteWord(word: _oAnkiListeElemani);
                      setState(() {});
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

  void _showAddWordBottomSheet() {
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
                          _allWords.insert(0, yeniKelime);
                          await _localStorage.addWord(word: yeniKelime);
                          setState(() {});
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

  void _getAllWordFromDb() async {
    _allWords = await _localStorage.getAllWord();
    setState(() {});
  }

  void _showSearchPage() async {
    await showSearch(
        context: context, delegate: CustomSearchDelegate(allWord: _allWords));
    _getAllWordFromDb();
  }
}
