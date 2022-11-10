import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../api/speech_api.dart';
import '../emotiondetect.dart';
import 'package:lottie/lottie.dart';


import '../api/speech_api.dart';
import '../main.dart';
import '../utils.dart';
import '../widget/substring_highlighted.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              Get.to(() => EmotionDetect());
            }, icon:Icon(Icons.arrow_forward_ios)),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('✓   Copied to Clipboard')),
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
            children: [
              SubstringHighlight(
                text: text,
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
              SizedBox(height: Get.height/4,),
              Lottie.asset("assets/lf20_g1pduE.json",fit: BoxFit.contain,height: 200,width: 200),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              Utils.scanText(text);
            });
          }
        },
      );
}
