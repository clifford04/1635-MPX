import 'dart:convert';
import 'package:mpx1635/models/MovieModel.dart';
import 'package:mpx1635/models/MovieDetailModel.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static const String _apiKey = "eb0d5538";
  static const String _baseUrl = "http://www.omdbapi.com/";

  Future<List<MovieModel>> fetchMovies(String keyword) async {
    String url = "$_baseUrl?s=$keyword&apikey=$_apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body["Response"] == "False") {
        throw Exception(body["Error"] ?? "Unable to perform request!");
      }

      final Iterable json = body["Search"];

      return json.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  /// Fetch detailed movie information by imdbID
  Future<MovieDetailModel> fetchMovieDetails(String imdbID) async {
    String url = "$_baseUrl?i=$imdbID&apikey=$_apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body["Response"] == "False") {
        throw Exception(body["Error"] ?? "Unable to fetch movie details!");
      }

      return MovieDetailModel.fromJson(body);
    } else {
      throw Exception("Unable to fetch movie details!");
    }
  }
}
