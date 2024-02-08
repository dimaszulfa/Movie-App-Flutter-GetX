import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class TvController extends GetxController{
  var listTvData = {}.obs;
  var genreList = {}.obs;
  var tvDetail = {}.obs;
  var listTvByGenre = {}.obs;

    var token = dotenv.env["TOKEN"];


  getListTvData() async {

    var response = await Dio().get(
      "https://api.themoviedb.org/3/discover/tv?api_key=${token}",
    );

    print(response.data);
    listTvData.addAll(response.data);
  }

  getGenres() async {
    var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    await Future.delayed(Duration(seconds: 3));

    var response = await Dio().get(
        "https://api.themoviedb.org/3/genre/tv/list?api_key=${token}",
        options: Options(headers: header));

    genreList.addAll(response.data);
    print(response.data);
  }

   getTvDetail(tv_id) async {
    var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    await Future.delayed(Duration(seconds: 3));
    var response = await Dio().get(
      "https://api.themoviedb.org/3/tv/${tv_id}?api_key=${token}",
      options: Options(
        headers: header,
      ),
    );
    tvDetail.addAll(response.data);
    print(response.data);
  }


    getTvByGenreId(id) async {
   var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "accept": "application/json"
    };


    return await Dio().get(
      "https://api.themoviedb.org/3/discover/tv?api_key=${token}",
      queryParameters: {
        "with_genres": id
      },
      options: Options(
        headers: header
      )
    ).then((value) {
      print(value.data);
      return listTvByGenre.addAll(value.data);});
  

    

  }
}