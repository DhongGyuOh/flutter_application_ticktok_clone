import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_ticktok_clone/features/videos/models/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
        //uid폴더를 만들고 거기에 만들어진 날짜를 파일명으로 함
        "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

//video를 fetch하는 메소드
  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemCreatedAt}) async {
    //videos Collection에서 createdAt Field로 DESC로 정렬된채로 2개의 document만 가져옴
    //QuerySnapshot 을 return함
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      //startAfter[숫자] 입력된 숫자 위치에 있는 data부터 시작 순차조건으로 리스트에 넣으면됨
      return await query.startAfter([lastItemCreatedAt]).get();
    }
  }

  // fetchVideo() {
  //   //videos Collection에서 likes Field가 10이상인 Document를 get하는 함수
  //   return _db.collection("videos").where("likes", isGreaterThan: 10).get();
  // }

  Future<void> likeVideo(String videoId, String userId) async {
    // final check = await _db
    //     .collection("likes")
    //     .where("videoId", isEqualTo: videoId)
    //     .where("userId", isEqualTo: userId).get();
    //if (check.isexists) return;

    //임의의 특정id를 부여함, .get()으로 데이터가 존재하지않으면 .set() 함
    //존재한다면 dislike 해야하기 때문에 .delete()로 삭제함
    final query = _db.collection("likes").doc("${videoId}000$userId");

    final like = await query.get();

    if (!like.exists) {
      await query.set({"createdAt": DateTime.now().millisecondsSinceEpoch});
    } else {
      await query.delete();
    }
  }
}

final videosRepo = Provider((ref) => VideosRepository());
