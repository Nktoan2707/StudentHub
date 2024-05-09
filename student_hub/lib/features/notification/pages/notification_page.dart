import 'package:flutter/material.dart';


class NotificationPage extends StatefulWidget {
  static const String pageId = "/NotificationPage";

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
            child: _buildAlertsScreen(),
          ),
    );
  }

  Widget _buildAlertsScreen() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          const Row(
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
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "You have invited to interview for project 'Javis - AI Copilot' at 14:00 March 20, Thursday ",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "6/6/2024",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text("Join"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "You have offder to join project 'Javis - AI Copilot'",
                      style: TextStyle(fontSize: 18 ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "6/6/2024",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text("View offer"),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          const Divider(),
          const Row(
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
