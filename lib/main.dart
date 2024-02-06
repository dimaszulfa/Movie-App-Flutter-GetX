import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movie_getx/app.dart';
import 'package:movie_getx/constants/asset_image_manager.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/theme_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeManager.lightTheme,
        darkTheme: ThemeManager.lightTheme,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                    labelColor: ColorManager.secondaryContainer,
                    unselectedLabelColor: ColorManager.secondaryColor,
                    tabs: [
                      Tab(
                        child: Text("Movie"),
                        icon: Icon(Icons.movie),
                      ),
                      Tab(
                        child: Text("TV"),
                        icon: Icon(Icons.tv),
                      ),
                    ]),
              ),
              body: TabBarView(children: [MovieScreen(), Icon(Icons.tv)]),
            )),
      );
    });
  }
}

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
              (c.obj.isEmpty)
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
                                          "${AssetImageManager.assetNetworkUrl + c.obj["results"][randomed]["backdrop_path"]}"))),
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
                            width: width * 0.2,
                            text: c.genreList["genres"][index]["name"],
                          );
                        },
                      ),
                    ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       CustomChipButton(
              //         width: width * 0.2,
              //         text: "Peaky blinders",
              //       ),
              //       CustomChipButton(
              //         width: width * 0.2,
              //         text: "Peaky blinders",
              //       ),
              //       CustomChipButton(
              //         width: width * 0.2,
              //         text: "Peaky blinders",
              //       ),
              //       CustomChipButton(
              //         width: width * 0.2,
              //         text: "Peaky blinders",
              //       ),
              //       CustomChipButton(
              //         width: width * 0.2,
              //         text: "Peaky blinders",
              //       ),

              //     ],
              //   ),
              // ),
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

class MovieCarouselItems extends StatelessWidget {
  const MovieCarouselItems({
    super.key,
    required this.width,
    required this.c, this.index,
  });

  final double width;
  final Controller c;
  final index;

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
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/peaky_blinders_header.jpg"))
                  ),
                )
              ),
            ) : CachedNetworkImage(
                  imageUrl: "${AssetImageManager.assetNetworkUrl + c.obj["results"][index]["poster_path"]}",
                  placeholder: (context, url) {
                    return Shimmer.fromColors(child: Container(), baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
                  },
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ));
                  },
                ),
          ),
        ),
        SizedBox(height: 1.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomChipButton(
                width: width * 0.1,
                text: "Peaky blinders",
              ),
              CustomChipButton(
                width: width * 0.1,
                text: "Peaky blinders",
              ),
              CustomChipButton(
                width: width * 0.1,
                text: "Peaky blinders",
              ),
            ],
          ),
        ),
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

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    super.key,
    required this.width,
    required this.text,
  });

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();

    return GestureDetector(
      onTap: () => print(c.obj),
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
