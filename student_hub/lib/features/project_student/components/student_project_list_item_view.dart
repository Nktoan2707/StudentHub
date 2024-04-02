import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/pages/student_project_detail_page.dart';

class StudentProjectListItemView extends StatelessWidget {
  const StudentProjectListItemView({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(StudentProjectDetailPage.pageId, arguments: project);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Created ${project.createdAt}"),
                Text(project.jobTitle),
                Text("Time: ${project.projectDuration}"),
                Text(project.jobDescription),
                Text(
                    "Proposals: ${project.numberOfProposals >= 5 ? project.numberOfProposals : "Less than 5"}"),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}