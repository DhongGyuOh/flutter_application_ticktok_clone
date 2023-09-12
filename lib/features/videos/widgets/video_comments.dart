import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  final ScrollController _scrollController = ScrollController();
  late bool _isWriting = false;
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _onstopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      //클립 높이를 수정하려면 showModalBottomSheet 에서 isScrollControlled: true 로 주면됨
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size10)),
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            bottomOpacity: 0,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: _onClosePressed,
                  icon: const FaIcon(FontAwesomeIcons.x)),
            ],
            title: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "22796 Comments",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ],
            )),
        body: GestureDetector(
          onTap: _onstopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                      top: 10, right: 10, left: 10, bottom: 80),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          child: Text("Gyu"),
                        ),
                        Gaps.h11,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("funtwo"),
                            Gaps.v2,
                            Text(
                                "I believe that your continued efforts will undoubtedly lead to even greater achievements in the future."),
                          ],
                        )),
                        Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size28,
                              color: Colors.black54,
                            ),
                            Gaps.v5,
                            Text(
                              "52.2K",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.v20,
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                //MediaQuery: 사용자 단말기 정보 이용하기 (JavaScript 에서랑 비슷한 개념)
                child: BottomAppBar(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.grey.shade500,
                        child: const Text(
                          "Dong",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Gaps.h10,
                      Expanded(
                          child: SizedBox(
                        height: 40,
                        child: TextField(
                          onTap: _onStartWriting,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                              hintText: "Write a comment...",
                              hintStyle: const TextStyle(fontSize: 15),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.at),
                                    Gaps.h10,
                                    const FaIcon(FontAwesomeIcons.gift),
                                    Gaps.h10,
                                    const FaIcon(FontAwesomeIcons.faceSmile),
                                    Gaps.h10,
                                    if (_isWriting)
                                      GestureDetector(
                                        onTap: _onstopWriting,
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowUp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                  ],
                                ),
                              )),
                        ),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
