import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/switch_account_page.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget{
  const TopNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text(
        'StudentHub',
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {
          Navigator.of(context).pushNamed(SwitchAccountPage.pageId);
          },
          icon: const Icon(Icons.account_circle_rounded),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}