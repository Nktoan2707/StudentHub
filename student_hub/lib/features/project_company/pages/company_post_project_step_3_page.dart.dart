import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

import 'company_post_project_step_4_page.dart';

class CompanyPostProjectStep3Page extends StatefulWidget {
  static const String pageId = "/CompanyPostProjectStep3Page";
  const CompanyPostProjectStep3Page({super.key});

  @override
  State<CompanyPostProjectStep3Page> createState() => _CompanyPostProjectStep3PageState();
}

class _CompanyPostProjectStep3PageState extends State<CompanyPostProjectStep3Page> {
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
                        text: "3/4   Next, provide project description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("Student are looking for"),  
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
                const SizedBox(height: 15,),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Describe your project",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                const _Describe(),
                const SizedBox(height: 15,),
                const ReviewPost(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Describe extends StatefulWidget {
  const _Describe();

  @override
  State<_Describe> createState() => _DescribeState();
}

class _DescribeState extends State<_Describe> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('Projectpost_Describe_textField'),
      onChanged: (title){},
      decoration: InputDecoration(
        labelText: "",
        errorText: false ?'invalid title': null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        contentPadding: const EdgeInsets.symmetric(vertical: 40),
      ),
    );
  }
}

class ReviewPost extends StatefulWidget {
  const ReviewPost({super.key});

  @override
  State<ReviewPost> createState() => _ReviewPostState();
}

class _ReviewPostState extends State<ReviewPost> {
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
            onPressed: true ? () {Navigator.of(context).pushNamed(CompanyPostProjectStep4Page.pageId);} : null,
            child: const Text('Review your post'),
          );
  }
}