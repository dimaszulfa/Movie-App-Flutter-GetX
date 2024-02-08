// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movie_getx/detail_by_genre_screen.dart';
import 'package:movie_getx/screen/my_app.dart';
import 'package:shimmer/shimmer.dart';

import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/theme_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:movie_getx/routes/routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}



