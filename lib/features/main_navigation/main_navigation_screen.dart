import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Video'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Friend'),
    )
  ];
  late int _selectedIndex = 0;
  void _onTapNavButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [screens[_selectedIndex]],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavTap(
                title: 'Home',
                icon: FontAwesomeIcons.houseMedical,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTapNavButton(0),
              ),
              NavTap(
                title: 'Home',
                icon: FontAwesomeIcons.houseMedical,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTapNavButton(1),
              ),
              NavTap(
                title: 'Home',
                icon: FontAwesomeIcons.houseMedical,
                isSelected: _selectedIndex == 2,
                onTap: () => _onTapNavButton(2),
              ),
              NavTap(
                title: 'Home',
                icon: FontAwesomeIcons.houseMedical,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTapNavButton(3),
              )
            ],
          ),
        ));
  }

  NavigationBar DestinationNavBar() {
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
              icon: FaIcon(FontAwesomeIcons.video), label: "Video"),
          NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.searchengin), label: "Search"),
          NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.users), label: "Friend"),
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
              icon: Icon(FontAwesomeIcons.search),
              label: "Search",
              tooltip: "Search",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userFriends),
              label: "Friend",
              tooltip: "Friend",
              backgroundColor: Colors.deepPurple),
        ]);
  }
}
