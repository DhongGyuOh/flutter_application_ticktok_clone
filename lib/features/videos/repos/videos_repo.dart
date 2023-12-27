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
        "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    //uid폴더를 만들고 거기에 만들어진 날짜를 파일명으로 함
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJason());
  }
}

final videosRepo = Provider((ref) => VideosRepository());
