import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/word_model.dart';

class WordItem extends StatefulWidget {
  final Word word;
  const WordItem({Key? key, required this.word}) : super(key: key);

  @override
  State<WordItem> createState() => _WordItemState();
}

class _WordItemState extends State<WordItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
            )
          ]),
      child: ListTile(
        title: Row(
          children: [
            Text(
              widget.word.kelime,
              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w900),
            ),
            const Text('  /  '),
            Text(
              widget.word.anlam,
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
        subtitle: Text('Ex: ' + widget.word.cumle),
        trailing: Text(DateFormat('dd.MM.y').format(widget.word.tarih)),
      ),
    );
  }
}