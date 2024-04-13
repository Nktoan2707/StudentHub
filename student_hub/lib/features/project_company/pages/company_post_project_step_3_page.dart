// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/widgets/components/text_custom.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

import 'company_post_project_step_4_page.dart';

class CompanyPostProjectStep3Page extends StatefulWidget {
  static const String pageId = "/CompanyPostProjectStep3Page";
  const CompanyPostProjectStep3Page({super.key});

  @override
  State<CompanyPostProjectStep3Page> createState() =>
      _CompanyPostProjectStep3PageState();
}

class _CompanyPostProjectStep3PageState
    extends State<CompanyPostProjectStep3Page> {
  late Project postProject;
  TextEditingController descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    postProject = (ModalRoute.of(context)?.settings.arguments as Project);
    descriptionTextController.text = postProject.description;

    return Scaffold(
      appBar: const TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
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
                const SizedBox(
                  height: 10,
                ),
                const Text("Student are looking for"),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: 5, bottom: 5, left: 15),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text:
                            'Clear expectation about your project or deliverables\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: 5, bottom: 5, left: 15),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'The skills required for your project\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: 5, bottom: 5, left: 15),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'Detail about your project\n',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                const SizedBox(
                  height: 15,
                ),
                TextFieldBox(
                    heightBox: 140,
                    textController: descriptionTextController,
                    onChanged: (description) {
                      postProject.description = description;
                    }),
                const SizedBox(
                  height: 15,
                ),
                ReviewPost(
                  project: postProject,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Describe extends StatefulWidget {
  _Describe({
    Key? key,
    required this.onChanged,
    required this.defaultText
  }) : super(key: key);

  final Function(String) onChanged;
  String defaultText;
  @override
  State<_Describe> createState() => _DescribeState();
}

class _DescribeState extends State<_Describe> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    textController.text = widget.defaultText;
    return TextField(
      controller: textController,
      key: const Key('Projectpost_Describe_textField'),
      onChanged: (title) {
        widget.onChanged(title);
      },
      decoration: InputDecoration(
        labelText: "",
        errorText: false ? 'invalid title' : null,
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
  ReviewPost({super.key, required this.project});
  Project project;
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
            onPressed: true
                ? () {
                  if (widget.project.description.isEmpty) {
                    ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Please check again information'),
                          duration: Duration(seconds: 1),),
                        );
                  } else {
                    Navigator.of(context).pushNamed(
                        CompanyPostProjectStep4Page.pageId,
                        arguments: widget.project);
                  }
                    
                  }
                : null,
            child: const Text('Review your post'),
          );
  }
}
