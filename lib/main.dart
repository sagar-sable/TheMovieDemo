import 'package:flutter/material.dart';
import 'DashBoardPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashBoardPage(),
    );
  }
}

//https://stackoverflow.com/questions/59063095/dioerror-dioerrortype-response-http-status-error-400-exception

//The Movie DataBase
//https://www.themoviedb.org/documentation/api/discover

//Movies List
//https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d45066a42d2ec805bfc3d2de826995b8

//Movie Details
//https://api.themoviedb.org/3/movie/464052?api_key=d45066a42d2ec805bfc3d2de826995b8

//Image Path
//https://image.tmdb.org/t/p/original/52AfXWuXCHn3UjD17rBruA9f5qb.jpg

//https://developers.themoviedb.org/3/collections/get-collection-details

//https://api.themoviedb.org/3/movie/popular?api_key=d45066a42d2ec805bfc3d2de826995b8
//GET
//Get Latest
///movie/latest
//GET
//Get Now Playing
///movie/now_playing
//GET
//Get Popular
///movie/popular
//GET
//Get Top Rated
///movie/top_rated
//GET
//Get Upcoming
///movie/upcoming

