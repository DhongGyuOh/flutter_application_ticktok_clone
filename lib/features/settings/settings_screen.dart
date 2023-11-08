import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/common/widgets/vidio_configuration/video_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "/settings";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;
  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            value: VideoConfigData.of(context).autoMute,
            onChanged: (value) {
              VideoConfigData.of(context).toggleMuted();
            },
            title: const Text('Auto Mute'),
            subtitle: const Text("VideoConfig.of(context).autoMute"),
          ),
          CheckboxListTile(
            value: _notifications,
            onChanged: _onNotificationsChanged,
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
              if (!mounted) return;
              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (!mounted) return;
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
