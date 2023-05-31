import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cinespace/classesmovie/popular.dart';
import 'package:cinespace/classesmovie/series.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List popularmovies = [];
  List bestseries = [];
  final String apikey = '1d9a3b2956d60bfebc1a8a6420c20bb0';
  final acesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDlhM2IyOTU2ZDYwYmZlYmMxYThhNjQyMGMyMGJiMCIsInN1YiI6IjY0NzVlNWQ3MWJmMjY2MDQ0MDI2ZmRmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.589H_oZUbS9UC0Rh7Uff60CrbeDBQCwEhPzcqfPeivM';

    @override
    void initState(){
      carregarmovies();
      super.initState();
    }

  void carregarmovies() async {
    TMDB carregartmdb = TMDB(ApiKeys(apikey, acesstoken),
      logConfig: ConfigLogger(
      showLogs: true, 
      showErrorLogs: true
      )
    );
    Map popular_results = await carregartmdb.v3.trending.getTrending();
    Map bestseries_results = await carregartmdb.v3.tv.getTopRated();

    setState(() {
      popularmovies = popular_results['results'];
      bestseries = bestseries_results['results'];
    });
    print(carregartmdb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CineSpace'),
        ),
        body: ListView(
          children: [
            BestSeries(tvbest: bestseries),
            PopularMovie(popular: popularmovies)
          ],
        )
        
    );
  }
}
