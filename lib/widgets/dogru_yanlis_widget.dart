import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ingilizce_kelime/data/providers.dart';

import '../models/word_model.dart';

class DogruYanlisGostergeWidget extends ConsumerWidget {
  const DogruYanlisGostergeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Visibility(
                      child: cevapKontrol(ref.watch(oAnkiKelimeProvider)!, ref.watch(dogruCevapProvider)),
                      visible: ref.watch(gorunurlukProvider),
                    );
  }

  Widget cevapKontrol(Word? kelime, String cevap) {
    if (cevap == kelime!.anlam) {
      return const Text(
        'DOĞRU CEVAP',
        style: TextStyle(color: Colors.green),
      );
    } else {
      return Column(
        children: [
          const Text(
            'YANLIŞ CEVAP',
            style: TextStyle(color: Colors.red),
          ),
          Text('DOĞRU CEVAP => ${kelime.anlam}'),
        ],
      );
    }
  }

}