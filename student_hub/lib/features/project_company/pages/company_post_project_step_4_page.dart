import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class CompanyPostProjectStep4Page extends StatefulWidget {
  static const String pageId = "/CompanyPostProjectStep4Page";
  const CompanyPostProjectStep4Page({super.key});

  @override
  State<CompanyPostProjectStep4Page> createState() => _CompanyPostProjectStep4PageState();
}

class _CompanyPostProjectStep4PageState extends State<CompanyPostProjectStep4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "4/4   Project details",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Title of the job",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,), 
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 10,),
                const Text("Students are looking for "),
                RichText(
                  text: const TextSpan(
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
                const SizedBox(height: 10,),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 10,),
                RichText(
                  text: const TextSpan(
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
                const PostJob(),
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
              minimumSize: const Size.fromHeight(30),
              shape: const RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            } : null,
            child: const Text('Post Job'),
          );
  }
}