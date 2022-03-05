import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/word_model.dart';

abstract class LocalStorage {
  Future<void> addWord({required Word word});
  Word? getWord({required String id});
  List<Word> getAllWord();
  Future<bool> deleteWord({required Word word});
}

class HiveLocalStorage extends StateNotifier<List<Word>> implements LocalStorage {
  late Box<Word> _wordBox;

  HiveLocalStorage() : super([]) {
    _wordBox = Hive.box<Word>('words');
    List<Word> _allWord = _wordBox.values.toList();

    if (_allWord.isNotEmpty) {
      _allWord.sort(
        (Word a, Word b) => b.tarih.compareTo(a.tarih),
      );
    }
    state = _allWord;

  }

  @override
  Future<void> addWord({required Word word}) async {
    state = [word, ...state];
    await _wordBox.put(word.id, word);
  }

  @override
  Future<bool> deleteWord({required Word word}) async {
    state = state.where((element) => element.id != word.id).toList();
    await _wordBox.delete(word.id);
    //await word.delete();
    return true;
  }

  @override
  List<Word> getAllWord() {
    List<Word> _allWord = <Word>[];
    _allWord = _wordBox.values.toList();

    if (_allWord.isNotEmpty) {
      _allWord.sort(
        (Word a, Word b) => b.tarih.compareTo(a.tarih),
      );
    }
    state = _allWord;
    return _allWord;
  }

  @override
  Word? getWord({required String id}) {
    if (_wordBox.containsKey(id)) {
      return _wordBox.get(id);
    } else {
      return null;
    }
  }
}
