import 'package:flutter/material.dart';

class WordCard extends StatefulWidget {
  const WordCard(
      {Key? key,
      required this.kelime,
      required this.anlam,
      required this.cumle,
      required this.renk})
      : super(key: key);
  final String kelime;
  final String anlam;
  final String cumle;
  final Color renk;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  bool gorunurluk = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gorunurluk = true;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: widget.renk),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.kelime,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Visibility(
                visible: gorunurluk,
                child: Text(
                  widget.anlam,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Visibility(
                visible: gorunurluk,
                child: Text(
                  widget.cumle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
