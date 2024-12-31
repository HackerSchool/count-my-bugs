import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:typed_data';


/*=====================================================*/
/*Função usada para tirar/escolher uma foto da galeria*/
/*=====================================================*/

class Fotos {

  final picker = ImagePicker();
  
  Future getImage(bool isCamera) async {

    XFile? image;

    if(isCamera){
      image = await picker.pickImage(source: ImageSource.camera);   //guarda a imagem em image (variavel local)
    }

    else if(!isCamera){
      image = await picker.pickImage(source: ImageSource.gallery);   //guarda a imagem em image (variavel local)
    }
    
    return image;
    }
  }

/*=====================================================*/
/*Função usada para recortar a imagem na pagina principal*/
/*=====================================================*/

Future Crop_image_func(BuildContext context, String image_path) async{

  Uint8List? image;

  CroppedFile? file_cropped = await ImageCropper().cropImage(
    sourcePath: image_path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
        ],
      ),

      IOSUiSettings(
        title: 'Cropper',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          
        ],
      ),

      WebUiSettings(
        context: context,
        size: CropperSize(width: 300, height: 400),
      ),
    ],
  );

  if(file_cropped != null){
      image = await file_cropped.readAsBytes();
      return image;
  }

  else{
    return null;
  }
}


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