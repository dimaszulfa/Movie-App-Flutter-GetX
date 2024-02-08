import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Controller extends GetxController {
  final Map obj = {}.obs;
  final isLoading = true.obs;
  final Map genreList = {}.obs;
  var token = dotenv.env["TOKEN"];
  var listMoviesByGenre = {}.obs;
  var movieDetail = {}.obs;

  getData() async {
    var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    await Future.delayed(Duration(seconds: 3));
    var response = await Dio().get(
      "https://api.themoviedb.org/3/discover/movie?api_key=${token}",
      options: Options(
        headers: header,
      ),
    );
    obj.addAll(response.data);
    isLoading(false);
    print(response.data);
  }

  getMovieDetail(movie_id) async {
    var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    await Future.delayed(Duration(seconds: 3));
    var response = await Dio().get(
      "https://api.themoviedb.org/3/movie/${movie_id}?api_key=${token}",
      options: Options(
        headers: header,
      ),
    );
    movieDetail.addAll(response.data);
    print(response.data);
  }

  getMoviesByGenreId(id) async {
   var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    print("https://api.themoviedb.org/3/discover/movie?with_genres=${id}?api_key=${token}");

    return await Dio().get(
      "https://api.themoviedb.org/3/discover/movie?api_key=${token}",
      queryParameters: {
        "with_genres": id
      },
      options: Options(
        headers: header
      )
    ).then((value) {
      print(value.data);
      return listMoviesByGenre.addAll(value.data);});
  

    

  }

  getGenres() async {
    var header = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    await Future.delayed(Duration(seconds: 3));

    var response = await Dio().get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=${token}",
        options: Options(headers: header));

    genreList.addAll(response.data);
    print(response.data);
  }
}
