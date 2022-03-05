import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/word_model.dart';
import 'local_storage.dart';

final wordProvider = StateNotifierProvider<HiveLocalStorage, List<Word>>(
  (ref) => HiveLocalStorage(),
);