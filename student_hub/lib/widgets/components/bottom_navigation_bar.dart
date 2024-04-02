// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// ignore: must_be_immutable
class HUBBottomNavigationBar extends StatefulWidget {
  final  Function(int index) onSelectedIndexPath;
  int currentIndex;
  HUBBottomNavigationBar({
    Key? key,
    required this.onSelectedIndexPath,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<HUBBottomNavigationBar> createState() => _HUBBottomNavigationBarState();
}

class _HUBBottomNavigationBarState extends State<HUBBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _currentIndex = widget.currentIndex;
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (p0) {
        setState(() {
          widget.currentIndex = p0;
          widget.onSelectedIndexPath(p0);
          onItemTapped(p0);
        });
      },
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.list),
          title: const Text("Projects"),
          selectedColor: Colors.purple,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.space_dashboard),
          title: const Text("Dashboard"),
          selectedColor: Colors.pink,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.message),
          title: const Text("Message"),
          selectedColor: Colors.orange,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.notifications),
          title: const Text("Alerts"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
