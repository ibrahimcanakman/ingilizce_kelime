import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers.dart';

class SecenekButonWidget extends ConsumerWidget {
  const SecenekButonWidget({Key? key, required this.gecerliSik}) : super(key: key);
  final String gecerliSik;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var allWords = ref.watch(wordProvider);
    return Consumer(
      builder: (context, ref, child) => TextButton(
          onPressed: () async {
            allWords.remove(ref.watch(oAnkiKelimeProvider));
            //ref.read(cevapProvider.state).state = cevaplar[0];
            debugPrint('cevapprovider tetiklendi');
            if (ref.watch(oAnkiKelimeProvider).anlam == ref.read(dogruCevapProvider)) {
              ref.read(dogruCevapSayisiProvider.state).state++;
              debugPrint('dogrucevap tetiklendi');
            }
            ref.read(gorunurlukProvider.state).state = true;
            debugPrint('gorunurluk true tetiklendi');
            if (allWords.isEmpty) {
              Timer(const Duration(seconds: 1), () {
                ref.read(gorunurlukProvider.state).state = false;
              });
              showMessage(context);
            } else {
              Timer(
                const Duration(seconds: 1),
                () {
                  ref.read(gorunurlukProvider.state).state = false;
                  debugPrint('gorunurluk false tetiklendi');
                  ref.read(soruSayisiProvider.state).state++;
                  debugPrint('sorusayısı +1 tetiklendi');
                  ref.read(cevaplarProvider);
                  debugPrint('cevaplar tetiklendi tetiklendi');
                },
              );
            }
          },
          child: Text(
            gecerliSik,
            style: TextStyle(color: Colors.blue.shade900),
          )),
    );
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Kelimeler Bitti'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Kelime bitti. İstersen tekrar baştan başlayabilirsin...'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
