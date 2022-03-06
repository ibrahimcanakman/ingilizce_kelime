import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/word_model.dart';
import 'local_storage.dart';

final wordProvider = StateNotifierProvider<HiveLocalStorage, List<Word>>(
  (ref) => HiveLocalStorage(),
);

final dogruCevapSayisiProvider = StateProvider<int>(
  (ref) => 0,
);
final soruSayisiProvider = StateProvider<int>(
  (ref) => 1,
);

final cevaplarProvider = StateProvider<List<String>>(
  (ref) {
    Random random = Random();
    List<Word> allWords = ref.watch(wordProvider);
    List<String> anlamlar = [];
    for (var item in allWords) {
      anlamlar.add(item.anlam);
    }
    List<String> cevaplar = [];
    for (var i = 0; i < 4; i++) {
      var cvp = anlamlar[random.nextInt(anlamlar.length)];
      cevaplar.add(cvp);
      anlamlar.remove(cvp);
    }
    return cevaplar;
  },
);

final oAnkiKelimeProvider = StateProvider<Word>(
  (ref) =>
      Word(id: '', kelime: '', anlam: '', cumle: '', tarih: DateTime.now()),
);

final gorunurlukProvider = StateProvider<bool>(
  (ref) => false,
);

final dogruCevapProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);
final aSikkiProvider = StateProvider<String>(
  (ref) => '',
);
final bSikkiProvider = StateProvider<String>(
  (ref) => '',
);
final cSikkiProvider = StateProvider<String>(
  (ref) => '',
);
final dSikkiProvider = StateProvider<String>(
  (ref) => '',
);
