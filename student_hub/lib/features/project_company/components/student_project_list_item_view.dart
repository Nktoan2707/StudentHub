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
                Text(project.title),
                Text("Time: ${project.projectScopeFlag}"),
                Text(project.description),
                Text(
                    "Proposals: ${project.countProposals >= 5 ? project.countProposals : "Less than 5"}"),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}