import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/dashboard_student_accept_proposal/pages/dashboard_student_accept_page.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/pages/student_project_detail_page.dart';

class StudentProposalListItemView extends StatelessWidget {
  const StudentProposalListItemView({super.key, required this.proposal});

  final Proposal proposal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DashboardStudentAcceptPage.pageId, arguments: proposal);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Created ${proposal.createdAt}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  proposal.project!.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "Time: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(getTimeTextProjectScope(
                        proposal.project!.projectScopeFlag))
                  ],
                ),
                Text(proposal.project!.description),
                Row(
                  children: [
                    Text(
                      "Proposals: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${proposal.project!.countProposals >= 5 ? proposal.project!.countProposals : "Less than 5"}")
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
