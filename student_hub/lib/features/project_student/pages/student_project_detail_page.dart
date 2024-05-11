import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/submit_proposal_student/pages/student_submit_proposal_page.dart';
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
  late String? parentPageId;

  @override
  Widget build(BuildContext context) {
    project = (ModalRoute.of(context)?.settings.arguments as List)[0];
    parentPageId = (ModalRoute.of(context)?.settings.arguments as List)[1];

    return BlocListener<ProjectStudentBloc, ProjectStudentState>(
      listener: (context, state) {
        if (state is ProjectStudentUpdateSuccess) {}
      },
      child: Scaffold(
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
                onTap: () {
                  Navigator.pop(context);
                  context.read<ProjectStudentBloc>().add(ProjectStudentUpdated(
                      projectId: project.projectId!,
                      isDisabled: project.isFavorite,
                      callerPageId: parentPageId));
                },
                title: project.isFavorite ? "Unsave" : "Save",
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
                    Text(
                      project.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 3,
                      height: 30,
                    ),
                    Text(
                      project.description,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 3,
                      height: 30,
                    ),
                    ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: 'Project Scope: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n \t \t - ${getTimeTextProjectScope(project.projectScopeFlag)}',
                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      leading: const Icon(Icons.timer_outlined),
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: 'Student Required: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n \t \t - ${project.numberOfStudents} students',
                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
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
      ),
    );
  }

  void _onApplyButtonClicked() {
    Navigator.of(context).pushNamed(StudentSubmitProposalPage.pageId,
        arguments: project.projectId);
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
