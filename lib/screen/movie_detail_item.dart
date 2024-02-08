import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:movie_getx/widgets/custom_chip_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MovieDetailitem extends StatefulWidget {
  MovieDetailitem({super.key});

  static const String route = "/movie-detail-item";
  @override
  State<MovieDetailitem> createState() => _MovieDetailitemState();
}

class _MovieDetailitemState extends State<MovieDetailitem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final int id = Get.arguments;
    final Controller c = Get.find();
    c.getMovieDetail(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    c.movieDetail = {}.obs;
  }

  final Controller c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text(
            "Detail Movie",
            style: TextStyleManager.getNormalWhiteTextStyle(),
          ),
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back, color: Colors.white)),
        ),
        body: (c.movieDetail.isEmpty) ? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (c.movieDetail.isEmpty)
                ? SizedBox(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: ColorManager.primaryColor,
                      child: Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(2.h),
                                bottomRight: Radius.circular(2.h)),
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    "assets/images/peaky_blinders_header.jpg"))),
                      ),
                    ),
                  )
                : Container(
                    height:60.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(2.h),
                            bottomRight: Radius.circular(2.h)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "${AssetImageManager.assetNetworkUrl}${c.movieDetail["poster_path"]}"))),
                  ),
            Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                          height: 2.5.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount:
                                (c.movieDetail["genres"] as List)
                                    .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return    CustomChipButton(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  text: c.movieDetail["genres"][index]["name"]);
                            },
                          ),
                        ),
                  SizedBox(height: 2.h),
                  Text(
                    c.movieDetail["title"],
                    style: TextStyleManager.getBoldBlackTextStyle(),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    c.movieDetail["overview"],
                    style: TextStyleManager.getSmallBlackTextStyle(),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Text("Product Companies",
                      style: TextStyleManager.getBoldBlackTextStyle()),
                  (c.movieDetail.isEmpty)
                      ? SizedBox(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: ColorManager.primaryColor,
                            child: Container(
                              height: 15.h,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount:
                                    (c.movieDetail["production_companies"]
                                            as List)
                                        .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 2.h),
                                    height: 200,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2.h),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/images/peaky_blinders_header.jpg"))),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 15.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount:
                                (c.movieDetail["production_companies"] as List)
                                    .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return (c.movieDetail["production_companies"][index]["logo_path"] == null )? SizedBox.shrink():Container(
                                margin: EdgeInsets.only(right: 2.h),
                                height: 200,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.h),
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage(
                                "${AssetImageManager.assetNetworkUrl}${c.movieDetail["production_companies"][index]["logo_path"]}"))),
                              );
                            },
                          ),
                        )
                ],
              ),
            )
          ],
        ))));
  }
}
