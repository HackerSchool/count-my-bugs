import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'base.dart';
import 'Functions.dart';
import 'intro.dart';


void main(){                    
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My first page",
    home: IntroPage(),
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
int check_image = 0;             // verifica se alguma imagem foi selcionada (Sim == 1; Nao == 0)
//File? file;                   //variavel do tipo ficheiro que guarda a imagem que sai da funçao, caso nao web
Uint8List web_image = Uint8List(8); // guarda a imagem que sai da funçao caso web


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: 500,
            child: check_image == 0?
            Container():
  
              Image.memory(web_image, fit: BoxFit.cover),
          ),
          
          FloatingActionButton(
            onPressed: () async{
                var a = await F().getImage(true, web_image);           //A camera n esta a funcionar em web, mas funciona com o Android

                setState(() {
                  web_image = a;
                  check_image = 1;
                });
               
              
            }, 
            child: Icon(Icons.camera),
          ),

          FloatingActionButton(
            onPressed: ()async{
                var a = await F().getImage(false, web_image);
          
                setState(() {
                  web_image = a;
                  check_image = 1;
                });
            }, 
            child: Icon(Icons.file_download),
          ),
          


          FloatingActionButton(
            child: Icon(Icons.send),

            onPressed: ()async{
             var responde = await BaseClient().post(web_image); //passa-se a string ola para o api.py
             var teste = await BaseClient().get(); //recebe-se a string modificada
             
              setState(() {
                web_image = teste; // passa-se a string modificada para final_response
              });
            },
          ),
          //Text(final_response), // mostra-se a string modificada

        ],
      )
    );
  }
}