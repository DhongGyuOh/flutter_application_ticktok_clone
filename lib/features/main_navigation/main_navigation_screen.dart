import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      child: Text('friend'),
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
      bottomNavigationBar: BottomNavigationBar(
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
          ]),
    );
  }
}
