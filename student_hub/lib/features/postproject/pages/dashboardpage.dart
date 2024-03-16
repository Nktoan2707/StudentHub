import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class DashboardPage extends StatefulWidget {
  static const String pageId = "/ProfileInput";

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNavigationBar(),
      appBar: const TopNavigationBar(),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PrimaryText(title: 'Your projects'),
                  InkCustomButton(title: 'Post a jobs', onTap: postJobButtonDidTap, height: 30, width: 120,)
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 70,
                      color: Colors.white,
                      child: Center(child: Text('All projects')),
                    ),
                    Container(
                      width: 100,
                      height: 70,
                      color: Colors.white,
                      child: Center(child: Text('Working')),
                    ),
                    Container(
                      width: 100,
                      height: 70,
                      color: Colors.white,
                      child: Center(child: Text('Archieved')),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(
                height: 40,
              ),
              const PrimaryText(textAlign: TextAlign.center, title: 'Welcome! \n You have no jobs'),
              const SizedBox(
                height: 50,
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  SalomonBottomBar getBottomNavigationBar() {
    return SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
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

  void postJobButtonDidTap() {}
}
