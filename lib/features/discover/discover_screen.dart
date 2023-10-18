import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late final TabController _tabController;
  final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

  void _onChangeTab() {
    _onBodyTap();
  }

  @override
  void initState() {
    _textEditingController.addListener(() {});
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_onChangeTab);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sizewidth = MediaQuery.of(context).size.width;
    print(sizewidth);
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: _onBodyTap,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            title: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: CupertinoSearchTextField(
                controller: _textEditingController,
                prefixIcon: const FaIcon(FontAwesomeIcons.searchengin),
                suffixIcon: const Icon(FontAwesomeIcons.solidCircleXmark),
                onChanged: _onSearchChanged,
                onSubmitted: _onSearchSubmitted,
              ),
            ),
            bottom: TabBar(
                controller: _tabController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                unselectedLabelColor: Colors.grey,
                splashFactory: NoSplash.splashFactory,
                indicatorColor: Colors.black,
                labelColor: Theme.of(context).primaryColor,
                isScrollable: true,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                tabs: [
                  for (var tab in tabs)
                    Tab(
                      text: tab,
                    )
                ]),
          ),
          body: TabBarView(controller: _tabController, children: [
            GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: sizewidth > 900 ? 5 : 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 9 / 20),
                itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.hardEdge,
                          child: AspectRatio(
                            aspectRatio: 10 / 16,
                            //Image.asset("assets/images/img_guitar.png")),
                            child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: "assets/images/img_guitar.png",
                                //placeholder: 로딩동안 가져올 이미지
                                //image: 보여줄 이미지
                                image: "https://source.unsplash.com/random/"),
                          ),
                        ),
                        Gaps.v10,
                        const Text(
                          "This is a very long Caption for Screen. #So #HowTo #Short #String",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Gaps.v5,
                        Expanded(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            child: LayoutBuilder(
                              builder: (context, constraints) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (constraints.maxWidth > 200)
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://img1.daumcdn.net/thumb/C100x100/?scode=mtistory2&fname=https%3A%2F%2Ftistory1.daumcdn.net%2Ftistory%2F4506296%2Fattach%2F27003a1355e84452a5cc9d2dc88c59ca"),
                                      radius: 18,
                                    ),
                                  Gaps.h6,
                                  const Text(
                                    "DongGyu",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Gaps.h10,
                                  FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Gaps.h3,
                                  const Text("2.5M")
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
