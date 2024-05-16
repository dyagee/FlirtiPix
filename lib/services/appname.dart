// This package is to create customization for the
// app logo or tittle
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appName() {
  return Wrap(
    children: <Widget>[
      Text("Flirti",
          style: GoogleFonts.roboto(
              color: const Color(0xFFFF00FF),
              fontSize: 24,
              fontWeight: FontWeight.w700)),
      Text("Pix",
          style: GoogleFonts.roboto(
              color: const Color(0xFF00AEEF),
              fontSize: 23,
              fontWeight: FontWeight.w700)),
    ],
  );
}
