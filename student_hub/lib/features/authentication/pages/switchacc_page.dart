import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar2.dart';

class SwitchAccPage extends StatefulWidget {
  const SwitchAccPage({super.key});

  @override
  State<SwitchAccPage> createState() => _SwitchAccPageState();
}

class _SwitchAccPageState extends State<SwitchAccPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar2(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hai Pham"),
                    Text("Company"),
                  ],
                ),
                Icon(Icons.arrow_drop_up_outlined)
              ],
            ),
            SizedBox(height: 10),

            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            // Vertical List
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Profile"),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Setting"),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Log out"),
                  onTap: () {
                  },
                ),
              ],
            ),
          ],
        ), 
      ),
    );
  }
}