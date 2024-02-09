import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/controllers/tv_controller.dart';
import 'package:movie_getx/widgets/custom_chip_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class TvDetailItem extends StatefulWidget {
  const TvDetailItem({super.key});

  static const String route = "/tv-detail-item";
  @override
  State<TvDetailItem> createState() => _TvDetailItemState();
}

class _TvDetailItemState extends State<TvDetailItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final int id = Get.arguments;
    final TvController c = Get.find();
    c.getTvDetail(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    c.tvDetail = {}.obs;
  }

  final TvController c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          actions: const [],
          title: Text(
            "Detail TV",
            style: TextStyleManager.getNormalWhiteTextStyle(),
          ),
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back, color: Colors.white)),
        ),
        body: (c.tvDetail.isEmpty) ? const Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (c.tvDetail.isEmpty)
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
                            image: const DecorationImage(
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
                                "${AssetImageManager.assetNetworkUrl}${c.tvDetail["poster_path"]}"))),
                  ),
            Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                          height: 2.5.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount:
                                (c.tvDetail["genres"] as List)
                                    .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return    CustomChipButton(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  text: c.tvDetail["genres"][index]["name"]);
                            },
                          ),
                        ),
                  SizedBox(height: 2.h),
                  Text(
                    c.tvDetail["name"],
                    style: TextStyleManager.getBoldBlackTextStyle(),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    c.tvDetail["overview"],
                    style: TextStyleManager.getSmallBlackTextStyle(),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Text("Product Companies",
                      style: TextStyleManager.getBoldBlackTextStyle()),
                  (c.tvDetail.isEmpty)
                      ? SizedBox(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: ColorManager.primaryColor,
                            child: SizedBox(
                              height: 15.h,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount:
                                    (c.tvDetail["production_companies"]
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
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/images/peaky_blinders_header.jpg"))),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 15.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount:
                                (c.tvDetail["production_companies"] as List)
                                    .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return (c.tvDetail["production_companies"][index]["logo_path"] == null )? const SizedBox.shrink():Container(
                                margin: EdgeInsets.only(right: 2.h),
                                height: 200,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.h),
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage(
                                "${AssetImageManager.assetNetworkUrl}${c.tvDetail["production_companies"][index]["logo_path"]}"))),
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
