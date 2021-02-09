import 'result.dart';

class MovieList {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;


  MovieList({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });


  factory MovieList.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Result> resultList = list.map((i) => Result.fromJson(i)).toList();

    return MovieList(
      page: json["page"],
      results: resultList,
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}