//import 'package:count_my_bugs/pages/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25 ),
        child: Column(children: const [
          Padding(
            padding: EdgeInsets.all(25),
            child: Icon(Icons.coronavirus),
          ),
          SizedBox(height: 48,),
          Text('Count My Bugs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            ),
          ),
          SizedBox(height: 24,),
          Text(
            'Capture, Count, Conquer: Unveil Bacterial Colonies with CountMyBugs',
            style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24,),
          
        ],

        ),
      )
    );
  }
}