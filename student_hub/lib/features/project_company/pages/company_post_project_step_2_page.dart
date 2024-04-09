import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

import 'company_post_project_step_3_page.dart';

class CompanyPostProjectStep2Page extends StatefulWidget {
  static const String pageId = "/CompanyPostProjectStep2Page";
  const CompanyPostProjectStep2Page({super.key});

  @override
  State<CompanyPostProjectStep2Page> createState() => _CompanyPostProjectStep2PageState();
}

class _CompanyPostProjectStep2PageState extends State<CompanyPostProjectStep2Page> {
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
            const SizedBox(height: 40,),
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
                const SizedBox(height: 10,),
                const Text("Consider the size of your project and the timeline"),
                const SizedBox(height: 15,),
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
                const SizedBox(height: 15,),  
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: CircularCheckBox( onChanged: (p0) {
                            if (p0 == 1) {
                              postProject.projectDuration = 0;
                            }
                          },),
                        ),
                      ),
                      TextSpan(
                        text: '1 to 3 months\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: CircularCheckBox( onChanged: (p0) {
                            if (p0 == 1) {
                              postProject.projectDuration = 1;
                            }
                          },),
                        ),
                      ),
                      TextSpan(
                        text: '3 to 6 months\n',
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
                        text: "How long will your project take?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                _number(onChanged: (p0) {
                  postProject.numberOfStudents = int.parse(p0);
                },),
                const SizedBox(height: 25,),
                NextDescription(project: this.postProject,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _number extends StatefulWidget {
  const _number({required this.onChanged});
  final Function(String) onChanged;
  @override
  State<_number> createState() => _numberState();
}

class _numberState extends State<_number> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('Projectpost_number_textField'),
      onChanged: (title){
        widget.onChanged(title);
      },
      decoration: InputDecoration(
        labelText: "number of students",
        errorText: false ?'invalid title': null,
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
            onPressed: true ? () {
              Navigator.of(context).pushNamed(CompanyPostProjectStep3Page.pageId, arguments: widget.project);
            } : null,
            child: const Text('Next Scope'),
          );
  }
}

class CircularCheckBox extends StatefulWidget {
  const CircularCheckBox({super.key, required this.onChanged});

  final Function(int) onChanged;
  @override
  State<CircularCheckBox> createState() => _CircularCheckBoxState();
}

class _CircularCheckBoxState extends State<CircularCheckBox> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChanged(_isChecked ? 1 : 0);
        });
      },
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        child: _isChecked
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