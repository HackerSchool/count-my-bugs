import 'package:count_my_bugs/Functions-contagem-manual.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Pagina_cont_manual extends StatefulWidget {

  final Uint8List image;
  Pagina_cont_manual({required this.image});

  @override
  State<Pagina_cont_manual> createState() => _Pagina_cont_manualState();
}

class _Pagina_cont_manualState extends State<Pagina_cont_manual> {

  /*Guarda as coordenadas dos pontos pintados na imagem 
  (toques recolhidos pelo Gesture Detector)*/

  final List<Offset> pontos = []; 
  /*Chave que serve para identificar  o widget da imagem e saber as suas dimensoes
  Necessario para calcular as coordenadas dos pontos, relativas ao widget*/
  final GlobalKey _imageKey = GlobalKey(); 
  Uint8List? imagem_editada;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),

      body: Center(
        child: Column(
          children: [

            GestureDetector(

              onTapDown: (TapDownDetails details){
                //Render box é algo mais low level que o widget, permite-me saber o tamanho e aposição do widget
                //Coordenadas do toque, relativas ao widget (child)
                RenderBox renderBox = _imageKey.currentContext?.findRenderObject() as RenderBox;

                  Offset coordenadasLocais = renderBox.globalToLocal(details.globalPosition);

                  setState(() {
                  pontos.add(coordenadasLocais); //adiciona o ponto (coordenadas) à lista
                });
              },  
              
              child: SizedBox(
                height: 400,
                width: 300,
                child: Stack(
                  /*Stack widget permite sobrepor widgets uns em cima dos outros */
                
                  children:[
                    /*Posiotined.fill faz que com a sua child ocupe toda a stack.
                    Usar 2 para sobrepor a imagem ao desenho dos pontos*/
                      Positioned.fill(
                        child: Container(
                          /*Mostrar a imagem*/
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.black, width: 3)
                          ),
                          
                        
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(
                              widget.image,
                              fit: BoxFit.cover,
                              key: _imageKey, //key do widget da imagem
                            )
                          )
                        ),
                      ),
                    
                
                    
                    Positioned.fill(
                      child: CustomPaint(
                          painter: PointsPainter(pontos),
                        
                      ),
                    ),
                  ]
                ),
              ),
            ),



            /*Botão para voltar para trás*/
            FloatingActionButton(
              child: Icon(Icons.arrow_back, color: Colors.white),
              backgroundColor: Colors.grey[900],
              onPressed: () async {

                imagem_editada = await Gerar_imagem_com_os_pontos(_imageKey, widget.image, pontos);
                if(imagem_editada != null){
                  Navigator.pop(context, imagem_editada);
                }
              },
            )

          ],
        ),
      ),
    );
  }
}