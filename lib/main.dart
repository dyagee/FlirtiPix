import 'package:flirtipix/pages/home.dart';
import 'package:flirtipix/pages/info_page.dart';
import 'package:flirtipix/pages/loading.dart';
import 'package:flirtipix/pages/next_page.dart';
import 'package:flirtipix/pages/previous_page.dart';
import 'package:flirtipix/pages/refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  //load env variables
  await dotenv.load(fileName: ".env");

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const HomePage(),
      '/refresh': (context) => const Refresh(),
      '/next-page': (context) => const NextPage(),
      '/previous-page': (context) => const PreviousPage(),
      '/about-app': (context) => const AboutApp(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: const Color(0xFF4B0082),
      secondaryHeaderColor: const Color(0xFFFF00FF),
      useMaterial3: true,
    ),
  ));
}
