import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:movie_getx/screen/movie_detail_item.dart';
import 'package:movie_getx/widgets/custom_chip_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MovieCarouselItems extends StatelessWidget {
  const MovieCarouselItems({
    super.key,
    required this.width,
    required this.c, this.index,
  });

  final double width;
  final Controller c;
  final index;

  String _getGenreData(genreId){
       if(c.genreList.isNotEmpty){
        var genreList = c.genreList["genres"] as List;
        int index = genreList.indexWhere((element) => element["id"] == genreId);
      return c.genreList["genres"][index]["name"];
       } else{
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
            child: (c.obj.isEmpty) ? SizedBox(
              width: 200.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red[300]!,
                highlightColor: Colors.red[100]!,
                child: Container(
                  width: 200.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/peaky_blinders_header.jpg"))
                  ),
                )
              ),
            ) : CachedNetworkImage(
                  imageUrl: AssetImageManager.assetNetworkUrl + c.obj["results"][index]["poster_path"],
                  placeholder: (context, url) {
                    return Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: Container());
                  },
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) {
                    return InkWell(
                    borderRadius: BorderRadius.circular(18),
                      onTap: (){
                        Get.toNamed(MovieDetailitem.route, arguments: {
                          "id" : c.obj["results"][index]["id"],
                          "type" : "movie"});
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
        (c.obj.isEmpty) ? SizedBox(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: SizedBox(
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
        ):SizedBox(
          height: 2.5.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,itemCount:  ((c.obj["results"][index]["genre_ids"] as List).length > 3) ? 3 :  (c.obj["results"][index]["genre_ids"] as List).length,itemBuilder: (context, number) {

            return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.5.h),
              child: CustomChipButton(
                    width: width * 0.14,
                    text: _getGenreData(c.obj["results"][index]["genre_ids"][number]),
                  ),
            );
          },),
        )
        ,
        SizedBox(height: 1.h),
        (c.obj.isEmpty) ? CustomChipButton(
          width: width * 0.5,
          text: "Place Holder",
        ) :CustomChipButton(
          width: width * 0.5,
          text: c.obj["results"][index]["original_title"],
        )
      ],
    );
  }
}

