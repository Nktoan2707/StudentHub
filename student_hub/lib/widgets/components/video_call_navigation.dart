import 'package:flutter/material.dart';

class VideoNavigationBar extends StatelessWidget implements PreferredSizeWidget{
  const VideoNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        'Video call',
        style: const TextStyle(fontSize: 25, color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_horiz),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}