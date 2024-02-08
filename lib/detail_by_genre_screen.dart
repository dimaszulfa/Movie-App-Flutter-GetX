import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:movie_getx/controllers/tv_controller.dart';
import 'package:movie_getx/screen/movie_detail_item.dart';
import 'package:movie_getx/screen/tv/tv_detail_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class DetailByGenreScreen extends StatefulWidget {
  DetailByGenreScreen({super.key});

  static const String route = '/detil-by-genre';
    final Controller c = Get.find();
    final TvController cTv = Get.find();

  @override
  State<DetailByGenreScreen> createState() => _DetailByGenreScreenState();
}

class _DetailByGenreScreenState extends State<DetailByGenreScreen> {
  final  arguments = Get.arguments as Map;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(arguments["id"]);
    if(arguments["type"] == 'movie'){
      print("MOVIE");
      widget.c.getMoviesByGenreId(arguments["id"]["id"]);
    }else{
            print("TV");
       widget.cTv.getTvByGenreId(arguments["id"]["id"]);
      
    }
    print("tes");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.c.listMoviesByGenre = {}.obs;
    widget.cTv.listTvByGenre = {}.obs;
  }
  
  @override
  Widget build(BuildContext context) {

    return Obx(()=>Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          "Genre ${arguments["id"]["name"]}",
          style: TextStyleManager.getNormalWhiteTextStyle(),
        ),
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body:(arguments["type"] == "movie") ? (widget.c.listMoviesByGenre.isEmpty) ? SizedBox(
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
              return GestureDetector(
                onTap: (){
                    if(arguments["type"] == "tv"){
                  print("clicked tv");
               Get.toNamed(TvDetailItem.route, arguments: widget.cTv.listTvByGenre["results"][int]["id"]);

              }else{
                                  print("clicked movie ");

               Get.toNamed(MovieDetailitem.route, arguments: widget.c.listMoviesByGenre["results"][int]["id"]);

              }
                },
                child: Container(
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
            
             ):(widget.cTv.listTvByGenre.isEmpty) ? SizedBox(
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
              return GestureDetector(
                onTap: (){
                    if(arguments["type"] == "tv"){
                  print("clicked tv");
               Get.toNamed(TvDetailItem.route, arguments: widget.cTv.listTvByGenre["results"][int]["id"]);

              }else{
                                  print("clicked movie ");

               Get.toNamed(MovieDetailitem.route, arguments: widget.c.listMoviesByGenre["results"][int]["id"]);

              }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.size8, horizontal: AppPadding.size8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.size16),
                    child: CachedNetworkImage(
                      memCacheHeight: 1000,
                      memCacheWidth: 1000,
                      imageUrl: "${AssetImageManager.assetNetworkUrl + widget.cTv.listTvByGenre["results"][int]["poster_path"]}",
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
            })) ,
    ));
  }
}
