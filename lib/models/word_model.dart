import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'word_model.g.dart';

@HiveType(typeId: 1)
class Word extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String kelime;
  @HiveField(2)
  final String anlam;
  @HiveField(3)
  final String cumle;
  @HiveField(4)
  final DateTime tarih;

  Word(
      {required this.id,
      required this.kelime,
      required this.anlam,
      required this.cumle,
      required this.tarih});

  factory Word.create(
      {required String kelime, required String anlam, required String cumle}) {
    return Word(
        id: const Uuid().v1(),
        kelime: kelime,
        anlam: anlam,
        cumle: cumle,
        tarih: DateTime.now());
  }
}
