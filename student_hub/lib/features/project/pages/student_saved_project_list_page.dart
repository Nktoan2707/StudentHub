import 'package:flutter/material.dart';
import 'package:student_hub/app.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project/components/student_project_list_item_view.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';

class StudentSavedProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentSavedProjectListPage";

  const StudentSavedProjectListPage({super.key});

  @override
  State<StudentSavedProjectListPage> createState() =>
      _StudentSavedProjectListPageState();
}

class _StudentSavedProjectListPageState
    extends State<StudentSavedProjectListPage> {
  List<Project> projectList = List.from({
    Project(
        createdAt: "3 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: "6 months",
        numberOfRequiredStudents: 6,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 4),
    Project(
        createdAt: "5 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: "6 months",
        numberOfRequiredStudents: 4,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 2),
    Project(
        createdAt: "6 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: "6 months",
        numberOfRequiredStudents: 7,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 8),
  }, growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          'Saved Projects',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: projectList.length,
              itemBuilder: (context, index) {
                return StudentProjectListItemView(
                  project: projectList[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                  thickness: 3,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
