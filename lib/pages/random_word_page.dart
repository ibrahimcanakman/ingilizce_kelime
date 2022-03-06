import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ingilizce_kelime/data/providers.dart';
import 'package:ingilizce_kelime/models/word_model.dart';
import 'package:ingilizce_kelime/widgets/rw_appbar_widget.dart';
import 'package:ingilizce_kelime/widgets/secene_buton_widget.dart';

class RandomWordPage extends ConsumerStatefulWidget {
  const RandomWordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RandomWordPageState();
}

class _RandomWordPageState extends ConsumerState<RandomWordPage> {

  final Random random = Random();
  List<String> cevaplar = [];
  List<Word>? tumKelimeler;
  List<Word> sorulanKelimeler = [];
  bool gorunurluk = false;
  String secenek = '';
  Word? kelime;
  
  //initState içinde bu widget ilk çalıştığında tumKelimeler ataması yapıldı...
  @override
  void initState() {
    super.initState();
    tumKelimeler = ref.read(wordProvider);
  }

  @override
  Widget build(BuildContext context) {
      
    debugPrint('build tetiklendi');

    debugPrint(tumKelimeler!.length.toString());
    kelime = ref.watch(oAnkiKelimeProvider);
    try {
      kelime = tumKelimeler![random.nextInt(tumKelimeler!.length)];
      ref.read(dogruCevapProvider.state).state = kelime!.anlam;
    } catch (e) {
      debugPrint('HATA ÇIKTI ! ! ! ! !');
    }
    

    cevaplar = ref.watch(cevaplarProvider);
    if (kelime != null) {
      if (!cevaplar.contains(kelime!.anlam)) {
        cevaplar.removeAt(cevaplar.length-1);
        cevaplar.add(kelime!.anlam);
      }
    }

    cevaplar.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Word',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
                onPressed: () {
                  //tumKelimeler = [];
                  
                    tumKelimeler = ref.read(wordProvider);
                    debugPrint('sync tetiklendi');
                    cevaplar = ref.watch(cevaplarProvider);
                    ref.read(soruSayisiProvider.state).state = 0;
                    ref.read(dogruCevapSayisiProvider.state).state = 0;
                  
                },
                icon: const Icon(Icons.sync));
          })
        ],
      ),
      body: kelime != null
          ? Center(
              child: Column(
                children: [
                  Text('Doğru Cevap: ${ref.watch(dogruCevapSayisiProvider)}'),
                  Text('${ref.watch(soruSayisiProvider)}. Soru'),
                  Text('Kalan Soru Sayısı: ${tumKelimeler!.length}'),
                  const Spacer(),
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
                          kelime!.kelime,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 30),
                        ),
                        Text(kelime!.cumle),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SecenekButonWidget(gecerliSik: cevaplar[0],),
                                SecenekButonWidget(gecerliSik: cevaplar[1],),
                               
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SecenekButonWidget(gecerliSik: cevaplar[2],),
                                SecenekButonWidget(gecerliSik: cevaplar[3])
                              ],
                            )
                          ],
                        ),
                        /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                //kelimeDegistir();
                                if (tumKelimeler.isEmpty) {
                                  showMessage(context);
                                } else {
                                  ref.read(soruSayisiProvider.state).state++;
                                  //sorulanKelimeler.remove(kelime);
                                  tumKelimeler.remove(kelime);

                                  ref.read(cevaplarProvider);
                                }
                              },
                              child: const Icon(Icons.clear),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(dogruCevapProvider.state).state++;
                                if (tumKelimeler.isEmpty) {
                                  showMessage(context);
                                } else {
                                  ref.read(soruSayisiProvider.state).state++;
                                  tumKelimeler.remove(kelime);
                                  ref.read(cevaplarProvider);
                                }
                              },
                              child: const Icon(Icons.check),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                            )
                          ],
                        ), */
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            )
          : const Center(
              child: Text('Kelime Bitti...'),
            ),
    );
  }

  
  }
