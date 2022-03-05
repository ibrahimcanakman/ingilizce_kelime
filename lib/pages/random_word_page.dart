import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ingilizce_kelime/data/providers.dart';
import 'package:ingilizce_kelime/models/word_model.dart';

class RandomWordPage extends ConsumerWidget {
  const RandomWordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Word> tumKelimeler = ref.watch(wordProvider);
    Word kelime = tumKelimeler.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Word',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Kelime Sayısı: ${tumKelimeler.length}'),
            const Text('Şuan sorulan kelime sırası / Toplam kelime sayısı...'),
            const Spacer(
              flex: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(width: 3, color: Colors.black54),
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    kelime.kelime,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 30),
                  ),
                  Text(kelime.cumle),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                kelime.anlam,
                                style: TextStyle(color: Colors.indigo.shade900),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'tek',
                                style: TextStyle(color: Colors.indigo.shade900),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                              icon: const Icon(
                                Icons.question_answer_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                              label: Text(
                                'hiç',
                                style: TextStyle(color: Colors.indigo.shade900),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'yalnız',
                                style: TextStyle(color: Colors.indigo.shade900),
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
