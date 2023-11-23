import 'package:count_my_bugs/futuro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Padding(
            padding: EdgeInsets.all(25),
            child: Icon(
              Icons.coronavirus,
              size: 65,
              ),
          ),
          const SizedBox(height: 48,),
          const Text('Count My Bugs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            ),
          ),
          const SizedBox(height: 24,),
          
          const Text(
            'Capture, Count, Conquer: Unveil Bacterial Colonies with CountMyBugs',
            style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24,),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
             MaterialPageRoute(builder: (context) => FirstPage(),
             ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
            
                borderRadius: BorderRadius.circular(12)
              ),
              padding: const EdgeInsets.all(25),
              child: const Center(
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],

        ),
      )
    );
  }
}