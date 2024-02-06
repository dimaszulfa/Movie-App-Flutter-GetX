import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movie_getx/app.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/text_style_manager.dart';
import 'package:movie_getx/constants/theme_manager.dart';
import 'package:movie_getx/constants/values_manager.dart';
import 'package:movie_getx/controllers/controller.dart';
import 'package:sizer/sizer.dart';

void main()async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      final Controller c = Get.put(Controller());

    return Sizer(
      builder: (context, orientation, deviceType){
        return  GetMaterialApp(
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
              body: TabBarView(
                children: [MovieScreen(), Icon(Icons.tv)]),
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
  }


  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

    return Obx(
      () => (c.obj.isEmpty)
          ? CircularProgressIndicator()
          : Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppPadding.size16, horizontal: AppPadding.size16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coming soon",style: TextStyleManager.getLargeWhiteTextStyle(fontSize: 18.sp,color: ColorManager.primaryColor),),
                    Container(
                      
                      height: 200,
                      width: width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/peaky_blinders_header.jpg"))),
                    ),
                    SizedBox(height: 4.w,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                          CustomChipButton(width: width),
                        ],
                      ),
                    ),
                    Text("Trending Now", style: TextStyleManager.getLargeWhiteTextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 18.sp
                    ),),
                    SizedBox(height: 4.w,),
                    Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        width: MediaQuery.of(context).size.width * 1,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration:
                                            BoxDecoration(color: Colors.amber),
                                        child: Text(
                                          'text $i',
                                          style: TextStyle(fontSize: 16.0),
                                        )),
                                  ),
                                    Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Chip(label: Text("18+"), ),
                                    Chip(label: Text("18+"), ),
                                    Chip(label: Text("18+"), ),
                                  ],
                                ),
                                Text("Angle Has Fallen")
                                ],
              
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("clicked"),
      child: Container(
        width: width * 0.1,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: Text("All", style: TextStyleManager.getSmallWhiteTextStyle(), textAlign: TextAlign.center,),
      ),
    );
  }
}
