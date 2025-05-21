import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/home_banner.png',
          fit: BoxFit.cover,
          width: double.infinity
          )
      ],
    );
  }
}