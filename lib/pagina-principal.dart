import 'package:count_my_bugs/pagina-cont-manual.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'base.dart';
import 'Functions.dart';



class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {



Uint8List web_image = Uint8List(8); // guarda a imagem que sai da funçao caso web
bool mostrar_contagem = false;
int num_colonias = 0;
Uint8List vazio = Uint8List(8);     //Variavel para verificar se temos uma imagem ao comparar com uma "matriz vazia"
final isDialOpen = ValueNotifier(false);
String image_path = "";             //path da imagem, necessário para parte de cortar a imagem
XFile? image;

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
          title: const Text("Home"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),



        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          onTap: _navigateBottomBar,
          items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: "Enviar"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: "Galeria",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "Camera",
          ),
        ]),




        body: listEquals(web_image, vazio)?   //se não houver imagem, retorna o texto

          Container(
            padding: const EdgeInsets.only(top: 30, left: 21),
            child: const Text('Press the button to choose a photo and start counting your bugs :)')
          ):
          // se houver imagem                
          Center(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black, width: 3)
                  ),

                  margin: const EdgeInsets.only(top: 25, bottom: 20),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.memory(
                      web_image,
                      fit: BoxFit.cover,
                      height: 400,
                      width: 300,
                    )
                  )
                ),
                mostrar_contagem? //apenas se mostra a contagem se a imgagem já tiver sido enviada
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Contagem: $num_colonias",style: const TextStyle(fontSize: 15,)),

                    //botao de contagem manual
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: FloatingActionButton(
                      child: Icon(Icons.brush, color: Colors.white),
                      backgroundColor: Colors.grey[900],
                      onPressed:(){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Pagina_cont_manual())
                        );
                      }
                      ),
                    ),                 
                  ],
                ):
                const Text("",style: TextStyle(fontSize: 15,)),

                //botão de recortar a imagem
                !mostrar_contagem?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.crop, color: Colors.white),
                    backgroundColor: Colors.grey[900],
                    onPressed: () async {
                      var c = await Crop_image_func(context, image!.path);
                      
                      if (c != null) {
                        setState(() {
                          web_image = c;
                        });
                      }
                    },
                    
                    ),
                ): SizedBox()
              ],
            ),
            
          ),  

      ),
    );
  }
  //Funçao que realiza as diversas funçoes dos 3 botões da bottom navigation bar

Future _navigateBottomBar(int index) async{

  if (index==0){        //Enviar
    showDialog(
      context: context,
      builder: (context){
        return const Center(child: CircularProgressIndicator());
      }
    );

    var responde = await BaseClient().post(web_image); //manda-se a imagem
    var teste = await BaseClient().get();              //recebe-se a imagem modificada e a contagem. Estao dentro de teste

    responde = base64Decode(teste['imagem']);
    var num = teste['numeros'];

    setState(() {
      web_image = responde;            //passa-se a imagem e o numero para as variaveis globais
      num_colonias = num;
      mostrar_contagem = true;
    });

    /*Tira o círculo*/

    Navigator.of(context).pop();


  }
  if (index==1){          //Galeria
    var a = await Fotos().getImage(false);
    var b = await a.readAsBytes();

    setState(() {
      image = a;
      num_colonias = 0;
      mostrar_contagem = false;
      web_image = b;
    });
  }

  if(index==2){         //Câmera
                          
    var a = await Fotos().getImage(true);           //A camera n esta a funcionar em web, mas funciona com o Android
    var b = await a.readAsBytes();  

    setState(() {
      image = a;
      num_colonias = 0;
      mostrar_contagem = false;
      web_image = b;

    });

    
  }
}
}