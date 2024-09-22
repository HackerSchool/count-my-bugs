import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
class Fotos {

  final picker = ImagePicker();
  Future getImage(bool isCamera, Uint8List web_image) async {
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

  