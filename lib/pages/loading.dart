// ignore_for_file: avoid_print

import 'package:flirtipix/services/api_calls.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //vast of the variables are imported from api_calls package

  //randomly generated index
  var qIndex = Random().nextInt(qList.length - 1);

  //variables for loading page text animation
  List<Color> colorizeColors = [
    const Color(0xFFFF00FF),
    const Color(0xFF00AEEF),
    const Color(0xFFFF0000),
    const Color(0xFF4B0082),
  ];

  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 10.0,
    fontFamily: GoogleFonts.oswald().fontFamily,
    fontWeight: FontWeight.w600,
  );

  void firstApiCall() async {
    print(qList);

    Map<String, String> params = {
      'key': key,
      'q': qList[qIndex],
      'per_page': perPage,
      'orientation': orientation,
      'page': '$page',
      'pretty': pretty
    };
    MakeApiCall instance =
        MakeApiCall(domain: url, path: path, qparams: params);
    var images = await instance.getImages();
    images.shuffle();

    //delay some seconds before home page
    Future.delayed(const Duration(milliseconds: 19000), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'imgs': images,
        'index': qIndex,
        'pageNumber': page,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    firstApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF4B0082),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingAnimationWidget.flickr(
                leftDotColor: const Color(0xFFFF00FF),
                rightDotColor: const Color(0xFF00AEEF),
                size: 58,
              ),
              const SizedBox(
                height: 80.0,
              ),
              SizedBox(
                width: 400,
                child: Center(
                  child: AnimatedTextKit(animatedTexts: [
                    ColorizeAnimatedText(
                      'Ready to Saturate your Eyes?',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      "Make Sure You're Alone....",
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      'Turn Off the Lights....',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      'Stay Jiggy....',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ]),
                ),
              ),
            ],
          ),
          // child: SpinKitWanderingCubes(
          //   color: Color(0xFF808080),
          //   size: 100.0,
          // ),
        ));
  }
}
