// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HUBBottomNavigationBar extends StatefulWidget {
  const HUBBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  State<HUBBottomNavigationBar> createState() => _HUBBottomNavigationBarState();
}

class _HUBBottomNavigationBarState extends State<HUBBottomNavigationBar> {
  late int _currentIndex;

  @override
  Widget build(BuildContext context) {
    _currentIndex = widget.currentIndex;

    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => {setState(() => _currentIndex = i)},
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
}
