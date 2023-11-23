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


Future _navigateBottomBar(int index) async{
  if (index==1){
    showDialog(
      context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());
      }
    );

    var responde = await BaseClient().post(web_image); //manda-se a imagem
    var teste = await BaseClient().get();              //recebe-se a imagem modificada e a contagem. Estao dentro de teste

    responde = base64Decode(teste['imagem']);
    var num = teste['numeros'];

    setState(() {
      web_image = responde;            //passa-se a imagem e o numero para as variaveis globais
      num_colonias = num;
    });

    /*Tira o círculo*/

    Navigator.of(context).pop();


  }
  if (index==2){
      var a = await F().getImage(false, web_image);

    setState(() {
      web_image = a;
      check_image = 1;
    });
  }
  if(index==3){
                          
    var a = await F().getImage(true, web_image);           //A camera n esta a funcionar em web, mas funciona com o Android
      
    setState(() {

      print(web_image);
      web_image = a;
      check_image = 1;
      
    });
  }
}




final picker = ImagePicker();
int check_image = 1;             // verifica se alguma imagem foi selcionada (Sim == 1; Nao == 0)
//File? file;                   //variavel do tipo ficheiro que guarda a imagem que sai da funçao, caso nao web
Uint8List web_image = Uint8List(8); // guarda a imagem que sai da funçao caso web
int num_colonias = 0;
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



        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _navigateBottomBar,
          items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: "send",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: "Galeria",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "camera",
          ),
        ]),

        body: 
        ListView(
          children: [

            Barra(),
            //Barra(),


            SizedBox(
              height: 250,
              width: 250,
              child: listEquals(web_image, b)?
              Container(
                padding: EdgeInsets.only(top: 30, left: 21),
                child: Text(
                  'Press the button to choose a photo and start counting your bugs :)'
                )
              ):            
                Row(
                  children: [
                    Image.memory(web_image, fit: BoxFit.contain),
                    Text("Contagem: $num_colonias",style: TextStyle(fontSize: 15,)),
                  ],
                ),
             
                
            ),
            


  
          ],
        )
      ),
    );
  }
}