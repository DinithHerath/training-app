import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_app/constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Constants.kGradient,
          stops: [0, 0.33, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
      child: SvgPicture.asset(
        Constants.kBackgroundSvg,
        color: Color(0xFF11A1E4),
        fit: BoxFit.cover,
      ),
    );
  }
}
