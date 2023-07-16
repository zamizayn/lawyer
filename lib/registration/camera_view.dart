import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:find_your_lawyer/registration/image_screen.dart';
import 'package:find_your_lawyer/registration/util/face_detector_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

late List<CameraDescription> cameras;

class CameraView extends StatefulWidget {
  final CameraLensDirection initialDirection;

  const CameraView({
    Key? key,
    required this.initialDirection,
  }) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final FaceDetector _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));

  bool _enableCapture = false;
  CustomPaint? _customPaint;
  bool _isBusy = false;
  CameraController? _controller;
  int _cameraIndex = 0;

  @override
  void dispose() {
    _faceDetector.close();
    _stopLive();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection && element.sensorOrientation == 99,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) =>
              element.lensDirection == widget.initialDirection && element.sensorOrientation == 99,
        ),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) => element.lensDirection == widget.initialDirection),
      );
    }
    _startLive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: _captureButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _body() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * _controller!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: CameraPreview(_controller!),
          ),
          if (_customPaint != null) _customPaint!,
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   margin: const EdgeInsets.only(bottom: 100),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: List.generate(
          //           imageList.length,
          //           (index) => InkWell(
          //                 onTap: () => Navigator.of(context).push(CupertinoPageRoute(
          //                   builder: (context) => ImageScreen(image: imageList[index]),
          //                 )),
          //                 child: Image.memory(
          //                   imageList[index],
          //                   width: 70,
          //                   height: 70,
          //                 ),
          //               )),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _captureButton() {
    return _enableCapture
        ? TextButton(
            onPressed: () async {
              try {
                await _controller!.stopImageStream();

                XFile? xFile = await _controller!.takePicture();
                await _controller!.startImageStream(_processCameraImage);

                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (context) => ImageScreen(image: xFile),
                ));
              } catch (e) {
                log(e.toString());
              }
            },
            child: const Icon(
              Icons.circle,
              color: Colors.white,
              size: 70,
            ),
          )
        : const Text(
            'Show Face',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
          );
  }

  Future _startLive() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLive() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _processCameraImage(final CameraImage image) async {
    // log("${image.width}x${image.height}");
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final camera = cameras[_cameraIndex];
    final imageRotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
        InputImageRotation.rotation0deg;
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;
    final planeData = image.planes.map((final Plane plane) {
      return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow, height: plane.height, width: plane.width);
    }).toList();
    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );
    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      inputImageData: inputImageData,
    );

//starting face detection on the inputImage
    if (_isBusy) return;
    _isBusy = true;

    final faces = await _faceDetector.processImage(inputImage);

    setState(() {
      if (faces.length == 1) {
        //enable capture button if there is face
        _enableCapture = true;
      } else {
        _enableCapture = false;
      }
    });

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces, inputImage.inputImageData!.size, inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
