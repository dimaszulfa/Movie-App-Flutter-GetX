// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_getx/screen/my_app.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}



