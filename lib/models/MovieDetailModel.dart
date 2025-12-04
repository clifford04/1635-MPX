/// Extended movie model with full details from OMDb API
class MovieDetailModel {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  final String? plot;
  final String? director;
  final String? actors;
  final String? genre;
  final String? runtime;
  final String? imdbRating;
  final String? rated;
  final String? released;
  final String? writer;
  final String? language;
  final String? country;
  final String? awards;
  final String? boxOffice;
  final String? production;
  final String? website;

  MovieDetailModel({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
    this.plot,
    this.director,
    this.actors,
    this.genre,
    this.runtime,
    this.imdbRating,
    this.rated,
    this.released,
    this.writer,
    this.language,
    this.country,
    this.awards,
    this.boxOffice,
    this.production,
    this.website,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      title: json["Title"] ?? "Unknown Title",
      year: json["Year"] ?? "Unknown Year",
      imdbID: json["imdbID"] ?? "",
      type: json["Type"] ?? "movie",
      poster: json["Poster"] ?? "",
      plot: json["Plot"],
      director: json["Director"],
      actors: json["Actors"],
      genre: json["Genre"],
      runtime: json["Runtime"],
      imdbRating: json["imdbRating"],
      rated: json["Rated"],
      released: json["Released"],
      writer: json["Writer"],
      language: json["Language"],
      country: json["Country"],
      awards: json["Awards"],
      boxOffice: json["BoxOffice"],
      production: json["Production"],
      website: json["Website"],
    );
  }

  /// Convert to basic MovieModel for compatibility
  Map<String, dynamic> toBasicMovieJson() {
    return {
      "Title": title,
      "Year": year,
      "imdbID": imdbID,
      "Type": type,
      "Poster": poster,
    };
  }
}

