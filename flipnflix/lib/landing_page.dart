import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/primary_button.dart';
import 'components/secondary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
              child: Image.asset(
            "images/landing_page.png",
            fit: BoxFit.cover,
          )),
          Container(
            height: size.height * .33,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.9),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Watch movies anytime anywhere",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Explore a vast collection of blockbuster movies, timeless classics, and the latest releases.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                PrimaryButton(onPressed: () {}, text: "Login"),
                SecondaryButton(onPressed: () {}, text: "Sign Up")
              ],
            ),
          )
        ],
      ),
    );
  }
}
