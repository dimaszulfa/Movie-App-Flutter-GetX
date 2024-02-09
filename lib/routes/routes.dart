import 'package:get/get.dart';
import 'package:movie_getx/detail_by_genre_screen.dart';
import 'package:movie_getx/screen/movie_detail_item.dart';
import 'package:movie_getx/screen/my_app.dart';
import 'package:movie_getx/screen/tv/tv_detail_item.dart';

class Routes{
  static List<GetPage> generateRoutes(){
    return [
      GetPage(name: MyApp.route, page: ()=> const MyApp()),
      GetPage(name: DetailByGenreScreen.route, page: ()=> DetailByGenreScreen()),
      GetPage(name: MovieDetailitem.route, page: ()=> const MovieDetailitem()),
      GetPage(name: TvDetailItem.route, page: ()=> const TvDetailItem()),
    ];
  }
}