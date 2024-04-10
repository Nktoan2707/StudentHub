import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/pages/student_submit_proposal_page.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';

class StudentProjectDetailPage extends StatefulWidget {
  static const String pageId = "/StudentProjectDetailPage";

  const StudentProjectDetailPage({super.key});

  @override
  State<StudentProjectDetailPage> createState() =>
      _StudentProjectDetailPageState();
}

class _StudentProjectDetailPageState extends State<StudentProjectDetailPage> {
  late Project project;

  @override
  Widget build(BuildContext context) {
    project = (ModalRoute.of(context)?.settings.arguments as Project);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          'Project Detail',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkCustomButton(
              onTap: () {
                _onApplyButtonClicked();
              },
              title: "Apply Now",
              height: 50,
              width: (MediaQuery.of(context).size.width / 3),
            ),
            InkCustomButton(
              onTap: () {},
              title: "Save",
              height: 50,
              width: (MediaQuery.of(context).size.width / 3),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title),
                  const Divider(
                    thickness: 3,
                    height: 30,
                  ),
                  Text(project.description),
                  const Divider(
                    thickness: 3,
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                        "Project Scope: \n \t \t - ${project.projectScopeFlag}"),
                    leading: const Icon(Icons.timer_outlined),
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    title: Text(
                        "Student Required: \n \t \t - ${project.numberOfStudents} students"),
                    leading: const Icon(Icons.people_rounded),
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onApplyButtonClicked() {
    Navigator.of(context).pushNamed(StudentSubmitProposalPage.pageId);
  }
}
