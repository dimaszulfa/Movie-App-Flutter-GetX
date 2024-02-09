import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:movie_getx/detail_by_genre_screen.dart';
import 'package:movie_getx/screen/movie_carousel_items.dart';
import 'package:movie_getx/widgets/custom_chip_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final Controller c = Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.getData();
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
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.size32, horizontal: AppPadding.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coming soon",
                style: TextStyleManager.getLargeWhiteTextStyle(
                    fontSize: 18.sp, color: ColorManager.primaryColor),
              ),
              (c.obj.isEmpty)
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 200,
                        width: width * 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            image: const DecorationImage(
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
                                          AssetImageManager.assetNetworkUrl + c.obj["results"][randomed]["backdrop_path"]))),
                            ),
                            Positioned(
                                left: 10,
                                bottom: 5,
                                child: Text(
                                  "${c.obj["results"][randomed]["original_title"]}",
                                  style: TextStyleManager
                                      .getNormalWhiteTextStyle(),
                                ))
                          ])),
              SizedBox(
                height: 4.w,
              ),
              (c.genreList.isEmpty)
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SizedBox(
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
                      ))
                  : SizedBox(
                      height: 2.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return CustomChipButton(
                            onTap: (){
                              Get.toNamed(DetailByGenreScreen.route, arguments: {
                          "id" : c.genreList["genres"][index],
                          "type" : "movie"});
                              print("clicked");
                            },
                            width: width * 0.2,
                            text: c.genreList["genres"][index]["name"],
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
                      return (c.obj.isEmpty) ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: MovieCarouselItems(index: index,width: width, c: c)): MovieCarouselItems(index: index,width: width, c: c);
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
