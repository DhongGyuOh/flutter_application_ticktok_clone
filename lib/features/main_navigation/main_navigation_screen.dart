import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/main_navigation/widgets/stf_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/video_timeline_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main_navigation/widgets/nav_tab.dart';
import '../main_navigation/widgets/post_video_button.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex = 0;
  void _onTapNavButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                shadowColor: Colors.white,
                title: const Text(
                  'Record Video',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
        fullscreenDialog: true));
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
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const StfScreen(),
          )
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavTap(
                title: 'Home',
                icon: FontAwesomeIcons.houseMedical,
                selectedIcon: FontAwesomeIcons.houseMedicalCircleCheck,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTapNavButton(0),
              ),
              NavTap(
                title: 'Discover',
                icon: FontAwesomeIcons.searchengin,
                selectedIcon: FontAwesomeIcons.ccDiscover,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTapNavButton(1),
              ),
              Gaps.h24,
              GestureDetector(
                  onTap: () => {
                        _onPostVideoButtonTap(context),
                        _onTapNavButton(2),
                      },
                  child: PostVideoButton(
                    isSelected: _selectedIndex == 2,
                  )),
              Gaps.h24,
              NavTap(
                title: 'Inbox',
                icon: FontAwesomeIcons.inbox,
                selectedIcon: FontAwesomeIcons.boxArchive,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTapNavButton(3),
              ),
              NavTap(
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
