import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.child, required this.index});
  final Widget child;
  final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int index;
  final tabs = ['/home', '/search', '/favorites', '/settings'];

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  void changePage(int index) {
    final route = tabs[index];
    if (!context.mounted) {
      return;
    }
    context.go(route, extra: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.index,
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
