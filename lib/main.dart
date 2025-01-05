import 'package:count_my_bugs/theme.dart';
import 'package:count_my_bugs/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'intro.dart';

void main(){                    
  runApp( ChangeNotifierProvider(
    create : (context) => ThemeProvider(),
    child: const MyApp(),

     )  
    );
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My first page",
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeProvider.themeMode,
      home: IntroPage(),
     );
}

  }