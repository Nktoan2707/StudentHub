import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/pages/student_project_detail_page.dart';

class StudentProjectListItemView extends StatelessWidget {
  const StudentProjectListItemView(
      {super.key, required this.project, this.parentPageId});
  final Project project;
  final String? parentPageId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(StudentProjectDetailPage.pageId,
            arguments: [project, parentPageId]);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Created ${DateTime.parse(project.createdAt).toLocal().toLocal().toString().substring(0, 19)}",
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
          IconButton(
              onPressed: () {
                context.read<ProjectStudentBloc>().add(ProjectStudentUpdated(
                    projectId: project.projectId!,
                    isDisabled: project.isFavorite,
                    callerPageId: parentPageId));
              },
              icon: project.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border)),
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
