import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:themovie/model/result.dart';
import 'package:themovie/networking/DioInstanceClass.dart';

import 'MovieDetails.dart';
import 'model/movielist.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppPage();
  }
}

class _AppPage extends State<DashBoardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _textController = new TextEditingController();

  List<MovieList> _movieArray = List<MovieList>();
  List<Result> _allMovieList = List<Result>();
  List<Result> _allMovieListTemp = List<Result>();
  List<Result> movieList2 = List<Result>();

  bool typing = false;

  @override
  void initState() {
    super.initState();
    getMovieDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                typing ? Icons.done : Icons.search,
                color: typing ? Colors.white : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (typing) {
                    if (_allMovieListTemp.length > 0) {
                      setState(() {
                        getSearchDetails(_allMovieListTemp, _textController.value);
                      });
                    } else {
                      setState(() {
                        _allMovieListTemp = _allMovieList;
                        getSearchDetails(_allMovieListTemp, _textController.value);

                      });
                    }
                    typing = !typing;
                  } else {
                    typing = !typing;
                  }
                });
              },
            ),
          ],
          backgroundColor: typing ? Colors.blue : Colors.white,
          title: typing
              ? textBody()
              : Text(
                  "TMDB",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                ),
          elevation: 0,
        ),
        body: listWidgetBody());
  }

  Widget textBody() {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.blue,
      child: TextField(
        controller: _textController,
        cursorColor: Colors.white,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white30),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search,color: Colors.white,),
          hintText: 'Search here',
        ),
      ),
    );
  }

  Widget listWidgetBody() {
    return ListView.builder(
      itemCount: _allMovieList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MovieDetails(_allMovieList[index].id)));
          },
          child: Container(
            child: Card(
              elevation: 10,
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.fromLTRB(30, 25, 30, 15),
              child: Container(
                child: Column(children: <Widget>[
                  ProgressiveImage(
                    placeholder: AssetImage('assets/images/logo.png'),
                    thumbnail: NetworkImage(DioInstanceClass.imagePath +
                        _allMovieList[index].posterPath),
                    image: NetworkImage(DioInstanceClass.imagePath +
                        _allMovieList[index].posterPath),
                    fit: BoxFit.contain,
                    height: 500,
                    width: double.maxFinite,
                  ),
//              new Image.network(
//                DioInstanceClass.imagePath + _allMovieList[index].posterPath,
//                fit: BoxFit.fitHeight,
//                width: double.maxFinite,
//                loadingBuilder: (context, child, loadingProgress) {
//                  return loadingProgress == null
//                      ? Image.asset("assets/images/nodatanew.png")
//                      : LinearProgressIndicator();
//                },
//              ),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    _allMovieList[index].title,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    "Release Date: " + _allMovieList[index].releaseDate,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Future getMovieDetails() async {
    var response =
        await DioInstanceClass.getRequest("popular" + DioInstanceClass.apiKey);
//    print(response.data);
    if (response.statusCode == 200) {
      setState(() {
        MovieList jsonResponse = MovieList.fromJson(response.data);
        _allMovieList = jsonResponse.results;
//        getDetails(_allMovieList, _textController.value);
      });
    }
  }

  getSearchDetails(List<Result> movieList, TextEditingValue value) async {
    movieList2.clear();
    search(movieList, value.text);
//    int result = search(movieList, value.text);
//    if (result == "") {
//      print("Element is not present in array");
//    } else {
//      print("index at: " + result);
//    }
  }

  search(List<Result> arr, String x) {
    int n = arr.length;
    for (int i = 0; i < n; i++) {
      if (arr[i].title.startsWith(x)) {
        movieList2.add(arr[i]);
        setState(() {
          _allMovieList = movieList2;
        });
      }
    }
  }
}
