import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({super.key, required this.child});
  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int index;
  final tabs = ['/home', '/search', '/favorites', '/settings'];

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  void changePage(int value) {
    final route = tabs[value];

    setState(() {
      index = value;
    });

    if (!context.mounted) {
      return;
    }
    context.go(route, extra: value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(top: false, child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) => changePage(value),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          fixedColor: Color(0xff32A873),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ]),
    );
  }
}
