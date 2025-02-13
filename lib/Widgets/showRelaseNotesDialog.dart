import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';

Future<void> showReleaseNotesDialog(
  BuildContext context,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // Positioned(child: Image.asset("name")),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              "assets/images/launch_logo.png",
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Release Notes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Version : 2.2",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              """- Bug fixes and performance improvements\n- New Intro Screen to Guide new Users\n- Added Splash Screen\n- UI Enhancements""",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            if (false)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "A new version is available. Please update the app.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (false)
                        TextButton(
                          onPressed: () async {
                            final url = Uri.parse(
                                "https://play.google.com/store/apps/details?id=your.package.name");
                            if (await canLaunchUrl(url)) {
                              launchUrl(url);
                            }
                          },
                          child: Text(
                            "UPDATE",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> checkForUpdate() async {
  AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

  if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
    
    print("Update Available: Version ${updateInfo.availableVersionCode}");
  } else {
    print("No update available.");
  }
}

Future<void> startFlexibleUpdate() async {
  AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

  if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
    await InAppUpdate.startFlexibleUpdate();

    await InAppUpdate.completeFlexibleUpdate();
  }
}

Future<String> getLatestVersionFromPlayStore() async {
  final url =
      "https://play.google.com/store/apps/details?id=com.hr.blusky&hl=en";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final regExp = RegExp(r'"softwareVersion":"([\d.]+)"');
    final match = regExp.firstMatch(response.body);
    if (match != null) {
      print(match.group(1));
      return match.group(1) ?? "0.0.0";
    }
  }
  return "0.0.0";
}

void checkAndShowRN(BuildContext context, String grp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasShownRN = prefs.getBool('hasShownRN') ?? false;

  if (!hasShownRN) {
    await showReleaseNotesDialog(context);
    if(grp != ''){
    Intro.of(context).start(group: grp);
    }
    else{
    Intro.of(context).start();

    }
    await prefs.setBool("hasShownRN", true);
  }
}
