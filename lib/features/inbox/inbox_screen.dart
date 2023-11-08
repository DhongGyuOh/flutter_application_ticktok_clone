import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/activity_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/chats_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class InboxScreen extends StatefulWidget {
  static String routeName = "inbox";
  static String routeURL = "/inbox";
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  void _onDMPressed(BuildContext context) {
    context.pushNamed(ChatsScreen.routeName);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const ChatsScreen(),
    //     ));
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ActivityScreen(),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "Inbox",
        ),
        actions: [
          IconButton(
              onPressed: () => _onDMPressed(context),
              icon: const FaIcon(FontAwesomeIcons.paperPlane))
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              'Activity',
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 20,
            ),
            focusColor: Theme.of(context).primaryColor,
          ),
          ListTile(
            title: const Text(
              'New Followers',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            leading: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const FaIcon(
                FontAwesomeIcons.peopleGroup,
                color: Colors.blueAccent,
                size: 32,
              ),
            ),
            subtitle: const Text("Check Your New Friends"),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 20,
            ),
            focusColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
