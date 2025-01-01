import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/*=====================================================*/
/*Função usada para pintar os pontos na contagem manual*/
/*=====================================================*/


class PointsPainter extends CustomPainter {
  final List<Offset> points;

  PointsPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (var point in points) {
      canvas.drawCircle(point, 2, paint); // Draw a small circle at each point
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever points change
  }
}





Future <Uint8List?> Gerar_imagem_com_os_pontos(GlobalKey _imageKey, Uint8List image, List<Offset> pontos) async {

  RenderBox renderBox = _imageKey.currentContext?.findRenderObject() as RenderBox;

  //Descobre o tamanho do widget
  Size size = renderBox.size;

  /*Cria um PictureRecorder e um Canvas
    Vai-se desenhar no Canvas, o pictureRecorder guarda as instruçoes de desenhar
    Têm de se usar juntos*/

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  //Vai buscar a imagem a imagem
  final ui.Image imagem_original = await decodeImageFromList(image);
  paintImage(canvas: canvas, rect: Rect.fromLTWH(0, 0, size.width, size.height), image: imagem_original, fit: BoxFit.contain);

  //Desenha os pontos 
  final Paint pointPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  for(final point in pontos){
    canvas.drawCircle(point, 2, pointPaint);
  }

  //Converte a imagem desenhada para Uint8List
  final ui.Image ui_image = await recorder.endRecording().toImage(
    size.width.toInt(),
    size.height.toInt()
  );

  final ByteData? byteData = await ui_image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List? imagem_final = byteData?.buffer.asUint8List();

  return imagem_final;
}