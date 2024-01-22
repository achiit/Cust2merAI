import 'package:admin/constants.dart';
import 'package:admin/viewmodel/priority_provider.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? solvedCount;
  final int? unsolvedCount;
  double get solvedpercentage => (solvedCount! / (solvedCount! + unsolvedCount!)) * 100;
  double get unsolvedpercentage => (unsolvedCount! / (solvedCount! + unsolvedCount!)) * 100;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.solvedCount,
    this.unsolvedCount,
    this.color,
  });
}


// List demoMyFiles = [
//   CloudStorageInfo(
//     title: "Solved",
//     svgSrc: "assets/icons/Documents.svg",
//     color: primaryColor,
//     percentage: 50,
//   ),
//   CloudStorageInfo(
//     title: "Unsolved",
//     svgSrc: "assets/icons/google_drive.svg",
//     color: Color(0xFFFFA113),
//     percentage: 50,
//   ),
// ];
