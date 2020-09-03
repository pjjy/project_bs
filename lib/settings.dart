import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  Color color = const Color(0xff0084ff);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Ionicons.md_arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Settings",
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontStyle: FontStyle.normal,
              fontSize: 22.0),
        ),
      ),
      body: SettingsList(
         backgroundColor: Colors.transparent,
        sections: [
          SettingsSection(
            title: 'Common',titleTextStyle:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: color),
            // titleTextStyle: TextStyle(fontSize: 30),
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
//                                    onTap: () {
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (BuildContext context) => LanguagesScreen()));
//                                    },
              ),
              SettingsTile(
                title: 'Environment',
                subtitle: 'Production',
                leading: Icon(Icons.cloud_queue),
                onTap: () => print('e'),
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',titleTextStyle:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: color),
            tiles: [
              SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
              SettingsTile(title: 'Email', leading: Icon(Icons.email)),
              SettingsTile(title: 'Sign out', leading: Icon(Icons.exit_to_app)),
            ],
          ),
          SettingsSection(
            title: 'Security',titleTextStyle:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: color),
            tiles: [
//                                  SettingsTile.switchTile(
//                                    title: 'Lock app in background',
//                                    leading: Icon(Icons.phonelink_lock),
//                                    switchValue: lockInBackground,
//                                    onToggle: (bool value) {
//                                      setState(() {
//                                        lockInBackground = value;
//                                        notificationsEnabled = value;
//                                      });
//                                    },
//                                  ),
              SettingsTile.switchTile(
                  title: 'Use fingerprint',
                  leading: Icon(Icons.fingerprint),
                  onToggle: (bool value) {},
                  switchValue: false),
              SettingsTile.switchTile(
                title: 'Change password',
                leading: Icon(Icons.lock),
                switchValue: true,
                onToggle: (bool value) {},
              ),
//                                  SettingsTile.switchTile(
//                                    title: 'Enable Notifications',
//                                    enabled: notificationsEnabled,
//                                    leading: Icon(Icons.notifications_active),
//                                    switchValue: true,
//                                    onToggle: (value) {},
//                                  ),
            ],
          ),
          SettingsSection(
            title: 'Misc',titleTextStyle:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: color),
            tiles: [
              SettingsTile(
                  title: 'Terms of Service', leading: Icon(Icons.description)),
              SettingsTile(
                  title: 'Open source licenses',
                  leading: Icon(Icons.collections_bookmark)),
            ],
          ),
//          CustomSection(
//            child: Column(
//              children: [
//                Padding(
//                  padding: const EdgeInsets.only(top: 22, bottom: 8),
//                  child: Image.asset(
//                    'assets/settings.png',
//                    height: 10,
//                    width: 50,
//                    color: Color(0xFF777777),
//                  ),
//                ),
////                Text(
////                  'Version: 2.4.0 (287)',
////                  style: TextStyle(color: Color(0xFF777777)),
////                ),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }
}