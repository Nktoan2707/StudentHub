import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class DashboardProjectListPage extends StatefulWidget {
  static const String pageId = "/ProfileInput";

  const DashboardProjectListPage({super.key});

  @override
  State<DashboardProjectListPage> createState() => _DashboardPageProjectListState();
}

class _DashboardPageProjectListState extends State<DashboardProjectListPage> {
  var _currentIndex = 1;
  int itemCount = 1;

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
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PrimaryText(title: 'Your projects'),
                  InkCustomButton(title: 'Post a project', onTap: postJobButtonDidTap, height: 30, width: 120,)
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
                      width: 150,
                      height: 70,
                      color: Colors.white,
                      child: Center(child: Text('Archieved projects')),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Senior frontend developer (Fintech)'),
                          Spacer(), 
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      SizedBox(height: 8,),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Students are looking for\n",
                            ),
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5, left: 15, bottom: 5),
                                child: Icon(Icons.fiber_manual_record, size: 5),
                              ),
                            ),
                            TextSpan(
                              text: 'Clear expectation about your project or deliverables\n',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('0 Proposals'),
                          Text('8 Messages'),
                          Text('2 Hired'),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black,
                      ), 
                    ],
                  );
                },
              ),

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