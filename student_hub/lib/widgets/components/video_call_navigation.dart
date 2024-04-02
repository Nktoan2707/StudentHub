import 'package:flutter/material.dart';

class VideoNavigationBar extends StatelessWidget implements PreferredSizeWidget{
  const VideoNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text(
        'Video call',
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}