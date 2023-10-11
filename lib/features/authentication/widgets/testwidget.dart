import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const SliverAppBar(
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      'SliverAppBar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                        ),
                        Text(
                          'Avatar',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                      pinned: true, delegate: SliverDelegate())
                ];
              },
              body: TabBarView(
                children: [
                  GridView.builder(
                    itemCount: 12,
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 9 / 16,
                            crossAxisCount: 3),
                    itemBuilder: (context, index) => Container(
                      alignment: Alignment.center,
                      color: Colors.pink.shade200,
                      child: Text('첫번째 Tab $index'),
                    ),
                  ),
                  GridView.builder(
                    itemCount: 12,
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 9 / 16,
                            crossAxisCount: 3),
                    itemBuilder: (context, index) => Container(
                      alignment: Alignment.center,
                      color: Colors.green.shade300,
                      child: Text('두번째 Tab $index'),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      //Container 안에 decoration을 정해줘야 pinned = true로 해도 오류가 안남
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        labelColor: Colors.black,
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Icon(Icons.favorite_rounded),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
