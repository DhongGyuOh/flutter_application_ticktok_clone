import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget.dart';
import 'package:flutter_application_ticktok_clone/features/settings/settings_screen.dart';
import 'package:flutter_application_ticktok_clone/features/users/view_models/users_view_model.dart';
import 'package:flutter_application_ticktok_clone/features/users/widgets/avatar.dart';
import 'package:flutter_application_ticktok_clone/features/users/widgets/persistent_tabbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "/userprofile";
  const UserProfileScreen({
    super.key,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
      data: (data) {
        return SafeArea(
          child: DefaultTabController(
            animationDuration: const Duration(milliseconds: 100),
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    centerTitle: true,
                    title: Text(
                      data.name,
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TestScreen(),
                                ));
                          },
                          icon: const FaIcon(FontAwesomeIcons.bugs)),
                      IconButton(
                          onPressed: _onGearPressed,
                          icon: const FaIcon(FontAwesomeIcons.gear))
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Avatar(
                          name: data.name,
                          hasAvatar: data.hasAvatar,
                          uid: data.uid,
                        ),
                        Gaps.v10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("@${data.name}"),
                            Gaps.h3,
                            const FaIcon(
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
                            height: 60,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Gaps.v5,
                        const Text(
                            '64 Telecaster, Jazz Standard Bass, SLG200N'),
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
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: PersistentTabbar(),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 12,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 200,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                childAspectRatio: 9 / 16,
                                crossAxisCount: 3),
                        itemBuilder: (context, index) => Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  "https://source.unsplash.com/random",
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                    bottom: 5,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.play_arrow_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "1.5K",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ))
                              ],
                            )),
                    const Center(child: Text('data'))
                  ]),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      ),
      Gaps.v2,
      Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
    ]);
  }
}
