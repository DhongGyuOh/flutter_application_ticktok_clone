import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget2.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onTap() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    //ImageSource.gallery : 앨범에서 동영상 가져오기
    //ImageSource.camera  : 카메라로 동영상 촬영하기
    if (!mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestScreen2(video: video),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: _onTap,
            icon: const Icon(
              Icons.image,
              size: 43,
            )),
      ),
    );
  }
}
