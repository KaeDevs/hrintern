import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:ss/Screens/viewAttendanceDesk.dart';
import 'package:ss/Tools/dottedCurve.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';
import 'dart:html' as html;
import 'dart:js' as js;

class CameraDeskControllerX extends GetxController {
  CameraController? cameraController;
  // late FaceDetector faceDetector;
  List<CameraDescription>? cameras;
  bool isProcessing = false;
  var isFaceInsideCircle = false.obs;
  var selectedCameraIndex = 0.obs;

  // final FaceDetectorOptions options = FaceDetectorOptions(
  //   enableContours: true,
  //   enableLandmarks: true,
  //   enableClassification: true,
  // );

  @override
  void onInit() {
    super.onInit();
    // faceDetector = FaceDetector(options: options);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras == null || cameras!.isEmpty) return;

    cameraController = CameraController(
      cameras![selectedCameraIndex.value],
      ResolutionPreset.high, // Change resolution for better support
      enableAudio: false, // Some cameras may need audio enabled
    );

    await cameraController!.initialize();
    update();

    // Print camera description for debugging
    print(cameraController!.description);

    if (cameraController!.value.isInitialized) {
      // _startFaceDetection();
    }
  }

  void switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    selectedCameraIndex.value = (selectedCameraIndex.value == 0) ? 1 : 0;
    await _initializeCamera();
  }

//   Future<void> _startFaceDetection() async {
//   while (cameraController != null && cameraController!.value.isInitialized) {
//     if (isProcessing) {
//       await Future.delayed(Duration(milliseconds: 500));
//       continue;
//     }

//     isProcessing = true;

//     try {
//       // Capture an image instead of using image stream
//       final XFile imageFile = await cameraController!.takePicture();
//       final InputImage inputImage = InputImage.fromFilePath(imageFile.path);

//       // Perform face detection
//       final List<Face> faces = await faceDetector.processImage(inputImage);
//       isFaceInsideCircle.value = faces.isNotEmpty;
//     } catch (e) {
//       print("Face Detection Error: $e");
//     } finally {
//       isProcessing = false;
//       await Future.delayed(Duration(seconds: 2)); // Adjust delay as needed
//     }
//   }
// }

//   InputImageRotation _getImageRotation(int sensorOrientation) {
//     switch (sensorOrientation) {
//       case 0:
//         return InputImageRotation.rotation0deg;
//       case 90:
//         return InputImageRotation.rotation0deg;
//       case 180:
//         return InputImageRotation.rotation0deg;
//       case 270:
//         return InputImageRotation.rotation0deg;
//       default:
//         return InputImageRotation.rotation0deg;
//     }
//   }

  Future<void> captureImage() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        final XFile image = await cameraController!.takePicture();

        developer.log("Image captured: ${image.path}");
      }
    } catch (e) {
      developer.log("Error capturing image: $e");
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    cameraController?.dispose();
    super.onClose();
  }
}


class CameraScreenDesk extends StatelessWidget {
  CameraScreenDesk({super.key});

  final CameraDeskControllerX controller = Get.put(CameraDeskControllerX());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,

        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntroStepBuilder(
              group: "ca",
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
                    Container(
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
                    // Get.to(() => CameraScreenDesk());
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
                    group: 'ca',
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
                            color: Colors.transparent,
                          ),
                          Positioned.fill(
                            child: CustomPaint(
                              painter: DottedLinePainter(
                                start: Offset(
                                    params.offset!.dx +
                                        params.size.width / 2 -
                                        20,
                                    params.offset!.dy - 35),
                                end: Offset(
                                    MediaQuery.of(context).size.width / 2,
                                    MediaQuery.of(context).size.height * 0.43),
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
                          Container(
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
      body: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              decoration:
                  BoxDecoration(color: const Color.fromARGB(255, 0, 64, 116)),
              child: Container(
                color: const Color.fromARGB(255, 1, 0, 71),
                width: MediaQuery.of(context).size.width / 2,
                child: ListView(padding: EdgeInsets.zero, children: [
                  // DrawerHeader(
                  //   // decoration: BoxDecoration(color: Colors.blue),
                  //   child: Text(
                  //     "My Drawer",
                  //     style: TextStyle(color: Colors.white, fontSize: 24),
                  //   ),
                  // ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: () {
                      Get.toNamed("/viewd");
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.note_add_sharp),
                    title: Text("Release Notes"),
                    onTap: () async {
                      // Navigator.pop(context);
                      await showReleaseNotesDialog(context);
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.no_encryption_gmailerrorred_outlined),
                    title: Text("PlaceHolder"),
                    onTap: () async {
                      // Navigator.pop(context);
                      Intro.of(context).start(reset: true);
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.tungsten_outlined),
                    title: Text("Tutoral"),
                    onTap: () async {
                      // Navigator.pop(context);
                      print("clickedddd");

                      Intro.of(context).start(reset: true);
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                ]),
              ), // Pass context here
            ),
          ),
          Flexible(flex: 4, fit: FlexFit.tight, child: CameraContentDesk())
        ],
      ),
    );
  }
}

class CameraContentDesk extends StatelessWidget {
  const CameraContentDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraDeskControllerX>(
      builder: (controller) {
        if (controller.cameraController == null ||
            !controller.cameraController!.value.isInitialized) {
          // Properly sized progress indicator
          return Container(
            color: Colors.black,
            child: Center(
              child: SizedBox(
                width: 50, // Set a proper size for the loading indicator
                height: 50,
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              ),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxHeight = constraints.maxHeight;
                      final maxWidth = constraints.maxWidth;
                      final aspectRatio =
                          controller.cameraController!.value.aspectRatio;

                      double previewWidth, previewHeight;

                      if (maxWidth / aspectRatio <= maxHeight) {
                        previewWidth = maxWidth;
                        previewHeight = maxWidth / aspectRatio;
                      } else {
                        previewHeight = maxHeight;
                        previewWidth = maxHeight * aspectRatio;
                      }

                      return SizedBox(
                        width: previewWidth,
                        height: previewHeight,
                        child: AspectRatio(
                          aspectRatio: aspectRatio,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(
                              // Flip horizontally for both cameras if needed
                             0, // π radians = 180 degrees (horizontal flip)
                            ),
                            child: Transform.rotate(
                              angle: controller.cameraController!.description
                                          .lensDirection ==
                                      CameraLensDirection.back
                                  // ? 90 * 3.1415926535 / 180
                                  ? 0
                                  : 0,
                              child: Transform.scale(
                                scale: 1.063, // Adjust scaling if needed
                                child:
                                    CameraPreview(controller.cameraController!),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Top Bar
                Container(
                  color: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      const Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                // Face Outline Shape
                Center(
                  child: Obx(() => CustomPaint(
                        painter: FaceOutlinePainter(controller.isFaceInsideCircle.value),
                        child: const SizedBox(
                          width: 200,
                          height: 200,
                        ),
                      )),
                ),

                // Face Placement Instruction
                Obx(() {
                  if (!controller.isFaceInsideCircle.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 200),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            color: Colors.black54,
                            child: const Text(
                              "Place your face inside the Shape",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // Bottom Controls
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: Get.width,
                    height: 110,
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.switch_camera,
                              color: Colors.white, size: 40),
                          onPressed: controller.switchCamera,
                        ),
                        GestureDetector(
                          onTap: controller.captureImage,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  final bool isFaceInside;
  FaceOutlinePainter(this.isFaceInside);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isFaceInside ? Colors.green : Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    final Path path = Path();
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double scaleFactor = 1.5;
    double width = size.width * 0.7 * scaleFactor;
    double height = size.height * 0.9 * scaleFactor;

    path.moveTo(centerX, centerY + height * 0.5);
    path.quadraticBezierTo(centerX + width * 0.5, centerY + height * 0.3,
        centerX + width * 0.4, centerY - height * 0.3);
    path.quadraticBezierTo(centerX + width * 0.3, centerY - height * 0.5,
        centerX, centerY - height * 0.5);
    path.quadraticBezierTo(centerX - width * 0.3, centerY - height * 0.5,
        centerX - width * 0.4, centerY - height * 0.3);
    path.quadraticBezierTo(centerX - width * 0.5, centerY + height * 0.3,
        centerX, centerY + height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) {
    return oldDelegate.isFaceInside != isFaceInside;
  }
}
