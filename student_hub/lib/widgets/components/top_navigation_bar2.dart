import 'package:flutter/material.dart';

class TopNavigationBar2 extends StatelessWidget implements PreferredSizeWidget{
  const TopNavigationBar2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        'StudentHub',
        style: const TextStyle(fontSize: 25, color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}