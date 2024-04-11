import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';

class StudentSavedProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentSavedProjectListPage";

  const StudentSavedProjectListPage({super.key});

  @override
  State<StudentSavedProjectListPage> createState() =>
      _StudentSavedProjectListPageState();
}

class _StudentSavedProjectListPageState
    extends State<StudentSavedProjectListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // context.read<ProjectStudentBloc>().add(ProjectStudentFetched());

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
                if (state is ProjectStudentFetchInProgress || state is ProjectStudentUpdateInProgress) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is ProjectStudentFetchSuccess) {
                  if (state.favoriteProjectList.isEmpty) {
                    return Center(
                      child: Text("Nothing here..."),
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.favoriteProjectList.length,
                    itemBuilder: (context, index) {
                      return StudentProjectListItemView(
                        project: state.favoriteProjectList[index], parentPageId: StudentProjectListPage.pageId,
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
                return const Placeholder();
              },
            ),
          ],
        ),
      ),
    );
  }
}
