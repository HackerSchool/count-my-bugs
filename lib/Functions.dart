import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:image_cropper/image_cropper.dart';



class Fotos {

  final picker = ImagePicker();
  
  Future getImage(bool isCamera) async {

    Uint8List web_image = Uint8List(8);

    if(isCamera){
        XFile? image = await picker.pickImage(source: ImageSource.camera);   //guarda a imagem em image (variavel local)

        if (image != null){
          var f = await image.readAsBytes();  //se se escolheu um ficheiro, passa para a variavel global
            web_image = f;
        }
      }

    else if(!isCamera){
      
        XFile? image = await picker.pickImage(source: ImageSource.gallery);   //guarda a imagem em image (variavel local)
        if (image != null){

          var f = await image.readAsBytes();  //se se escolheu um ficheiro, passa para a variavel global
            web_image = f;
        }
    }
    return web_image;
    }
  }

Future getPathFromUint8List(Uint8List imageData) async {

  if(kIsWeb){
    final blob = html.Blob([imageData]);
    return html.Url.createObjectUrlFromBlob(blob);
  }

  else{
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/temp_image.jpg';
    final file = await File(imagePath).writeAsBytes(imageData);

    return file.path;
  }
}

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
        viewwMode: WebViewMode.mode_3,
      ),
    ],
  );

  if(file_cropped != Null){
      image = await file_cropped?.readAsBytes();
      return image;
  }

  else{
    return null;
  }
}