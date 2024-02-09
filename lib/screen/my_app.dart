import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/constants/color_manager.dart';
import 'package:movie_getx/constants/theme_manager.dart';
import 'package:movie_getx/routes/routes.dart';
import 'package:movie_getx/screen/movie_screen.dart';
import 'package:movie_getx/screen/tv/tv_screen.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const route = '/';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeManager.lightTheme,
        darkTheme: ThemeManager.lightTheme,
        initialRoute: MyApp.route,
        getPages: Routes.generateRoutes(),
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                    labelColor: ColorManager.secondaryContainer,
                    unselectedLabelColor: ColorManager.secondaryColor,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.movie),
                        child: Text("Movie"),
                      ),
                      Tab(
                        icon: Icon(Icons.tv),
                        child: Text("TV"),
                      ),
                    ]),
              ),
              body: TabBarView(children: [const MovieScreen(), TvScreen()]),
            )),
      );
    });
  }
}
