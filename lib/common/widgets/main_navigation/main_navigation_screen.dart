import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/discover/discover_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/views/inbox_screen.dart';
import 'package:flutter_application_ticktok_clone/features/users/user_profile_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/video_timeline_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'nav_tab.dart';
import 'post_video_button.dart';
import 'package:flutter_application_ticktok_clone/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, required this.tab});
  static String routeName = "mainNavigation";
  final String tab;
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tab = ["home", "discover", "upload", "inbox", "profile"];
  late int _selectedIndex = _tab.indexOf(widget.tab);

  final _isDarkMode = isDarkMode;

  void _onTapNavButton(int index) {
    context.go("/${_tab[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //키보드 입력창이 나와도 화면이 resize 되지않음
        body: Stack(children: [
          Offstage(
              offstage: _selectedIndex != 0,
              child: const VideoTimelineScreen()),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          )
        ]),
        bottomNavigationBar: BottomAppBar(
          color: (_selectedIndex == 0) || _isDarkMode(context)
              ? Colors.black
              : Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavTap(
                selectedIndex: _selectedIndex,
                title: 'Home',
                icon: FontAwesomeIcons.houseMedical,
                selectedIcon: FontAwesomeIcons.houseMedicalCircleCheck,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTapNavButton(0),
              ),
              NavTap(
                selectedIndex: _selectedIndex,
                title: 'Discover',
                icon: FontAwesomeIcons.searchengin,
                selectedIcon: FontAwesomeIcons.ccDiscover,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTapNavButton(1),
              ),
              Gaps.h24,
              GestureDetector(
                  onTap: () => {
                        _onPostVideoButtonTap(),
                        //_onTapNavButton(2),
                      },
                  child: PostVideoButton(
                    selectedIndex: _selectedIndex,
                    isSelected: _selectedIndex == 2,
                  )),
              Gaps.h24,
              NavTap(
                selectedIndex: _selectedIndex,
                title: 'Inbox',
                icon: FontAwesomeIcons.inbox,
                selectedIcon: FontAwesomeIcons.boxArchive,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTapNavButton(3),
              ),
              NavTap(
                selectedIndex: _selectedIndex,
                title: 'Profile',
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.userCheck,
                isSelected: _selectedIndex == 4,
                onTap: () => _onTapNavButton(4),
              )
            ],
          ),
        ));
  }

  NavigationBar destinationNavBar() {
    return NavigationBar(
        onDestinationSelected: _onTapNavButton,
        selectedIndex: _selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.houseMedical,
                color: Colors.green,
              ),
              label: "Home",
              selectedIcon: FaIcon(FontAwesomeIcons.houseMedicalCircleCheck)),
          NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.video),
              selectedIcon: FaIcon(FontAwesomeIcons.squareViadeo),
              label: "Video"),
          NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.searchengin),
              selectedIcon: FaIcon(FontAwesomeIcons.squareViadeo),
              label: "Search"),
          NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.users),
              selectedIcon: FaIcon(FontAwesomeIcons.squareViadeo),
              label: "Friend"),
        ]);
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (value) => _onTapNavButton(value),
        currentIndex: _selectedIndex,
        //selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseChimney),
              label: "Home",
              tooltip: "This is Home Screen",
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.video),
              label: "Video",
              tooltip: "Funny Video",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.searchengin),
              label: "Search",
              tooltip: "Search",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: "Friend",
              tooltip: "Friend",
              backgroundColor: Colors.deepPurple),
        ]);
  }
}
