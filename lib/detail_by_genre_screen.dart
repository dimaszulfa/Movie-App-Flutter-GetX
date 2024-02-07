import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class DetailByGenreScreen extends StatefulWidget {
  DetailByGenreScreen({super.key});

  static const String route = '/detil-by-genre';
    final Controller c = Get.find();

  @override
  State<DetailByGenreScreen> createState() => _DetailByGenreScreenState();
}

class _DetailByGenreScreenState extends State<DetailByGenreScreen> {
  final  arguments = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.c.getMoviesByGenreId(arguments["id"]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.c.listMoviesByGenre = {}.obs;
  }
  
  @override
  Widget build(BuildContext context) {

    print(arguments["name"] + "TES");
    return Obx(()=>Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          "Genre ${arguments["name"]}",
          style: TextStyleManager.getNormalWhiteTextStyle(),
        ),
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: (widget.c.listMoviesByGenre.isEmpty) ? SizedBox(
       child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
         child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: AppPadding.size8),
              itemCount: 20,
              cacheExtent: 9999,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, int) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: AppPadding.size4, vertical: AppPadding.size8),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/peaky_blinders_header.jpg"))),
                );
              }),
       ),      ) :  Container(
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: AppPadding.size8),
            itemCount: 20,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, int) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: AppPadding.size8, horizontal: AppPadding.size8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.size16),
                  child: CachedNetworkImage(
                    memCacheHeight: 1000,
                    memCacheWidth: 1000,
                    imageUrl: "${AssetImageManager.assetNetworkUrl + widget.c.listMoviesByGenre["results"][int]["poster_path"]}",
                  placeholder: (context, url) => SizedBox(
                    child: Shimmer.fromColors(child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/images/peaky_blinders_header.jpg"))
                      ),
                    ), baseColor: ColorManager.primaryColor, highlightColor: ColorManager.primaryContainer),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  
                  ),
                ),
              );
            
              // return Container(
              //   margin: EdgeInsets.symmetric(horizontal: AppPadding.size4, vertical: AppPadding.size8),
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.cover,
              //           image: NetworkImage(
              //               "${AssetImageManager.assetNetworkUrl + widget.c.listMoviesByGenre["results"][int]["poster_path"]}"))),
              // );
            }),
      ),
    ));
  }
}
