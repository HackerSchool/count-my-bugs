import 'package:count_my_bugs/pagina-principal.dart';
import 'package:count_my_bugs/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


class IntroPage extends StatelessWidget {
  IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(icon: const Icon(Icons.light_mode), 
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },)
        ],      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                color:Theme.of(context).colorScheme.primary,
            
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