import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/controllers/controller.dart';

class CustomChipButton extends StatelessWidget {
  CustomChipButton({
    Key? key,
    required this.width,
    required this.text,
    this.isClidked = true,
    this.onTap

  }) : super(key: key);

  final double width;
  final String text;
  bool isClidked;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();

    return GestureDetector(
      onTap: (isClidked) ? onTap : null,
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.01),
        decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: Text(
          text,
          maxLines: 1,
          style: TextStyleManager.getSmallWhiteTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
