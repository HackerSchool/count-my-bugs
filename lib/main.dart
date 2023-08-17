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

