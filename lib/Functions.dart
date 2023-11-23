import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class F {

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

  class Barra extends StatelessWidget {
  const Barra({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 130,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3),
                ),
              )
            );
  }
}