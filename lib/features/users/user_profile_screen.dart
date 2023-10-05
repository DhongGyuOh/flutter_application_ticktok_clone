import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.teal,
          floating: true, //당기면 같이 스크롤됨
          stretch: true, //당기기 가능여부: true
          pinned: true, //위에 작아진 채로 고정됨
          snap: true, //스크롤하면 AppBar가 stretch된 상태로 한번에 나타나거나 사라짐
          collapsedHeight: 60, //AppBar 크기
          expandedHeight: 200, //확장된 AppBar 크기
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground, //당기면 블러처리됨
              StretchMode.zoomBackground, //당기면 Zoom됨
            ],
            centerTitle: true,
            title: const Text('Profile'),
            background: Image.asset(
              "assets/images/img_guitar.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          //List가 아닌 일반적인 위젯을 Sliver에 추가할때 사용
          child: Container(
            height: 50,
            alignment: Alignment.center,
            color: Colors.amber,
            child: const Text('CustomScrollView에 위젯 추가'),
          ),
        ),
        SliverFixedExtentList(
            //CustomScrollView 안에 List를 만드는 위젯
            delegate: SliverChildBuilderDelegate(
                //List안에 들어갈 위젯 작성
                childCount: 8, //자식 갯수: 10
                (context, index) => Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text("index: $index"),
                    )),
            itemExtent: 100), //item의 높이: 100
        SliverPersistentHeader(
            //이 위젯으로 Header를 추가할 수 있음
            pinned: true, // pinned를 해줘야 header가 안사라지고 고정됨
            delegate: CustomDelegate()),
        SliverGrid(
            //List 안에 Grid를 만드는 위젯
            delegate: SliverChildBuilderDelegate(
                childCount: 36,
                (context, index) => Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text("index: $index"),
                    )),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.4))
      ],
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text('data'),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
