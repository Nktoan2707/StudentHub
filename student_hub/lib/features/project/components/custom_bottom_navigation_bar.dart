import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => {setState(() => _currentIndex = i)},
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(Icons.list),
          title: const Text("Projects"),
          selectedColor: Colors.purple,
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.space_dashboard),
          title: const Text("Dashboard"),
          selectedColor: Colors.pink,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: const Icon(Icons.message),
          title: const Text("Message"),
          selectedColor: Colors.orange,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: const Icon(Icons.notifications),
          title: const Text("Alerts"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}