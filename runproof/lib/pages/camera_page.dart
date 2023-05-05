import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:gbg_varvet/utils/utils.dart";
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:gbg_varvet/utils/info_popup.dart';

import 'package:flutter_scalable_ocr/text_recognizer_painter.dart';

import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:camera/camera.dart';

import 'package:dfunc/dfunc.dart';

//Largely based on https://pub.dev/packages/flutter_scalable_ocr

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  final String title = 'Scan';

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final User currentUser = FirebaseAuth.instance.currentUser!;
  final DatabaseReference ref = FirebaseDatabase.instance.ref("/users");

  String text = "";
  final StreamController<String> controller = StreamController<String>();
  final searchController = TextEditingController();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var patientModel = context.watch<PatientsModel>();
    final searchController =
        TextEditingController(text: patientModel.searchTerm);
    late String currentText;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerWidget(title: "RunProof"),
      appBar: AppBar(
        title: Image.asset('assets/images/runprooflogo.png',
            fit: BoxFit.contain, height: 60),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 47, 83),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ScalableOCR(
                    paintboxCustom: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4.0
                      ..color = const Color.fromARGB(153, 102, 160, 241),
                    boxLeftOff: 1,
                    boxBottomOff: 2,
                    boxRightOff: 15,
                    boxTopOff: 4,
                    boxHeight: MediaQuery.of(context).size.height / 1.5,
                    getRawData: (value) {
                      inspect(value);
                    },
                    getScannedText: (value) {
                      setText(value);
                    },
                  ),
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width / 9,
                  top: MediaQuery.of(context).size.height / 2,
                  child: StreamBuilder<String>(
                    stream: controller.stream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      currentText = snapshot.data != null ? snapshot.data! : "";
                      final limit5 = limit(5);
                      currentText = currentText.replaceAll(RegExp(r'\D'), '');
                      currentText = limit5(currentText);
                      return Result(text: currentText);
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0, top: 20),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                    onPressed: () {
                      patientModel.searchTerm = currentText;
                      runnerInfoPopup(context, patientModel.searchTerm);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color.fromARGB(255, 66, 190, 122)),
                    child: const Text(
                      'Lägg till',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 187, 205, 231),
            borderRadius: BorderRadius.circular(20)),
        width: 300,
        child: Row(children: [
          const Text(
            "Nr: ",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ]));
  }
}

@override
class ScalableOCR extends StatefulWidget {
  const ScalableOCR(
      {Key? key,
      this.boxLeftOff = 4,
      this.boxRightOff = 4,
      this.boxBottomOff = 2.7,
      this.boxTopOff = 2.7,
      this.boxHeight,
      required this.getScannedText,
      this.getRawData,
      this.paintboxCustom})
      : super(key: key);

  /// Offset on recalculated image left
  final double boxLeftOff;

  /// Offset on recalculated image bottom
  final double boxBottomOff;

  /// Offset on recalculated image right
  final double boxRightOff;

  /// Offset on recalculated image top
  final double boxTopOff;

  /// Height of narowed image
  final double? boxHeight;

  /// Function to get scanned text as a string
  final Function getScannedText;

  /// Get raw data from scanned image
  final Function? getRawData;

  /// Narower box paint
  final Paint? paintboxCustom;

  @override
  ScalableOCRState createState() => ScalableOCRState();
}

class ScalableOCRState extends State<ScalableOCR> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  final cameraPrev = GlobalKey();
  final thePainter = GlobalKey();

  final bool _canProcess = true;
  bool _isBusy = false;
  bool converting = false;
  CustomPaint? customPaint;
  // String? _text;
  CameraController? _controller;
  late List<CameraDescription> _cameras;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 10.0;
  // Counting pointers (number of user fingers on screen)
  final double _minAvailableZoom = 0.0;
  final double _maxAvailableZoom = 10.0;
  double _currentScale = 0.0;
  double _baseScale = 0.0;
  double maxWidth = 0;
  double maxHeight = 0;
  String convertingAmount = "";

  @override
  void initState() {
    super.initState();
    startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height / 100;
    return Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _controller == null ||
                      _controller?.value == null ||
                      _controller?.value.isInitialized == false
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: sizeH * 19,
                    )
                  : _liveFeedBody(),
              SizedBox(height: sizeH * 0),
            ],
          ),
        ));
  }

  // Body of live camera stream
  Widget _liveFeedBody() {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('Tap a camera');
    } else {
      const double previewAspectRatio = 1.1;
      return SizedBox(
        height: widget.boxHeight ?? MediaQuery.of(context).size.height / 5,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: SizedBox(
                height:
                    widget.boxHeight ?? MediaQuery.of(context).size.height / 5,
                key: cameraPrev,
                child: AspectRatio(
                  aspectRatio: 1 / previewAspectRatio,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: ClipRRect(
                      child: Transform.scale(
                        scale: cameraController.value.aspectRatio /
                            previewAspectRatio,
                        child: Center(
                          child: CameraPreview(cameraController, child:
                              LayoutBuilder(builder: (BuildContext context,
                                  BoxConstraints constraints) {
                            maxWidth = constraints.maxWidth;
                            maxHeight = constraints.maxHeight;

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onScaleStart: _handleScaleStart,
                              onScaleUpdate: _handleScaleUpdate,
                              onTapDown: (TapDownDetails details) =>
                                  onViewFinderTap(details, constraints),
                            );
                          })),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (customPaint != null)
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                maxWidth = constraints.maxWidth;
                maxHeight = constraints.maxHeight;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onScaleStart: _handleScaleStart,
                  onScaleUpdate: _handleScaleUpdate,
                  onTapDown: (TapDownDetails details) =>
                      onViewFinderTap(details, constraints),
                  child: customPaint!,
                );
              }),
          ],
        ),
      );
    }
  }

  // Start camera stream function
  Future startLiveFeed() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    final camera = _cameras[0];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            log('User denied camera access.');
            break;
          default:
            log('Handle other errors.');
            break;
        }
      }
    });
  }

  // Process image from camera stream
  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = _cameras[0];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    processImage(inputImage);
  }

  // Scale image
  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  // Handle scale update
  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_controller == null) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await _controller!.setZoomLevel(_currentScale);
  }

  // Focus image
  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (_controller == null) {
      return;
    }

    final CameraController cameraController = _controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  // Stop camera live stream
  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  // Process image
  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        cameraPrev.currentContext != null) {
      final RenderBox renderBox =
          cameraPrev.currentContext?.findRenderObject() as RenderBox;

      var painter = TextRecognizerPainter(
          recognizedText,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation,
          renderBox, (value) {
        widget.getScannedText(value);
      }, getRawData: (value) {
        if (widget.getRawData != null) {
          widget.getRawData!(value);
        }
      },
          boxBottomOff: widget.boxBottomOff,
          boxTopOff: widget.boxTopOff,
          boxRightOff: widget.boxRightOff,
          boxLeftOff: widget.boxRightOff,
          paintboxCustom: widget.paintboxCustom);

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    Future.delayed(const Duration(milliseconds: 900)).then((value) {
      if (!converting) {
        _isBusy = false;
      }

      if (mounted) {
        setState(() {});
      }
    });
  }
}
