import 'package:flutter/material.dart';

/// Constants used in the app
abstract class Constants {
  // Assets
  static final String kBackgroundSvg = 'assets/svgs/image.svg';

  // Animation durations
  static final Duration kAnimationDuration = Duration(milliseconds: 1000);

  // Colors
  static final Color kScaffoldBackground = Colors.white;
  static final Color kCardBackground = Color(0xFFB9E9FF);
  static final List<Color> kGradient = [Color(0xFF00BCD4), Color(0xFF039BE5), Color(0xFF039BE5)];
}
