import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class NotificationPage extends StatefulWidget {
  static const String pageId = "/NotificationPage";

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HUBBottomNavigationBar(currentIndex: 3,),
      appBar: const TopNavigationBar(),
      body: _currentIndex == 3 // Check if currentIndex is 3 (corresponding to Alerts)
        ? SingleChildScrollView(
            child: _buildAlertsScreen(),
          )
        : Container(),
    );
  }

  Widget _buildAlertsScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.accessibility),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      "You have submitted to join project 'Javis - AI Copilot'",
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "6/6/2024",
                      style: TextStyle(fontSize: 16),  
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You have invited to interview for project 'Javis - AI Copilot' at 14:00 March 20, Thursday ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "6/6/2024",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: Text("Join"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You have offder to join project 'Javis - AI Copilot'",
                      style: TextStyle(fontSize: 18 ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "6/6/2024",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: Text("View offer"),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.accessibility),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alex Jor",
                    style: TextStyle(fontSize: 18 ),
                  ),
                  Text(
                    "How are you doing?",
                    style: TextStyle(fontSize: 16),  
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "6/6/2024",
                    style: TextStyle(fontSize: 16),  
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  

  void postJobButtonDidTap() {}
}
