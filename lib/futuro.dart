import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'base.dart';
import 'Functions.dart';
import 'intro.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

String final_response = "aaaa";
final picker = ImagePicker();
int check_image = 1;             // verifica se alguma imagem foi selcionada (Sim == 1; Nao == 0)
//File? file;                   //variavel do tipo ficheiro que guarda a imagem que sai da funçao, caso nao web
Uint8List web_image = Uint8List(8); // guarda a imagem que sai da funçao caso web
Uint8List b = Uint8List(8);
final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(                  //isto serve para quando se carregar na seta de voltar atras com o menu aberto, sairmos do menu
                                          // em vez de sairmos da aplicaçao
      onWillPop: ()async{
        if(isDialOpen.value){

          isDialOpen.value = false;
          return false;
        }
        else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.grey[300],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              width: 500,
              child: listEquals(web_image, b)?
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Press the button to choose a photo and start counting your bugs :)'
                )
              ):
              
                Image.memory(web_image, fit: BoxFit.cover),
            ),
            
            Container(
              padding: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 /* FloatingActionButton(
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
                  ), */
                  
    
    
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
    
                  SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close, //por os botoes bonitos
                    backgroundColor: Colors.black,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.4,
                    spacing: 10,
                    spaceBetweenChildren: 12,
                    openCloseDial: isDialOpen,    //isto serve para quando se carregar na seta de voltar atras com o menu aberto, sairmos do menu
                                                  // em vez de sairmos da aplicaçao
                    children: [
                      SpeedDialChild(
                        child: Icon(Icons.file_download),
                        label: 'Galeria',
                        onTap: ()async{
                          var a = await F().getImage(false, web_image);
                  
                        setState(() {
                          web_image = a;
                          check_image = 1;
                        });
                        }
                      ),
    
                      SpeedDialChild(
                        child: Icon(Icons.camera),
                        label: 'Camera',
                        onTap: ()async{
                          
                        var a = await F().getImage(true, web_image);           //A camera n esta a funcionar em web, mas funciona com o Android
                          
                        setState(() {
  
                          print(web_image);
                          web_image = a;
                          check_image = 1;
                          
                        });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            //Text(final_response), // mostra-se a string modificada
    
          ],
        )
      ),
    );
  }
}