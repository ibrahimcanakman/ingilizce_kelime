import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ingilizce_kelime/widgets/word_card.dart';

import '../data/local_storage.dart';
import '../main.dart';
import '../models/word_model.dart';

class RandomWordCard extends StatefulWidget {
  const RandomWordCard({Key? key}) : super(key: key);

  @override
  State<RandomWordCard> createState() => _RandomWordCardState();
}

class _RandomWordCardState extends State<RandomWordCard> {
  late List<Word> _allWords;
  late LocalStorage _localStorage;
  final _random = new Random();
  final List<Color> _renkler = [
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.cyan,
    Colors.lime,
    Colors.teal,
    Colors.pink,
    Colors.purple,
    Colors.deepOrange,
    Colors.green,
    Colors.lightBlue,
    Colors.indigo,
    Colors.yellow
  ];

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allWords = <Word>[];
    _getAllWordFromDb();
    debugPrint('TETİKLENDİ');
  }

  @override
  Widget build(BuildContext context) {
    Word? _oAnkiListeElemani;
    Color? _oAnkiRenk;
    if (_allWords.isNotEmpty) {
      _oAnkiListeElemani = _allWords[_random.nextInt(_allWords.length)];
      _oAnkiRenk = _renkler[_random.nextInt(_renkler.length)];
    } else {
      _oAnkiListeElemani = null;
      _oAnkiRenk = null;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelime Kartları',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _getAllWordFromDb();
                setState(() {});
              },
              icon: const Icon(Icons.sync))
        ],
      ),
      body: _oAnkiListeElemani != null
          ? Dismissible(
              key: Key(_oAnkiListeElemani.id),
              onDismissed: (direction) {
                _allWords.remove(_oAnkiListeElemani);
                setState(() {});
              },
              child: Center(
                  child: WordCard(
                      kelime: _oAnkiListeElemani.kelime,
                      anlam: _oAnkiListeElemani.anlam,
                      cumle: _oAnkiListeElemani.cumle,
                      renk: _oAnkiRenk!)),
            )
          : const Center(
              child: Text('Kayıtlı Kelime Yok...'),
            ),
    );
  }

  void _getAllWordFromDb() async {
    _allWords = await _localStorage.getAllWord();
  }
}
