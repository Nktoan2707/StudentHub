import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';
import 'package:student_hub/features/project_student/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_searched_project_list_page.dart';

class StudentProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentProjectListPage";

  const StudentProjectListPage({super.key});

  @override
  State<StudentProjectListPage> createState() => _StudentProjectListPageState();
}

class _StudentProjectListPageState extends State<StudentProjectListPage> {
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
    context.read<ProjectStudentBloc>().add(ProjectStudentFetched());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Autocomplete<String>(
                      optionsBuilder: (textEditingValue) {
                        // return const Iterable<String>.empty();

                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }

                        return Iterable<String>.generate(
                            10, (index) => "test$index");
                      },
                      displayStringForOption: (value) => value,
                      optionsViewBuilder: (context, onSelected, options) {
                        return Material(
                          elevation: 4,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: options.toList().length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () =>
                                    onSelected(options.toList()[index]),
                                // contentPadding: EdgeInsets.zero,
                                title: Text(options.toList()[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 3,
                                height: 20,
                              );
                            },
                          ),
                        );
                      },
                      onSelected: (String value) {
                        _searchItem();
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onEditingComplete: onFieldSubmitted,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                          // onSubmitted: (value) {
                          //   // Perform search functionality here
                          //   // context.read<TodoBloc>().add(TodoSearched(searchedString: value));
                          // },
                        );
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _goToSavedProjectPage();
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.gratipay,
                        size: 35,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 3,
              ),
              BlocBuilder<ProjectStudentBloc, ProjectStudentState>(
                builder: (context, state) {
                  if (state is ProjectStudentFetchInProgress) {
                    return const CircularProgressIndicator();
                  } else if (state is ProjectStudentFetchSuccess) {
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.projectList.length,
                      itemBuilder: (context, index) {
                        return StudentProjectListItemView(
                          project: state.projectList[index],
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
      ),
    );
  }

  void _searchItem() {
    Navigator.of(context).pushNamed(StudentSearchedProjectListPage.pageId);
  }

  void _goToSavedProjectPage() {
    Navigator.of(context).pushNamed(StudentSavedProjectListPage.pageId);
  }
}
