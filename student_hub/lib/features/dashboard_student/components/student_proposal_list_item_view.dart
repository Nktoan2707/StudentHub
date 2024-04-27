import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/pages/student_project_detail_page.dart';

class StudentProposalListItemView extends StatelessWidget {
  const StudentProposalListItemView({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(StudentProjectDetailPage.pageId, arguments: [project]);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Created ${project.createdAt}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  project.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "Time: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(getTimeTextProjectScope(project.projectScopeFlag))
                  ],
                ),
                Text(project.description),
                Row(
                  children: [
                    Text(
                      "Proposals: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${project.countProposals >= 5 ? project.countProposals : "Less than 5"}")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTimeTextProjectScope(ProjectScopeFlag projectScopeFlag) {
    switch (projectScopeFlag) {
      case ProjectScopeFlag.LessThanOneMonth:
        return "< 1 month";

      case ProjectScopeFlag.OneToThreeMonth:
        return "1 - 3 months";

      case ProjectScopeFlag.ThreeToSixMonth:
        return "3 - 6 months";

      case ProjectScopeFlag.MoreThanSixMOnth:
        return "> 6 months";

      default:
        return 'Unknown';
    }
  }
}
