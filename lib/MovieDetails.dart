import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'model/MovieDetailsModel.dart';
import 'networking/DioInstanceClass.dart';

class MovieDetails extends StatefulWidget {
  final int movieID;

  MovieDetails(this.movieID);

  @override
  State<StatefulWidget> createState() {
    return _AppPage(movieID);
  }
}

class _AppPage extends State<MovieDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ProductionCompany> _companyArray = List<ProductionCompany>();
  List<Genre> _genresArray = List<Genre>();
  List _listings = new List();

  var movieID;

  _AppPage(this.movieID);

  MovieDetailsModel details;

  @override
  void initState() {
    super.initState();

    getAllMovieDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
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
      body: FutureBuilder(
          future: getAllMovieDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return appBody();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
//      body: appBody(),
    );
  }

  Widget horizontalScrollGenres() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _genresArray.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 10,
            shadowColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.fromLTRB(30, 25, 30, 15),
            child: new Text(
              _genresArray[index].name,
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget appBody() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ProgressiveImage(
            placeholder: AssetImage('assets/images/logo.png'),
            thumbnail:
                NetworkImage(DioInstanceClass.imagePath + details.posterPath),
            image:
                NetworkImage(DioInstanceClass.imagePath + details.posterPath),
            fit: BoxFit.contain,
            height: 500,
            width: double.maxFinite,
          ),
          Card(
              elevation: 10,
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Center(
                  child: Column(
                    children: [
                      new Text(
                        details.originalTitle,
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      new Text(
                        details.overview,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
//          horizontalScrollGenres(),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    "assets/images/star.png",
                    height: 40,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    details.voteAverage,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    " /10",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Votes - " + details.voteCount,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                )
              ],
            ),
          ),
//          Container(
//            padding: EdgeInsets.all(5),
//            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
//            child: Row(
//              children: [
//                Expanded(
//                  flex: 5,
//                  child: Text(
//                    details.runtime + " Min",
//                    textAlign: TextAlign.end,
//                    style: TextStyle(
//                      fontSize: 16,
//                      fontStyle: FontStyle.normal,
//                      color: Colors.black87,
//                    ),
//                  ),
//                ),
//                Expanded(
//                  flex: 5,
//                  child: Text(
//                    details.releaseDate,
//                    textAlign: TextAlign.end,
//                    style: TextStyle(
//                      fontSize: 15,
//                      fontStyle: FontStyle.normal,
//                      color: Colors.black87,
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
            height: 40,
            child: new ListView.builder(
//              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _genresArray.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  margin: EdgeInsets.all(5),
                  child: new Text(
                    _genresArray[index].name,
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          Card(
            elevation: 10,
            shadowColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),

            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Wrap(
              children: <Widget>[
                Container(
                  padding:EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: new Text(
                    "Production Company",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:EdgeInsets.only(bottom: 15),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: new ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _companyArray.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _companyArray[index].logoPath == null
                                  ? Image.asset("assets/images/logo_new.png")
                                  : ProgressiveImage(
                                      placeholder: AssetImage(
                                          'assets/images/logo_new.png'),
                                      thumbnail: NetworkImage(
                                          DioInstanceClass.imagePath +
                                              _companyArray[index].logoPath),
                                      image: NetworkImage(
                                          DioInstanceClass.imagePath +
                                              _companyArray[index].logoPath),
                                      fit: BoxFit.contain,
                                      height: 30,
                                      width: double.maxFinite,
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 8,
                              child: new Text(
                                _companyArray[index].name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//  List<Widget> _getListings() {
//    List listings = List<Widget>();
//    for (int i = 0; i < _genresArray.length; i++) {
//      listings.add(new Text(
//        _genresArray[i].name,
//        style: TextStyle(
//            fontSize: 12,
//            fontStyle: FontStyle.normal,
//            color: Colors.black87,
//            fontWeight: FontWeight.bold),
//      ));
//    }
//    return listings;
//  }

  Future<dynamic> getAllMovieDetails() async {
    var response = await DioInstanceClass.getRequest(
        movieID.toString() + DioInstanceClass.apiKey);
    if (response.statusCode == 200) {
      setState(() {
        details = MovieDetailsModel.fromJson(response.data);
        _companyArray = details.productionCompanies;
        _genresArray = details.genres;
      });
    }
    return details;
  }
}
