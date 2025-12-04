import 'dart:convert';
import 'package:mpx1635/models/MovieModel.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  Future<List<MovieModel>> fetchMovies(String keyword) async {
    String url = "http://www.omdbapi.com/?s=$keyword&apikey=eb0d5538";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final Iterable json = body["Search"];

      return json.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
