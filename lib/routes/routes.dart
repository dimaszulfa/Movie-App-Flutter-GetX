import 'package:get/get.dart';
import 'package:movie_getx/detail_by_genre_screen.dart';
import 'package:movie_getx/main.dart';

class Routes{
  static List<GetPage> generateRoutes(){
    return [
      GetPage(name: MyApp.route, page: ()=> MyApp()),
      GetPage(name: DetailByGenreScreen.route, page: ()=> DetailByGenreScreen()),
    ];
  }
}