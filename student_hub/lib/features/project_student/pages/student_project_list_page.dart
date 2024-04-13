import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';
import 'package:student_hub/features/project_student/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_searched_project_list_page.dart';
import 'package:student_hub/widgets/components/text_custom.dart';

class StudentProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentProjectListPage";

  const StudentProjectListPage({super.key});

  @override
  State<StudentProjectListPage> createState() => _StudentProjectListPageState();
}

class _StudentProjectListPageState extends State<StudentProjectListPage> {
  @override
  Widget build(BuildContext context) {
    context.read<ProjectStudentBloc>().add(ProjectStudentFetched());

    return BlocConsumer<ProjectStudentBloc, ProjectStudentState>(
      listener: (context, state) {
        if (state is ProjectStudentUpdateSuccess &&
            state.callerPageId == StudentProjectListPage.pageId) {
          context.read<ProjectStudentBloc>().add(ProjectStudentFetched());
        } else if (state is ProjectStudentUpdateFailure) {
          showProfileNotCreatedDialog();
        }
      },
      builder: (context, state) {
        if (state is ProjectStudentFetchInProgress ||
            state is ProjectStudentUpdateInProgress) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is ProjectStudentFetchSuccess) {
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
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }

                              Iterable<String> optionList =
                                  Iterable<String>.generate(
                                      state.projectList.length,
                                      (index) =>
                                          state.projectList[index].title).where(
                                      (e) => e.contains(textEditingValue.text));

                              return optionList.isNotEmpty
                                  ? optionList
                                  : [textEditingValue.text];
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
                                      contentPadding: EdgeInsets.zero,
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
                              _searchItem(ProjectQueryFilter(title: value));
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
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
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.projectList.length,
                      itemBuilder: (context, index) {
                        return StudentProjectListItemView(
                          project: state.projectList[index],
                          parentPageId: StudentProjectListPage.pageId,
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
            ),
          );
        }
        return const Placeholder();
      },
    );
  }

  void _searchItem(ProjectQueryFilter projectQueryFilter) {
    Navigator.of(context).pushNamed(StudentSearchedProjectListPage.pageId);
    context
        .read<ProjectStudentBloc>()
        .add(ProjectStudentSearched(projectQueryFilter: projectQueryFilter));
  }

  void _goToSavedProjectPage() {
    Navigator.of(context).pushNamed(StudentSavedProjectListPage.pageId);
  }

  void showProfileNotCreatedDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const HeaderText(title: 'Error'),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          const Text(
              textAlign: TextAlign.left, 'Student Profile is not created!'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    this
                        .context
                        .read<ProjectStudentBloc>()
                        .add(ProjectStudentFetched());
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(
                        context, StudentProfileInputStep1Page.pageId);
                    this
                        .context
                        .read<ProjectStudentBloc>()
                        .add(ProjectStudentFetched());
                  },
                  child: const Text('Create Student Profile')),
            ],
          )
        ],
      ),
    );
  }
}
