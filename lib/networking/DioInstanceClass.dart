import 'package:dio/dio.dart';

class DioInstanceClass {

  static String imagePath ="https://image.tmdb.org/t/p/original/";
  static String apiKey ="?api_key=d45066a42d2ec805bfc3d2de826995b8";

  static Future<String> postRequest(FormData formData,String url) async {
    Dio dio = Dio();
    var response = await dio.post("https://api.themoviedb.org/3/movie/"+url, data: formData);
//    print(response.toString());
    return response.data;
  }

  static Future<Response> getRequest(String url) async {
    Dio dio = Dio();
    final response = await dio.get("https://api.themoviedb.org/3/movie/"+url);
//    print(response.toString());
    return response;
  }
}
