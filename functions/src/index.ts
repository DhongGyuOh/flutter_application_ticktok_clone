//firebase-functions: Firebase Cloud Functions를 사용하기 위한 모듈입니다.
import * as functions from "firebase-functions";
//firebase-admin: Firebase 관리 기능을 사용하기 위한 모듈입니다.
import * as admin from "firebase-admin";

admin.initializeApp();

//Firebase Cloud Functions를 정의합니다.
//onVideoCreated 함수는 Firestore 데이터베이스의 "videos" 컬렉션에서 새로운 문서가 생성될 때 실행됩니다.
//이 함수는 onCreate 이벤트 리스너로 등록되어 있습니다.
//onCreate 이벤트 리스너는 두 개의 매개변수를 받습니다:
export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    snapshot.ref.update({ hello: "from fuctions" });
  });

//snapshot: 이벤트가 발생한 문서에 대한 스냅샷입니다.
//context: 함수의 실행 컨텍스트에 대한 정보를 포함하는 객체입니다.
//함수는 snapshot.ref.update({ hello: "from functions" }); 라인을 사용하여
//새로운 문서의 "hello" 필드를 "from functions"로 업데이트합니다.

//이 코드는 Firestore "videos" 컬렉션에 새로운 문서가 생성될 때마다
//"hello" 필드를 "from functions"로 업데이트하는 Firebase Cloud Function입니다.
