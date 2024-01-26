//firebase-functions: Firebase Cloud Functions를 사용하기 위한 모듈입니다.
import * as functions from "firebase-functions";
//firebase-admin: Firebase 관리 기능을 사용하기 위한 모듈입니다.
import * as admin from "firebase-admin";

admin.initializeApp();

export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  //onCreate 이벤트 리스너는 두 개의 매개변수를 받습니다.
  //snapshot: 이벤트가 발생한 문서에 대한 스냅샷입니다.
  //context: 함수의 실행 컨텍스트에 대한 정보를 포함하는 객체입니다.
  .onCreate(async (snapshot, context) => {
    //spawn으로 npm 명령어 실행
    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    //ffmpeg에 파라미터를 전달함
    await spawn("ffmpeg", [
      "-i",
      video.fileUrl, //업로드 하는 영상을 가져옴
      "-ss",
      "00:00:01.000", //영상의 1초 뒤로 이동
      "-vframes",
      "1", //1프레임을 가져옴
      "-vf", // 화질을 낮춤
      "scale=150:-1", //가로 150 세로 -1(-1: 세로비율 알아서 맞춤)
      `/tmp/${snapshot.id}.jpg`, //이미지를 처리하고 이 경로로 저장함
    ]);
    //admin으로 스토리지에 접근하여 ffmpeg에서 작업된 이미지를 스토리지에 저장함
    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });
    //file을 공개화시킴
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });
    //admin으로 firesotre 접근
    const db = admin.firestore();
    //users 컬랙션 안에 videos 컬랙션, document 추가하기
    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
      });
  });

//좋아요 했을 때 likes Collection에서 해당 likeId를 추가생성하고
//videos collection에서 videos like(필드) 값을 증가시키는 메서드
export const onLikedCreated = functions.firestore
  .document("likes/{likeId}")
  .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    //split으로 "000"을 구분자로 사용하여 videoId, userId를 받아옴
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(1), //기존 likes의 값을 +1 증가시켜줌
      });
    const video = await (
      await db.collection("videos").doc(videoId).get()
    ).data();
    if (video == null) return;
    const creatorUid = video.creatorUid;
    const user = await (
      await db.collection("users").doc(creatorUid).get()
    ).data();
    if (user) {
      const token = user.token;
      admin.messaging().send({
        token: token,
        data: { screen: "123" },
        notification: {
          title: "someone liked your video.",
          body: "Likes💕 + 1",
        },
      });
    }
  });

//좋아요 취소했을 때 like Collection에서 해당 likeId를 삭제하고
//videos collection에서 videos like(필드) 값을 감소시키는 메서드
export const onLikedRemoved = functions.firestore
  .document("likes/{likeId}")
  .onDelete(async (snapshot, context) => {
    const db = admin.firestore();
    //split으로 "000"을 구분자로 사용하여 videoId, userId를 받아옴
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(-1), //기존 likes의 값을 -1 시켜줌
      });
  });
