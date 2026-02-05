import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Primary Logo.png',
      height: 150,
      width: 150,
    );
  }
}
