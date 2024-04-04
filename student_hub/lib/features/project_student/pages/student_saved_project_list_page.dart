import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';

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
        companyId: "aaa",
        createdAt: "3 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: 0,
        numberOfStudents: 6,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 4),
    Project(
        companyId: "aaa",
        createdAt: "5 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: 0,
        numberOfStudents: 4,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 2),
    Project(
        companyId: "aaa",
        createdAt: "6 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: 0,
        numberOfStudents: 7,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 8),
  }, growable: true);

  @override
  Widget build(BuildContext context) {
    context.read<ProjectStudentBloc>().add(ProjectStudentFavoriteFetched());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<ProjectStudentBloc>().add(ProjectStudentFetched());

            Navigator.of(context).pop();
          },
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
            BlocBuilder<ProjectStudentBloc, ProjectStudentState>(
              builder: (context, state) {
                if (state is ProjectStudentFetchFavoriteInProgress) {
                  return CircularProgressIndicator();
                } else if (state is ProjectStudentFetchFavoriteSuccess) {
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.favoriteProjectList.length,
                    itemBuilder: (context, index) {
                      return StudentProjectListItemView(
                        project: state.favoriteProjectList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 3,
                      );
                    },
                  );
                }
                return Placeholder();
              },
            ),
          ],
        ),
      ),
    );
  }
}
