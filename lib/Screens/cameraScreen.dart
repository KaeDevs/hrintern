import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';


class CameraControllerX extends GetxController {
  CameraController? cameraController;
  late FaceDetector faceDetector;
  List<CameraDescription>? cameras;
  bool isProcessing = false;
  var isFaceInsideCircle = false.obs;
  var selectedCameraIndex = 1.obs; 

  final FaceDetectorOptions options = FaceDetectorOptions(
    enableContours: true,
    enableLandmarks: true,
    enableClassification: true,
  );

  @override
  void onInit() {
    super.onInit();
    faceDetector = FaceDetector(options: options);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras == null || cameras!.isEmpty) return;

    cameraController = CameraController(
      cameras![selectedCameraIndex.value],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await cameraController!.initialize();
    update();

    if (cameraController!.value.isInitialized) {
      _startFaceDetection();
    }
  }

  void switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    selectedCameraIndex.value = (selectedCameraIndex.value == 0) ? 1 : 0;
    await _initializeCamera();
  }

  void _startFaceDetection() {
    cameraController!.startImageStream((CameraImage image) async {
      if (isProcessing) return;
      isProcessing = true;

      try {
        final WriteBuffer buffer = WriteBuffer();
        for (Plane plane in image.planes) {
          buffer.putUint8List(plane.bytes);
        }
        final Uint8List bytes = buffer.done().buffer.asUint8List();

        final InputImage inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: _getImageRotation(
                cameraController!.description.sensorOrientation),
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final List<Face> faces = await faceDetector.processImage(inputImage);

        double circleX = Get.width / 2;
        double circleY = Get.height / 2;
        double circleRadius = 100.0;

        bool faceDetected = false;

        for (Face face in faces) {
          double faceX = face.boundingBox.center.dx;
          double faceY = face.boundingBox.center.dy;

          double distance = ((faceX - circleX) * (faceX - circleX)) +
              ((faceY - circleY) * (faceY - circleY));

          if (distance < circleRadius * circleRadius) {
            faceDetected = true;
            break;
          }
        }

        isFaceInsideCircle.value = faceDetected;
      } catch (e) {
        
        developer.log("Face Detection Error: $e");
      } finally {
        await Future.delayed(Duration(milliseconds: 500));
        isProcessing = false;
      }
    });
  }

  InputImageRotation _getImageRotation(int sensorOrientation) {
    switch (sensorOrientation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

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
    faceDetector.close();
    super.onClose();
  }
}

class CameraScreen extends StatelessWidget {
  CameraScreen({super.key});
  
  final CameraControllerX controller = Get.put(CameraControllerX());

  @override
  Widget build(BuildContext context) {
    return CameraContentMob();
  }
}

class CameraContentMob extends StatelessWidget {
  const CameraContentMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraControllerX>(
      builder: (controller) {
        if (controller.cameraController == null ||
            !controller.cameraController!.value.isInitialized) {
          return Container(
            color: Colors.black,
            child: Center(
                child:
                    CircularProgressIndicator(backgroundColor: Colors.black)),
          );
        }
    
        return SafeArea(
          child: 
            Stack(
              children: [
                
                Center(
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.rotationY(
                      controller.cameraController!.description.lensDirection ==
                              CameraLensDirection.front
                          ? 3.1415926535
                          : 0,
                    ),
                    child: Transform.rotate(
                      angle: (controller.cameraController!.description
                                  .lensDirection ==
                              CameraLensDirection.back)
                          ? 90 * 3.1415926535 / 180
                          : -90 * 3.1415926535 / 180,
                      child: Transform.scale(
                        scale: 1,
                        child: AspectRatio(
                          aspectRatio:
                              controller.cameraController!.value.aspectRatio,
                          child: CameraPreview(controller.cameraController!),
                        ),
                      ),
                    ),
                  ),
                ),
    
                
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      Spacer(),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
    
                
                Center(
                  child: Obx(() => CustomPaint(
                        painter: FaceOutlinePainter(
                            controller.isFaceInsideCircle.value),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                        ),
                      )),
                ),
    
                
                Obx(() {
                  if (!controller.isFaceInsideCircle.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 200),
                          Text(
                            "Place your face inside the Shape",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),
    
               
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: Get.width,
                    height: 110,
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.switch_camera,
                              color: Colors.white, size: 40),
                          onPressed: controller.switchCamera,
                        ),
                        GestureDetector(
                          onTap: controller.captureImage,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),
              ],
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
