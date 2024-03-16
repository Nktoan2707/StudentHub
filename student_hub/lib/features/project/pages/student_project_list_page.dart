import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project/components/student_project_list_item_view.dart';
import 'package:student_hub/features/project/pages/student_project_detail_page.dart';
import 'package:student_hub/features/project/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/project/pages/student_searched_project_list_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class StudentProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentProjectListPage";

  const StudentProjectListPage({super.key});

  @override
  State<StudentProjectListPage> createState() => _StudentProjectListPageState();
}

class _StudentProjectListPageState extends State<StudentProjectListPage> {
  List<Project> projectList = List.from({
    Project(
        createdAt: "3 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: "6 months",
        numberOfRequiredStudents: 6,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 4),
    Project(
        createdAt: "5 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: "6 months",
        numberOfRequiredStudents: 4,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 2),
    Project(
        createdAt: "6 days ago",
        jobTitle: "Senior frontend developer (Fintech)",
        projectDuration: "6 months",
        numberOfRequiredStudents: 7,
        jobDescription:
            "Students are looking for\n \t + Clear expectation about your project or deliverables",
        numberOfProposals: 8),
  }, growable: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: const TopNavigationBar(),
        bottomNavigationBar: BottomNavigationBar(),
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
                              return Divider(
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
                      icon: FaIcon(
                        FontAwesomeIcons.gratipay,
                        size: 35,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                thickness: 3,
              ),
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: projectList.length,
                itemBuilder: (context, index) {
                  return StudentProjectListItemView(
                    project: projectList[index],
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

  void _searchItem() {
    Navigator.of(context).pushNamed(StudentSearchedProjectListPage.pageId);
  }

  void _goToSavedProjectPage() {
    Navigator.of(context).pushNamed(StudentSavedProjectListPage.pageId);
  }
}

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({
    super.key,
  });

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => {setState(() => _currentIndex = i)},
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(Icons.list),
          title: const Text("Projects"),
          selectedColor: Colors.purple,
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.space_dashboard),
          title: const Text("Dashboard"),
          selectedColor: Colors.pink,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: const Icon(Icons.message),
          title: const Text("Message"),
          selectedColor: Colors.orange,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: const Icon(Icons.notifications),
          title: const Text("Alerts"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}