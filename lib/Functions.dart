import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:typed_data';



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