import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
final Map obj = {}.obs;
final isLoading = true.obs;
  getData() async {
    var token = dotenv.env["TOKEN"];
    // var url = Uri.parse("https://api.themoviedb.org/3/discover/movie?api_key=${token}");
    var header = {
      "Authorization" : "Bearer $token",
      "Content-Type" : "application/json"
    };


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
}
