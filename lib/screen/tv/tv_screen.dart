import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/tv_controller.dart';
import 'package:movie_getx/detail_by_genre_screen.dart';
import 'package:movie_getx/screen/movie_carousel_items.dart';
import 'package:movie_getx/screen/tv/tv_carousel_items.dart';
import 'package:movie_getx/widgets/custom_chip_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class TvScreen extends StatefulWidget {
   TvScreen({super.key});
  final TvController c = Get.put(TvController());

  @override
  State<TvScreen> createState() => _TvScreenState();
}


class _TvScreenState extends State<TvScreen> {
  
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final TvController c = Get.find();
    c.getListTvData();
    c.getGenres();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var randomed = Random().nextInt(10);

    return Obx(
      () => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.size32, horizontal: AppPadding.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coming soon",
                style: TextStyleManager.getLargeWhiteTextStyle(
                    fontSize: 18.sp, color: ColorManager.primaryColor),
              ),
              (widget.c.listTvData.isEmpty)
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 200,
                        width: width * 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/peaky_blinders_header.jpg"))),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      width: width * 1,
                      child: Stack(
                          alignment: Alignment.bottomLeft,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "${AssetImageManager.assetNetworkUrl + widget.c.listTvData["results"][randomed]["backdrop_path"]}"))),
                            ),
                            Positioned(
                                left: 10,
                                bottom: 5,
                                child: Text(
                                  "${widget.c.listTvData["results"][randomed]["original_name"]}",
                                  style: TextStyleManager
                                      .getNormalWhiteTextStyle(),
                                ))
                          ])),
              SizedBox(
                height: 4.w,
              ),
              (widget.c.genreList.isEmpty)
                  ? Shimmer.fromColors(
                      child: Container(
                        height: 2.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return CustomChipButton(
                                width: width * 0.2,
                                text: "Peaky blinders",
                              );
                            }),
                      ),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!)
                  : Container(
                      height: 2.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return CustomChipButton(
                            onTap: (){
                              Get.toNamed(DetailByGenreScreen.route, arguments: {
                          "id" : widget.c.genreList["genres"][index],
                          "type" : "tv"});
                              print("clicked");
                            },
                            width: width * 0.2,
                            text: widget.c.genreList["genres"][index]["name"],
                          );
                        },
                      ),
                    ),

              Text(
                "Trending Now",
                style: TextStyleManager.getLargeWhiteTextStyle(
                    color: ColorManager.primaryColor, fontSize: 18.sp),
              ),
              SizedBox(
                height: 4.w,
              ),
              Expanded(
                child: CarouselSlider(
                    options: CarouselOptions(height: 400.h),
                    items: List.generate(10, (index) {
                      return (widget.c.listTvData.isEmpty) ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: TvCarouselItems(index: index,width: width, c: widget.c)): TvCarouselItems(index: index,width: width, c: widget.c);
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}