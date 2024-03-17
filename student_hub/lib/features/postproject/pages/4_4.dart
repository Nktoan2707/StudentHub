import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class Page44 extends StatefulWidget {
  const Page44({super.key});

  @override
  State<Page44> createState() => _Page44State();
}

class _Page44State extends State<Page44> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "4/4   Project details",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Title of the job",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,), 
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 10,),
                const Text("Students are looking for "),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5, left: 15),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'Clear expectation about your project or deliverables\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5, left: 15),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'The skills required for your project\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5, left: 15),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'Detail about your project\n',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.access_alarms, size: 25),
                        ),
                      ),
                      TextSpan(
                        text: 'Project scope\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.people, size: 25),
                        ),
                      ),
                      TextSpan(
                        text: 'Student required\n',
                      ),
                    ],
                  ),
                ),
                PostJob(),
              ]
            )
          ]
        )
      )
    );
  }
}

class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('postProject_review_raisedButton'),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: Size.fromHeight(30),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {} : null,
            child: const Text('Post Job'),
          );
  }
}