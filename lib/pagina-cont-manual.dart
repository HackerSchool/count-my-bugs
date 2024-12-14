import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Pagina_cont_manual extends StatefulWidget {

  final Uint8List image;
  Pagina_cont_manual({required this.image});

  @override
  State<Pagina_cont_manual> createState() => _Pagina_cont_manualState();
}

class _Pagina_cont_manualState extends State<Pagina_cont_manual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.memory(widget.image),
    );
  }
}