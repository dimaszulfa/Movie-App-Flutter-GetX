import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:movie_getx/controllers/tv_controller.dart';
import 'package:movie_getx/screen/movie_detail_item.dart';
import 'package:movie_getx/screen/tv/tv_detail_item.dart';
import 'package:movie_getx/widgets/custom_chip_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class TvCarouselItems extends StatelessWidget {
  const TvCarouselItems({
    super.key,
    required this.width,
    required this.c, this.index,
  });

  final double width;
  final TvController c;
  final index;

  String _getGenreData(genreId){
    if(c.genreList.isNotEmpty){
        var genreList = c.genreList["genres"] as List;
        int index = genreList.indexWhere((element) => element["id"] == genreId);
      return c.genreList["genres"][index]["name"];
    }else{
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: (c.listTvData.isEmpty) ? SizedBox(
              width: 200.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red[300]!,
                highlightColor: Colors.red[100]!,
                child: Container(
                  width: 200.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/peaky_blinders_header.jpg"))
                  ),
                )
              ),
            ) : CachedNetworkImage(
                  imageUrl: "${AssetImageManager.assetNetworkUrl + c.listTvData["results"][index]["poster_path"]}",
                  placeholder: (context, url) {
                    return Shimmer.fromColors(child: Container(), baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
                  },
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                  imageBuilder: (context, imageProvider) {
                    return InkWell(
                    borderRadius: BorderRadius.circular(18),
                      onTap: (){
                        Get.toNamed(TvDetailItem.route, arguments: c.listTvData["results"][index]["id"]);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      )),
                    );
                  },
                ),
          ),
        ),
        SizedBox(height: 1.h),
        (c.genreList.isEmpty) ? SizedBox(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 2.5.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,itemCount:  3 ,itemBuilder: (context, number) {
            
                return  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.5.h),
                  child: CustomChipButton(
                        width: width * 0.14,
                        text: "Hallo",
                      ),
                );
              },),
            ),
          ),
        ):Container(
          height: 2.5.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,itemCount:  ((c.listTvData["results"][index]["genre_ids"] as List).length > 3) ? 3 :  (c.listTvData["results"][index]["genre_ids"] as List).length,itemBuilder: (context, number) {

            return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.5.h),
              child: CustomChipButton(
                    width: width * 0.14,
                    text: _getGenreData(c.listTvData["results"][index]["genre_ids"][number]),
                  ),
            );
          },),
        )
        ,
        SizedBox(height: 1.h),
        (c.listTvData.isEmpty) ? CustomChipButton(
          width: width * 0.5,
          text: "Place Holder",
        ) :CustomChipButton(
          width: width * 0.5,
          text: c.listTvData["results"][index]["original_name"],
        )
      ],
    );
  }
}

