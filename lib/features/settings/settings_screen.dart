import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends ConsumerWidget {
  static String routeName = "/settings";
  const SettingsScreen({super.key});

  // bool _notifications = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Setting",
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) =>
                {ref.read(playbackConfigProvider.notifier).setMuted(value)},
            title: const Text("Auto Muted"),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) =>
                {ref.read(playbackConfigProvider.notifier).setAutoplay(value)},
            title: const Text("Auto Play"),
          ),
          CheckboxListTile(
            value: false,
            onChanged: (value) => {},
            title: const Text("CheckboxListTile"),
          ),
          ListTile(
            title: const Text("What is your Birthday"),
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1945),
                lastDate: DateTime(2024),
              );

              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              final dateRange = showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (context, child) {
                  return Theme(
                      data: ThemeData(
                          appBarTheme:
                              const AppBarTheme(backgroundColor: Colors.black)),
                      child: child!);
                },
              );
            },
          ),
          ListTile(
            title: const Text(
              "About",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text("About this App"),
            onTap: () => showAboutDialog(
                context: context,
                applicationVersion: "1.0",
                applicationLegalese: "All rights By mroh1226"),
          ),
          ListTile(
            title: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text('Please don\'t go'),
                  actions: [
                    CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No')),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Yes'),
                    )
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Exit'),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.circleExclamation),
                  title: const Text("Are you sure?"),
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.run_circle)),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ))
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("CupertinoActionSheetAction"),
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text("Are you sure?"),
                message: const Text('Please...'),
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () {}, child: const Text('No')),
                  CupertinoActionSheetAction(
                      onPressed: () {}, child: const Text('Yes')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
