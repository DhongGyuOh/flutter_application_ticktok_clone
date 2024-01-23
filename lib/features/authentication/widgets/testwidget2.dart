import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestScreen2 extends ConsumerStatefulWidget {
  const TestScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreen2State();
}

class _TestScreen2State extends ConsumerState<TestScreen2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class Movie {
  String movieCode;
  String movieName;
  int score;

  Movie({
    required this.movieCode,
    required this.movieName,
    required this.score,
  });

  //Json 데이터 -> Movie로 변환
  Movie.fromJson({required Map<String, dynamic> json})
      : movieCode = json["movieCode"],
        movieName = json["movieName"],
        score = json["score"];

  //Movie -> Json 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      "movieCode": movieCode,
      "movieName": movieName,
      "score": score,
    };
  }
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

class MovieRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //삽입(document명 자동 생성)
  Future<void> insertMovie(Movie movie) async {
    final movieToJson = movie.toJson();
    await _firestore.collection("movies").add(movieToJson);
  }

  //삽입(document명 지정 생성)
  Future<void> insertMovieCustom(Movie movie) async {
    final movieToJson = movie.toJson();
    await _firestore.collection("movies").doc("firstMovie").set(movieToJson);
  }

  //업데이트
  Future<void> updateMovie(Movie movie) async {
    final movieToJson = movie.toJson();
    await _firestore
        .collection("movies")
        .doc(movie.movieCode)
        .update(movieToJson);
  }

//해당 movieCode의 score 수정하기
  Future<void> updateMovieScore(Movie movie, int score) async {
    await _firestore
        .collection("movies")
        .doc(movie.movieCode)
        .update({"score": score});
  }

  //삽입 또는 업데이트
  Future<void> setMovie(Movie movie) async {
    final movieToJson = movie.toJson();
    await _firestore.collection("movies").doc(movie.movieCode).set(movieToJson);
  }

  //조회
  Future<Map<String, dynamic>?> getMovie(String movieCode) async {
    final movie = await _firestore.collection("movies").doc(movieCode).get();
    return movie.data();
  }

  //전체 조회
  Future<List<Movie>> getAllmovie() async {
    final querySnapshot = await _firestore.collection("movie").get();
    return querySnapshot.docs
        .map((movie) => Movie.fromJson(json: movie.data()))
        .toList();
  }

  //조회(실시간 Real Time)
  Future<Map<String, dynamic>?> getMovieStream(String movieCode) async {
    final movie = _firestore.collection("movies").doc(movieCode).snapshots();
    await for (DocumentSnapshot snapshot in movie) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      return data ?? {};
    }
    return null;
  }

//특정 조건 조회 및 정렬하기
  Future<QuerySnapshot<Map<String, dynamic>>> getMoviePopular() async {
    final movie = _firestore
        .collection("movies")
        .where("score", isGreaterThan: 10000000) //1000만이 넘을 것
        .where("movieCode", isNull: false) //movieCode가 null이 아닌 것
        .where("movieName", isNull: false) //movidName이 null이 아닌 것
        .orderBy("movieCode", descending: true) //내림차순으로 정렬
        .get();
    return movie;
  }

  //삭제
  Future<void> deleteMovie(String movieCode) async {
    await _firestore.collection("movies").doc(movieCode).delete();
  }
}

final _movieRepoProvider = Provider((ref) => MovieRepository());

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

class FirestoreViewModel extends AsyncNotifier<void> {
  late final MovieRepository _movieRepo;

  @override
  FutureOr<void> build() {
    _movieRepo = ref.read(_movieRepoProvider);
  }
}
