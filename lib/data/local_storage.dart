import 'package:hive/hive.dart';

import '../models/word_model.dart';

abstract class LocalStorage {
  Future<void> addWord({required Word word});
  Future<Word?> getWord({required String id});
  Future<List<Word>> getAllWord();
  Future<bool> deleteWord({required Word word});
}

class HiveLocalStorage extends LocalStorage {
  late Box<Word> _wordBox;

  HiveLocalStorage() {
    _wordBox = Hive.box<Word>('words');
  }

  @override
  Future<void> addWord({required Word word}) async {
    await _wordBox.put(word.id, word);
  }

  @override
  Future<bool> deleteWord({required Word word}) async {
    await word.delete();
    return true;
  }

  @override
  Future<List<Word>> getAllWord() async {
    List<Word> _allWord = <Word>[];
    _allWord = _wordBox.values.toList();

    if (_allWord.isNotEmpty) {
      _allWord.sort(
        (Word a, Word b) => b.tarih.compareTo(a.tarih),
      );
    }
    return _allWord;
  }

  @override
  Future<Word?> getWord({required String id}) async {
    if (_wordBox.containsKey(id)) {
      return _wordBox.get(id);
    } else {
      return null;
    }
  }
}
