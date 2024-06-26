// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

import 'company_post_project_step_3_page.dart';

class CompanyPostProjectStep2Page extends StatefulWidget {
  static const String pageId = "/CompanyPostProjectStep2Page";
  const CompanyPostProjectStep2Page({super.key});

  @override
  State<CompanyPostProjectStep2Page> createState() =>
      _CompanyPostProjectStep2PageState();
}

class _CompanyPostProjectStep2PageState
    extends State<CompanyPostProjectStep2Page> {
  late Project postProject;

  @override
  Widget build(BuildContext context) {
    postProject = (ModalRoute.of(context)?.settings.arguments as Project);

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
                        text: "2/4   Next, estimate the scope of your job",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Consider the size of your project and the timeline"),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "How long will your project take?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CircularCheckBox(
                            onChanged: (p0) {
                              if (p0 == 1) {
                                postProject.projectScopeFlag =
                                    ProjectScopeFlag.OneToThreeMonth;
                              }
                            },
                            isChecked: postProject.projectScopeFlag == ProjectScopeFlag.OneToThreeMonth,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: '1 to 3 months\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CircularCheckBox(
                            onChanged: (p0) {
                              if (p0 == 1) {
                                postProject.projectScopeFlag =
                                    ProjectScopeFlag.ThreeToSixMonth;
                              }
                            },
                             isChecked: postProject.projectScopeFlag == ProjectScopeFlag.ThreeToSixMonth,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: '3 to 6 months\n',
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
                        text: "How many students do you want for this project?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _number(
                  onChanged: (p0) {
                    postProject.numberOfStudents = int.parse(p0);
                  },
                  defaultText: postProject.numberOfStudents.toString(),
                ),
                const SizedBox(
                  height: 25,
                ),
                NextDescription(
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

class _number extends StatefulWidget {
  _number({
    Key? key,
    required this.onChanged,
    required this.defaultText
  }) : super(key: key);
  final Function(String) onChanged;
  String defaultText;
  @override
  State<_number> createState() => _numberState();
}

class _numberState extends State<_number> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    textController.text = widget.defaultText;
    return TextField(
      controller: textController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      key: const Key('Projectpost_number_textField'),
      onChanged: (title) {
        widget.onChanged(title);
      },
      decoration: InputDecoration(
        labelText: "number of students",
        errorText: false ? 'invalid title' : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class NextDescription extends StatefulWidget {
  NextDescription({super.key, required this.project});

  Project project;
  @override
  State<NextDescription> createState() => _NextDescriptionState();
}

class _NextDescriptionState extends State<NextDescription> {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('postProject_continue_raisedButton'),
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
                  if (widget.project.numberOfStudents <= 0 || widget.project.projectScopeFlag == ProjectScopeFlag.LessThanOneMonth) {
                    ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Please check again information'),
                          duration: Duration(seconds: 1),),
                        );
                  } else {
                    Navigator.of(context).pushNamed(
                        CompanyPostProjectStep3Page.pageId,
                        arguments: widget.project);
                  }
                  }
                : null,
            child: const Text('Next Scope'),
          );
  }
}

class CircularCheckBox extends StatefulWidget {
  CircularCheckBox({super.key, required this.onChanged, required this.isChecked});

  final Function(int) onChanged;
  bool isChecked;
  @override
  State<CircularCheckBox> createState() => _CircularCheckBoxState();
}

class _CircularCheckBoxState extends State<CircularCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked;
          widget.onChanged(widget.isChecked ? 1 : 0);
        });
      },
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        child: widget.isChecked
            ? const Icon(
                Icons.check,
                size: 10,
                color: Colors.black,
              )
            : null,
      ),
    );
  }
}
