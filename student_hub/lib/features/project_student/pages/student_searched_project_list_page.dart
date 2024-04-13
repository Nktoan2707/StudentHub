import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';

class StudentSearchedProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentSearchedProjectListPage";

  const StudentSearchedProjectListPage({super.key});

  @override
  State<StudentSearchedProjectListPage> createState() =>
      _StudentSearchedProjectListPageState();
}

class _StudentSearchedProjectListPageState
    extends State<StudentSearchedProjectListPage> {
  final PanelController panelController = PanelController();

  bool _isFilterApplied = false;

  Map<String, dynamic> projectFilterQueryMap = {};

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
            'Project Search',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          centerTitle: false,
          backgroundColor: Colors.grey,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocConsumer<ProjectStudentBloc, ProjectStudentState>(
          listener: (context, state) {
            if (state is ProjectStudentUpdateSuccess &&
                state.callerPageId == StudentSearchedProjectListPage.pageId) {
              _searchItem(ProjectQueryFilter.fromMap(projectFilterQueryMap));
            } else if (state is ProjectStudentSearchSuccess) {
              projectFilterQueryMap["title"] = state.projectQueryFilter.title;
              _isFilterApplied = false;
            }
          },
          builder: (context, state) {
            if (state is ProjectStudentSearchInProgress ||
                state is ProjectStudentUpdateInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectStudentSearchSuccess) {
              return Stack(
                children: [
                  SlidingUpPanel(
                    backdropEnabled: true,
                    isDraggable: false,
                    minHeight: panelHeightClosed,
                    maxHeight: panelHeightOpen,
                    parallaxEnabled: false,
                    parallaxOffset: 0.5,
                    renderPanelSheet: false,
                    controller: panelController,
                    panelBuilder: (scrollController) => _FilterFloatingPanel(
                      panelController: panelController,
                      onApplyPressed:
                          (Map<String, dynamic> projectFilterQueryMap) {
                        setState(() {
                          _isFilterApplied = true;
                          this.projectFilterQueryMap = projectFilterQueryMap;
                        });
                      },
                      onClearFiltersPressed: () {
                        setState(() {
                          _isFilterApplied = false;
                          projectFilterQueryMap.clear();
                        });
                      },
                    ),
                    collapsed: null,
                    body: SingleChildScrollView(
                      child: Padding(
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
                                      return [textEditingValue.text];
                                    },
                                    initialValue: TextEditingValue(
                                        text: state.projectQueryFilter.title ??
                                            ""),
                                    displayStringForOption: (value) => value,
                                    optionsViewBuilder:
                                        (context, onSelected, options) {
                                      return Material(
                                        elevation: 4,
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemCount: options.toList().length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () => onSelected(
                                                  options.toList()[index]),
                                              // contentPadding: EdgeInsets.zero,
                                              title:
                                                  Text(options.toList()[index]),
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
                                      if (value.isNotEmpty) {
                                        projectFilterQueryMap["title"] = value;
                                      }
                                      _searchItem(ProjectQueryFilter.fromMap(
                                          projectFilterQueryMap));
                                    },
                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      return TextField(
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        onEditingComplete: onFieldSubmitted,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        cursorColor: Colors.black,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          hintText: 'Search...',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _filterPanelToggle(true);
                                    },
                                    icon: Icon(
                                      _isFilterApplied
                                          ? Icons.filter_alt
                                          : Icons.filter_list_off,
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
                            if (state.searchedProjectList.isEmpty)
                              Center(child: Text("No matching project..."))
                            else
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.searchedProjectList.length,
                                itemBuilder: (context, index) {
                                  return StudentProjectListItemView(
                                    project: state.searchedProjectList[index],
                                    parentPageId:
                                        StudentSearchedProjectListPage.pageId,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
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
                  ),
                ],
              );
            }

            return const Placeholder();
          },
        ),
      ),
    );
  }

  void _searchItem(ProjectQueryFilter projectQueryFilter) {
    context
        .read<ProjectStudentBloc>()
        .add(ProjectStudentSearched(projectQueryFilter: projectQueryFilter));
  }

  void _filterPanelToggle(bool toggle) {
    toggle ? panelController.open() : panelController.close();
  }
}

class _FilterFloatingPanel extends StatefulWidget {
  final PanelController panelController;
  final Function(Map<String, dynamic>) onApplyPressed;
  final VoidCallback onClearFiltersPressed;

  const _FilterFloatingPanel(
      {required this.panelController,
      required this.onApplyPressed,
      required this.onClearFiltersPressed});

  @override
  State<_FilterFloatingPanel> createState() => _FilterFloatingPanelState();
}

class _FilterFloatingPanelState extends State<_FilterFloatingPanel> {
  ProjectScopeFlag projectScopeFlag = ProjectScopeFlag.LessThanOneMonth;
  final TextEditingController _studentNeededTextFieldController =
      TextEditingController(text: "");
  final TextEditingController _proposalsLessThanTextFieldController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.panelController.close();
              },
              icon: const FaIcon(FontAwesomeIcons.circleXmark),
              constraints: const BoxConstraints(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Filter By",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 3,
              height: 40,
            ),
            const Text(
              "Project length",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            ListTile(
              title: const Text('Less than one month'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: ProjectScopeFlag.LessThanOneMonth.index,
                groupValue: projectScopeFlag.index,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    projectScopeFlag = ProjectScopeFlag.values[value!];
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('1 to 3 months'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: ProjectScopeFlag.OneToThreeMonth.index,
                groupValue: projectScopeFlag.index,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    projectScopeFlag = ProjectScopeFlag.values[value!];
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('3 to 6 months'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: ProjectScopeFlag.ThreeToSixMonth.index,
                groupValue: projectScopeFlag.index,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    projectScopeFlag = ProjectScopeFlag.values[value!];
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('More than 6 months'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: ProjectScopeFlag.MoreThanSixMOnth.index,
                groupValue: projectScopeFlag.index,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    projectScopeFlag = ProjectScopeFlag.values[value!];
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Students needed",
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _studentNeededTextFieldController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 30),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Proposals less than",
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _proposalsLessThanTextFieldController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 30),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkCustomButton(
                  title: "Clear Filters",
                  padding: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                  onTap: () {
                    widget.onClearFiltersPressed();
                    widget.panelController.close();
                  },
                ),
                InkCustomButton(
                  title: "Apply",
                  padding: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                  onTap: () {
                    Map<String, dynamic> projectFilterQueryMap = {};
                    if (projectScopeFlag != null) {
                      projectFilterQueryMap.addEntries(
                          [MapEntry("projectScopeFlag", projectScopeFlag)]);
                    }
                    if (_studentNeededTextFieldController
                        .value.text.isNotEmpty) {
                      projectFilterQueryMap.addEntries([
                        MapEntry(
                            "numberOfStudents",
                            int.parse(
                                _studentNeededTextFieldController.value.text))
                      ]);
                    }
                    if (_proposalsLessThanTextFieldController
                        .value.text.isNotEmpty) {
                      projectFilterQueryMap.addEntries([
                        MapEntry(
                            "proposalsLessThan",
                            int.parse(_proposalsLessThanTextFieldController
                                .value.text))
                      ]);
                    }
                    widget.onApplyPressed(projectFilterQueryMap);

                    widget.panelController.close();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
