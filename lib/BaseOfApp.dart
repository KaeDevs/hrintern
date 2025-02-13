import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:ss/Screens/HomePage.dart';
import 'package:ss/Screens/viewAttendance.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';

class Baseofapp extends StatefulWidget {
  final Key? key;
  Baseofapp({this.key});

  @override
  State<Baseofapp> createState() => _BaseofappState();
}

class _BaseofappState extends State<Baseofapp> {
  String currentScreen = "HOME";

  void changeScreen(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  final Map<String, Widget> screens = {
    "VIEWATT": ViewAttendance(),
    // "HOME": Homepage(onNavigate: changeScreen()),
  };
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 1, 0, 71),
        elevation: 5,
        width: MediaQuery.of(context).size.width / 2,
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                // decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "My Drawer",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                
              iconColor: Colors.white,
              textColor: Colors.white,
              
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  
                  Navigator.pop(context);
                },
              ),
              ListTile(
                
              iconColor: Colors.white,
              textColor: Colors.white,
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),]
              ),
      ),
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntroStepBuilder(
              text: "You can access the menu bar here to change setting!",
              order: 2,
              builder: (context, key) => IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                key: key,
                icon: Icon(Icons.menu),
                color: Colors.white,
              ),
            ),
            SelectableText(
              "Mani",
              style: TextStyle(
                fontFamily: "H1",
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down_circle),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                   
                  },
                  icon: Icon(Icons.notifications_active),
                  color: Colors.white,
                ),
                IntroStepBuilder(
                  order: 1,
                  text:
                      "Welcome! You can access your account details through this button",
                  onWidgetLoad: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      checkAndShowRN(context, '' );
                    });
                  },
                  builder: (context, key) => PopupMenuButton(
                                // surfaceTintColor: Colors.white,
                                popUpAnimationStyle: AnimationStyle(curve: Curves.easeInOut, duration: Duration(milliseconds: 300)),
                                icon: const Icon(Icons.account_circle, color: Colors.white,),
                                color: Colors.white,
                                key: key,
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem(
                                    // value: menuitems.about,
                                    value: 1,
                                    child: Text("About"),
                                  ),
                                  const PopupMenuItem(
                                    // value: menuitems.share,
                                    value: 2,
                                    child: Text("Share"),
                                  ),
                                  const PopupMenuItem(
                                    // value: menuitems.exit,
                                    value: 3,
                                    child: Text("Exit"),
                                  ),
                                ],
                                onSelected: (value) {
                                  switch (value) {
                                    case 1:
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const AboutPage()));
                                      break;
                                    case 2:
                                      // Share.share(
                                      //     "Checkout this app! https://play.google.com/store/apps/details?id=mhc.file.mhcdb&hl=en_IN",
                                      //     subject: "Look what I found!");
                                      break;
                                    case 3:
                                      SystemNavigator.pop();
                                      break;
                                  }
                                },
                              ),
                ),
              ],
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blueAccent,
                const Color.fromARGB(255, 1, 107, 194)
              ],
            ),
          ),
        ),
      ),
      body: MyNavigator(),
    );
  }
}



class MyNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigatorKey.currentState?.canPop() ?? false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (navigatorKey.currentState?.canPop() == true) {
            navigatorKey.currentState?.pop(); 
          } else {
            
          }
        }
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          Widget page;
          switch (settings.name) {
            case '/':
              page = Homepage();
              break;
            case '/page2':
              page = Intro(
                padding: EdgeInsets.all(12),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                maskColor: const Color.fromRGBO(0, 0, 0, .8),
                child: ViewAttendance(),
              );
              break;
            default:
              page = ViewAttendance();
          }
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}
