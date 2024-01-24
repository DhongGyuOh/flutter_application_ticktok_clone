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

  Future<void> deleteMovieField(String movieCode) async {
    await _firestore.doc(movieCode).update({"movieName": FieldValue.delete()});
  }

  //트렌젝션으로 데이터 처리하기
  Future<void> tranUpdateMovie() async {
    final firstMovie = _firestore.collection("movies").doc("firstMovie");
    _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(firstMovie);
      final score = snapshot.get("score") + 1;
      transaction.update(firstMovie, {"score": score});
    }).then((value) => print("성공적으로 업데이트 되었습니다."),
        onError: (e) => print("에러발생"));
  }

  //batch로 set, update, delete 작업 조합 사용하기
  Future<void> batchMovie() async {
    final batch = _firestore.batch();

    //movies 컬랙션의 favoritMovie 다큐먼트
    final docMovie = _firestore.collection("movies").doc("favoriteMovie");
    batch.set(
        docMovie, {"movieCode": "168863"}); // movieCode 필드에 "168863" set()함
    batch.set(
        docMovie, {"movieName": "GET OUT"}); // movieName 필드에 "GET OUT" set()함
    batch
        .update(docMovie, {"score": "2130000"}); // score 필드에 2130000으로 update()
    batch.delete(docMovie); //삭제

    //batch를 커밋하여 한번에 처리함
    batch.commit();
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
