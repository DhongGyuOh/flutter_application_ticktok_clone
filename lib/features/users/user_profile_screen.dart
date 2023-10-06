import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 100),
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: const Text(
              "Gyu",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.bell)),
              IconButton(
                  onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.gear))
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://yt3.ggpht.com/LOWZ9per6hyhd6swd5KEi_RmgACl6-gpXSUf91zNaY-fPb8jX13syeVo-RKLFqqUxnyqCi4S=s88-c-k-c0x00ffffff-no-rj"),
                ),
                Gaps.v10,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("@mroh1226"),
                    Gaps.h3,
                    FaIcon(
                      FontAwesomeIcons.certificate,
                      size: 15,
                      color: Colors.blue,
                    )
                  ],
                ),
                Gaps.v20,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextNumber(
                          numbers: "37",
                          title: "Following",
                        ),
                        VerticalDivider(
                            width: 30,
                            thickness: 0.4,
                            color: Colors.grey,
                            endIndent: 14,
                            indent: 14),
                        TextNumber(
                          numbers: "10.5M",
                          title: "Followers",
                        ),
                        VerticalDivider(
                            width: 30,
                            thickness: 0.4,
                            color: Colors.grey,
                            endIndent: 14,
                            indent: 14),
                        TextNumber(
                          numbers: "149K",
                          title: "Like",
                        )
                      ],
                    ),
                  ),
                ),
                Gaps.v20,
                FractionallySizedBox(
                  widthFactor: 0.33,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Gaps.v5,
                const Text('64 Telecaster, Jazz Standard Bass, SLG200N'),
                Gaps.v5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.link,
                      size: 15,
                      color: Colors.blue.shade400,
                    ),
                    const Text(' www.youtube.com'),
                  ],
                ),
                Gaps.v10,
                Container(
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 0.8, color: Colors.grey))),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Theme.of(context).primaryColor,
                      labelPadding: const EdgeInsets.all(10),
                      labelColor: Colors.black,
                      tabs: const [
                        Icon(Icons.grid_4x4),
                        FaIcon(FontAwesomeIcons.heart)
                      ]),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                          itemCount: 10,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 300,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 0.2,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) => Container(
                            child: Container(
                                alignment: Alignment.center,
                                color: Colors.deepOrangeAccent.shade100,
                                child: Text('$index')),
                          ),
                        ),
                        const Center(child: Text('data'))
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextNumber extends StatelessWidget {
  const TextNumber({super.key, required this.title, required this.numbers});
  final String title;
  final String numbers;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        numbers,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
      ),
      Gaps.v2,
      Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
    ]);
  }
}
