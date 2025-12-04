class MovieModel {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  MovieModel({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json["Title"] ?? "Unknown Title",
      year: json["Year"] ?? "Unknown Year",
      imdbID: json["imdbID"] ?? "",
      type: json["Type"] ?? "movie",
      poster: json["Poster"] ?? "",
    );
  }
}