import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:jack/page/detection_page.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../api/speech_api.dart';
import '../utils.dart';
import '../widget/substring_highlighted.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = 'Press the button and tell Jack where to go..';
  bool _isListening = false;
  final Map<String, HighlightedWord> _highlights = {
    'jack': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Jack': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'hate': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'good': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  late stt.SpeechToText _speech;
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Jack"),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(_text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('???   Copied to Clipboard')),
                  );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(bottom: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.3,
                child: SubstringHighlight(
                  text: _text,
                  terms: Command.all,
                  textStyle: const TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleHighlight: const TextStyle(
                    fontSize: 32.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              GestureDetector(
                onTap: () async {
                  var status = await Permission.camera.status;
                  if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
                    await Permission.camera.request();
                  }
                  List cameras = await availableCameras();
                  Get.to(() => DetectionPage(cameras: cameras));
                },
                child: Lottie.asset("assets/lf20_g1pduE.json", fit: BoxFit.contain, height: 200, width: 200),
              ),
              Text(
                'Jack\'s Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          glowColor: Theme.of(context).primaryColor,
          animate: _isListening,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: () {
              _listen();
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this._text = text),
        onListening: (isListening) {
          setState(() => this._isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 2), () {
              Utils.scanText(_text);
            });
          }
        },
      );

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onDevice: false,
          onResult: (SpeechRecognitionResult val) {
            if (!val.finalResult) return;
            setState(() {
              _text = val.recognizedWords;

              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
              Utils.scanText(_text);
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
