import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:ss/Screens/cameraScreen.dart';
import 'package:ss/Tools/dottedCurve.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';

class BaseofappMob extends StatelessWidget {
  
  Widget? body;
  BaseofappMob({super.key,  required this.body});

  String currentScreen = "HOME";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        drawer: Drawer(
          
          backgroundColor: const Color.fromARGB(255, 1, 0, 71),
          elevation: 5,
          width: MediaQuery.of(context).size.width / 2,
          child: ListView(padding: EdgeInsets.zero, children: [
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
              leading: Icon(Icons.note_add_sharp),
              title: Text("Release Notes"),
              onTap: () async {
                Navigator.pop(context);
                await showReleaseNotesDialog(context);
              },
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: Icon(Icons.no_encryption_gmailerrorred_outlined),
              title: Text("PlaceHolder"),
              onTap: () async {
                Navigator.pop(context);
                // Intro.of(context).start(reset: true);
              },
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: Icon(Icons.tungsten_outlined),
              title: Text("Tutoral"),
              onTap: () async {
                Navigator.pop(context);
                Intro.of(context).start(reset: true);
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
            ),
          ]),
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
                borderRadius: BorderRadius.circular(30),
                padding: EdgeInsets.zero,
                builder: (context, key) => IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  key: key,
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                ), //Start of edit
                getOverlayPosition: ({
                  required Offset offset,
                  required Size screenSize,
                  required Size size,
                }) {
                  return OverlayPosition(
                    top: size.height + offset.dy,
                    width: screenSize.width,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  );
                },
                overlayBuilder: (params) {
                  return Stack(
                    children: [
                      // Background Color
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent // Semi-transparent overlay
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: DottedLinePainter(
                              start: Offset(
                                  params.offset!.dx + params.size.width / 2 + 20,
                                  params.offset!.dy - 35),
                              end: Offset(MediaQuery.of(context).size.width / 2,
                                  MediaQuery.of(context).size.height * 0.43),
                              // curve: Offset(
                              //     params.offset!.dx +
                              //         params.size.width / 2 +
                              //         20 +
                              //         MediaQuery.of(context).size.width / 2,
                              //     (params.offset!.dy -
                              //                 35 +
                              //                 MediaQuery.of(context).size.height *
                              //                     0.43) /
                              //             2 -
                              //         50)
                                      ),
                        ),
                      ),
                      // Centered Content
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24), // Add padding
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.max, // Shrink to fit content
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.center, // Center horizontally
                              children: [
                                // Text in the center
                                Text(
                                  "You can access the menu bar here to change setting!",
                                  textAlign: TextAlign.center, // Center text
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        20), // Spacing between text and button
      
                                // Next Button (Properly Styled)
                                IntroButton(
                                  fontSize: 17,
                                  text: "Finish",
                                  onPressed:
                                      params.onFinish, // Call function properly
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 0, 0, 0), // Button color
                                    foregroundColor: Colors.teal, // Text color
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded corners
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
      //End of edit
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
                    onPressed: () {
                      Get.toNamed("/camm");
                    },
                    icon: Icon(Icons.search),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_drop_down_circle),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_active),
                    color: Colors.white,
                  ),
                  IntroStepBuilder(
                      order: 1,
                      borderRadius: BorderRadius.circular(30),
                      padding: EdgeInsets.zero,
                      text:
                          "Welcome! You can access your account details through this button",
                      onWidgetLoad: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          checkAndShowRN(context, '');
                        });
                      },
                      builder: (context, key) => PopupMenuButton(
                            // surfaceTintColor: Colors.white,
                            popUpAnimationStyle: AnimationStyle(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 300)),
                            icon: const Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
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
                                  // Navigator.of(context).(
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
                      getOverlayPosition: ({
                        required Offset offset,
                        required Size screenSize,
                        required Size size,
                      }) {
                        return OverlayPosition(
                          top: size.height + offset.dy,
                          width: screenSize.width,
                          crossAxisAlignment: CrossAxisAlignment.end,
                        );
                      },
                      overlayBuilder: (params) {
                        return Stack(
                          children: [
                            // Background Color
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color:
                                  Colors.transparent, 
                            ),
                            Positioned.fill(
                              child: CustomPaint(
                                painter: DottedLinePainter(
                                    start: Offset(
                                        params.offset!.dx +
                                            params.size.width / 2 - 20 ,
                                        params.offset!.dy - 35),
                                    end: Offset(
                                        MediaQuery.of(context).size.width / 2,
                                        MediaQuery.of(context).size.height *
                                            0.43),
                                    // curve: Offset(
                                    //     params.offset!.dx +
                                    //         params.size.width / 2 +
                                    //         20 -
                                    //         MediaQuery.of(context).size.width / 2,
                                    //     (params.offset!.dy -
                                    //                 35 +
                                    //                 MediaQuery.of(context)
                                    //                         .size
                                    //                         .height *
                                    //                     0.43) /
                                    //             2 -
                                    //         50
                                    //         )
                                            ),
                              ),
                            ),
                            // Centered Content
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24), // Add padding
                                  child: Column(
                                    mainAxisSize:
                                        MainAxisSize.max, // Shrink to fit content
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Center horizontally
                                    children: [
                                      // Text in the center
                                      Text(
                                        "Welcome! You can access your account details through this button",
                                        textAlign:
                                            TextAlign.center, // Center text
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              20), // Spacing between text and button
      
                                      // Next Button (Properly Styled)
                                      IntroButton(
                                        fontSize: 17,
                                        text: "Next",
                                        onPressed: params
                                            .onNext, // Call function properly
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 0, 0, 0), // Button color
                                          foregroundColor:
                                              Colors.teal, // Text color
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Rounded corners
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
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
        body: body,
      
    );
  }
}

// class DottedLinePainter extends CustomPainter {
//   final Offset start;
//   final Offset end;

//   DottedLinePainter({required this.start, required this.end});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final Path path = Path()..moveTo(start.dx, start.dy);

//     // Adjust control points for a better loop shape
//     Offset control1 = Offset((start.dx + end.dx) , start.dy +100); // Curve upward
//     Offset control2 = Offset((start.dx + end.dx) / 2, start.dy + 150); // Swing downward to form loop
//     Offset loopMid = Offset((start.dx + end.dx)  /4 , start.dy+100 ); // Midpoint inside loop

//     // Create the loop with cubic Bézier
//     path.cubicTo(control1.dx, control1.dy + 50, control2.dx , control2.dy + 150, loopMid.dx + 50, loopMid.dy + 100);
//     path.cubicTo(loopMid.dx + 150, loopMid.dy -150, end.dx, end.dy, end.dx, end.dy);

//     // Dotted effect
//     final double dashLength = 5, dashSpace = 5;
//     double distance = 0;
//     for (final PathMetric pathMetric in path.computeMetrics()) {
//       final double pathLength = pathMetric.length;
//       while (distance < pathLength) {
//         final double nextDistance = distance + dashLength;
//         canvas.drawLine(
//           pathMetric.getTangentForOffset(distance)!.position,
//           pathMetric.getTangentForOffset(
//                   nextDistance < pathLength ? nextDistance : pathLength)!
//               .position,
//           paint,
//         );
//         distance += dashLength + dashSpace;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
