// // import 'package:flutter/material.dart';
// // import 'package:learning_input_image/learning_input_image.dart';
// // import 'package:learning_text_recognition/learning_text_recognition.dart';
// // import 'package:provider/provider.dart';
// <<<<<<< Updated upstream
// //
// // import "package:gbg_varvet/widgets/drawer_widget.dart";
// //
// =======

// // import "package:gbg_varvet/widgets/drawer_widget.dart";

// >>>>>>> Stashed changes
// // class RecognitionTest extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.lightBlue,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //         primaryTextTheme: TextTheme(
// //           headline6: TextStyle(color: Colors.white),
// //         ),
// //       ),
// //       home: Scaffold(
// //         drawer: const DrawerWidget(title: 'Hej'),
// //         body: ChangeNotifierProvider(
// //           create: (_) => TextRecognitionState(),
// //           child: TextRecognitionPage(),
// //         ),
// //       ),
// //     );
// //   }
// // }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// // class TextRecognitionPage extends StatefulWidget {
// //   @override
// //   _TextRecognitionPageState createState() => _TextRecognitionPageState();
// // }
// <<<<<<< Updated upstream
// //
// // class _TextRecognitionPageState extends State<TextRecognitionPage> {
// //   TextRecognition? _textRecognition = TextRecognition();
// //
// //   /* TextRecognition? _textRecognition = TextRecognition(
// //     options: TextRecognitionOptions.Japanese
// //   ); */
// //
// =======

// // class _TextRecognitionPageState extends State<TextRecognitionPage> {
// //   TextRecognition? _textRecognition = TextRecognition();

// //   /* TextRecognition? _textRecognition = TextRecognition(
// //     options: TextRecognitionOptions.Japanese
// //   ); */

// >>>>>>> Stashed changes
// //   @override
// //   void dispose() {
// //     _textRecognition?.dispose();
// //     super.dispose();
// //   }
// <<<<<<< Updated upstream
// //
// //   Future<void> _startRecognition(InputImage image) async {
// //     TextRecognitionState state = Provider.of(context, listen: false);
// //
// =======

// //   Future<void> _startRecognition(InputImage image) async {
// //     TextRecognitionState state = Provider.of(context, listen: false);

// >>>>>>> Stashed changes
// //     if (state.isNotProcessing) {
// //       state.startProcessing();
// //       state.image = image;
// //       state.data = await _textRecognition?.process(image);
// //       state.stopProcessing();
// //     }
// //   }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //   @override
// //   Widget build(BuildContext context) {
// //     return InputCameraView(
// //       mode: InputCameraMode.gallery,
// //       // resolutionPreset: ResolutionPreset.high,
// //       title: 'Skanna löparnummer',
// //       onImage: _startRecognition,
// //       overlay: Consumer<TextRecognitionState>(
// //         builder: (_, state, __) {
// //           if (state.isNotEmpty) {
// //             return Center(
// //               child: Container(
// //                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.8),
// //                   borderRadius: BorderRadius.all(Radius.circular(4.0)),
// //                 ),
// //                 child: Text(
// //                   state.text,
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //               ),
// //             );
// //           }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// // class TextRecognitionState extends ChangeNotifier {
// //   InputImage? _image;
// //   RecognizedText? _data;
// //   bool _isProcessing = false;
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //   InputImage? get image => _image;
// //   RecognizedText? get data => _data;
// //   String get text => _data!.text;
// //   bool get isNotProcessing => !_isProcessing;
// //   bool get isNotEmpty => _data != null && text.isNotEmpty;
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //   void startProcessing() {
// //     _isProcessing = true;
// //     notifyListeners();
// //   }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //   void stopProcessing() {
// //     _isProcessing = false;
// //     notifyListeners();
// //   }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //   set image(InputImage? image) {
// //     _image = image;
// //     notifyListeners();
// //   }
// <<<<<<< Updated upstream
// //
// =======

// >>>>>>> Stashed changes
// //   set data(RecognizedText? data) {
// //     _data = data;
// //     notifyListeners();
// //   }
// // }
