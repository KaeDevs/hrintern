import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:ss/Screens/HomePage.dart';
import 'package:ss/Screens/viewAttendance.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';

class Baseofapp extends StatefulWidget {
  const Baseofapp({super.key});

  @override
  State<Baseofapp> createState() => _BaseofappState();
}

class _BaseofappState extends State<Baseofapp> {
  // _BaseofappState({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> screens = {
      "VIEWATT": ViewAttendance(),
      "HOME": Homepage()
    };

    return Scaffold(
      // appBar: AppBar(title: Text("Hello")),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  color: const Color.fromARGB(255, 81, 140, 250),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IntroStepBuilder(
                        text:
                            "You can access the menu bar here to change setting!",
                        order: 2,
                        builder: (context, key) => IconButton(
                          onPressed: () {},
                          key: key,
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Mani",
                        style: TextStyle(
                            fontFamily: "H1",
                            fontSize: 30,
                            color: Colors.white),
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
                              // showReleaseNotesDialog(context);
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
                                checkAndShowRN(
                                  context,
                                );
                                // Intro.of(context).start();
                              });
                            },
                            builder: (context, key) => IconButton(
                              onPressed: () {},
                              key: key,
                              icon: Icon(Icons.account_circle),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Flexible(
              flex: 9,
              child: screens["HOME"]!,
            ),
          ],
        ),
      ),
    );
  }
}

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Hello")),
//       body: Center(
//         child: IntroStepBuilder(
//           order: 1,
//           text: "This displays HELLO WORLD Text",
//           onWidgetLoad: (){
//             Intro.of(context).start();
//           },
//           builder: (context, key) =>  Text(
//             key: key,
//             "Home page",
//             textScaleFactor: 2,
//           ),
//         ),
//       ),
//     );
//   }
// }
