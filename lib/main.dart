import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'base.dart';


void main(){                    //A camera n esta a funcionar em web, mas funciona com o Android
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My first page",
    home: FirstPage(),
  ));
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


String final_response = "aaaa";
final picker = ImagePicker();
File? file;                   //variavel do tipo ficheiro que guarda a imagem que sai da funçao, caso nao web
Uint8List web_image = Uint8List(8); // guarda a imagem que sai da funçao caso web



Future getImage(bool isCamera) async {
  if(isCamera){


      XFile? image = await picker.pickImage(source: ImageSource.camera);   //guarda a imagem em image (variavel local)

      if (image != null){
        var f = await image.readAsBytes();  //se se escolheu um ficheiro, passa para a variavel global
        setState(() {
          web_image = f;
          file = File('a');
        });
      }
    }
  

  else if(!isCamera){
    

      XFile? image = await picker.pickImage(source: ImageSource.gallery);   //guarda a imagem em image (variavel local)


      if (image != null){
        var f = await image.readAsBytes();  //se se escolheu um ficheiro, passa para a variavel global
        setState(() {
          web_image = f;
          file = File('a');
        });
      }
    }
  
}


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            child: file == null?
            Container():


            
              Image.memory(web_image, fit: BoxFit.cover),

            height: 100,
            width: 500,
          ),
          
          FloatingActionButton(
            onPressed: () async{ 

              getImage(true);           //A camera n esta a funcionar em web, mas funciona com o Android 
            }, 
            child: Icon(Icons.camera),
          ),

          FloatingActionButton(
            onPressed: (){
              getImage(false);
            }, 
            child: Icon(Icons.file_download),
          ),
          
          FloatingActionButton(
            child: Icon(Icons.send),

            onPressed: ()async{
             var responde = await BaseClient().post('ola'); //passa-se a string ola para o api.py
             var teste = await BaseClient().get(); //recebe-se a string modificada
              
              setState(() {
                final_response = teste; // passa-se a string modificada para final_response
              });
            },
          ),
          Text(final_response), // mostra-se a string modificada

        ],
      )
    );
  }
}