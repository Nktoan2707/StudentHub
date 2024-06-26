import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_company/bloc/company_project_bloc.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/bloc/company_project_state.dart';
import 'package:student_hub/features/project_company/pages/company_post_project_step_1_page.dart';
import 'package:student_hub/features/project_company/pages/company_project_detail_page.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class CompanyDashboardPage extends StatefulWidget {
  static const String pageId = "/CompanyDashboardPage";

  const CompanyDashboardPage({super.key});

  @override
  State<CompanyDashboardPage> createState() => _CompanyDashboardPageState();
}

class _CompanyDashboardPageState extends State<CompanyDashboardPage>
    with TickerProviderStateMixin {
  int itemCount = 1;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyProjectBloc, CompanyProjectState>(
      listener: (context, state) {
        if (state is CompanyProjectDeleteStateSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Delete Project Successful'),
                duration: Duration(seconds: 3),
              ),
            );
        }

        if (state is CompanyProjectDeleteStateFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Delete project fail. Please try later'),
                duration: Duration(seconds: 3),
              ),
            );
        }
      },
      child: BlocBuilder<CompanyProjectBloc, CompanyProjectState>(
        builder: (context, state) {
          if (state is! CompanyProjectStateSuccess) {
            context
                .read<CompanyProjectBloc>()
                .add(CompanyProjectListFetch(typeFlag: -1));
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }

          List<Project> listProject = state.projectList;
          List<Project> listWorkingProject = [], listArchiveProject = [];

          for (var project in listProject) {
            if (project.typeFlag == 1) listWorkingProject.add(project);
            if (project.typeFlag == 2) listArchiveProject.add(project);
          }

          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PrimaryText(title: 'Your projects'),
                          InkCustomButton(
                            title: 'Post a project',
                            onTap: postJobButtonDidTap,
                            height: 30,
                            width: 150,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: TabBar(
                          unselectedLabelColor: Colors.redAccent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Colors.redAccent,
                                Colors.orangeAccent
                              ]),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.redAccent),
                          controller: _tabController,
                          tabs: const <Widget>[
                            Tab(text: 'All projects'),
                            Tab(text: 'Working'),
                            Tab(text: 'Archived'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            if (!listProject.isEmpty)
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: listProject.length,
                                            itemBuilder: (context, index) {
                                              Project project =
                                                  listProject[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pushNamed(
                                                      CompanyProjectDetailPage
                                                          .pageId,
                                                      arguments: _getMap(
                                                          project.projectId!,
                                                          0));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 16, 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            project.title,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                            maxLines: 2,
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons
                                                                .more_horiz),
                                                            onPressed: () {
                                                              actionMenuButtonDidTap(
                                                                  project);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(project.description),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              '${project.countProposals} Proposals'),
                                                          Text(
                                                              '${project.countMessages} Messages'),
                                                          Text(
                                                              '${project.countHired} Hired'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const Divider(
                                                color: Colors.grey,
                                                thickness: 3,
                                                height: 10,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (listProject.isEmpty)
                              Center(
                                child: Text("Not found"),
                              ),
                            if (!listWorkingProject.isEmpty)
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: listProject.length,
                                              itemBuilder: (context, index) {
                                                Project project =
                                                    listProject[index];
                                                if (project.typeFlag != 0) {
                                                  return null;
                                                }

                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pushNamed(
                                                        CompanyProjectDetailPage
                                                            .pageId,
                                                        arguments: _getMap(
                                                            project.projectId!,
                                                            0));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            project.title,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                            maxLines: 2,
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons
                                                                    .more_horiz),
                                                            onPressed: () {
                                                              actionMenuButtonDidTap(
                                                                  project);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(project.description),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              '${project.countProposals} Proposals'),
                                                          Text(
                                                              '${project.countMessages} Messages'),
                                                          Text(
                                                              '${project.countHired} Hired'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Divider(
                                                  color: Colors.grey,
                                                  thickness: 3,
                                                  height: 50,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (listWorkingProject.isEmpty)
                              Center(
                                child: Text("Not found"),
                              ),
                            if (!listArchiveProject.isEmpty)
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  listArchiveProject.length,
                                              itemBuilder: (context, index) {
                                                Project project =
                                                    listProject[index];

                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pushNamed(
                                                        CompanyProjectDetailPage
                                                            .pageId,
                                                        arguments: _getMap(
                                                            project.projectId!,
                                                            0));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            project.title,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                            maxLines: 2,
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons
                                                                    .more_horiz),
                                                            onPressed: () {
                                                              actionMenuButtonDidTap(
                                                                  project);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(project.description),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              '${project.countProposals} Proposals'),
                                                          Text(
                                                              '${project.countMessages} Messages'),
                                                          Text(
                                                              '${project.countHired} Hired'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Divider(
                                                  color: Colors.grey,
                                                  thickness: 3,
                                                  height: 10,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (listArchiveProject.isEmpty)
                              Center(
                                child: Text("Not found"),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void postJobButtonDidTap() {
    Navigator.of(context).pushNamed(CompanyPostProjectStep1Page.pageId);
  }

  void actionMenuButtonDidTap(Project project) {
    int id = project.projectId!;
    showModalBottomSheet(
      context: context,
      builder: (contextx) {
        return BlocProvider.value(
          value: BlocProvider.of<CompanyProjectBloc>(context),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.view_list),
                  title: Text('View Proposals'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        CompanyProjectDetailPage.pageId,
                        arguments: _getMap(id, 0));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('View messages'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        CompanyProjectDetailPage.pageId,
                        arguments: _getMap(id, 2));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_2),
                  title: Text('View hired'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        CompanyProjectDetailPage.pageId,
                        arguments: _getMap(id, 3));
                  },
                ),
                Divider(color: Colors.black, height: 10, thickness: 1),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('View job posting'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        CompanyProjectDetailPage.pageId,
                        arguments: _getMap(id, 1));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit posting'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        CompanyPostProjectStep1Page.pageId,
                        arguments: _getMap(id, 1));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove),
                  title: Text('Remove posting'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (contexts) => BlocProvider.value(
                        value: BlocProvider.of<CompanyProjectBloc>(context),
                        child: SimpleDialog(
                          title: const HeaderText(title: 'Delete project'),
                          contentPadding: const EdgeInsets.all(20.0),
                          children: [
                            const Text(
                                textAlign: TextAlign.left,
                                'Do you really want to delete this project?'),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(contexts).pop();
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      context.read<CompanyProjectBloc>().add(
                                          CompanyProjectDelete(projectId: id));
                                      Navigator.of(contexts).pop();
                                      Navigator.of(contextx).pop();
                                    },
                                    child: const Text('Send')),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.black, height: 10, thickness: 1),
                ListTile(
                  leading: Icon(Icons.start),
                  title: Text('Start working this project'),
                  onTap: () {
                    if (project.numberOfStudents != project.countHired) {
                      showDialog(
                        context: context,
                        builder: (contexts) => BlocProvider.value(
                          value: BlocProvider.of<CompanyProjectBloc>(context),
                          child: SimpleDialog(
                            title: const HeaderText(title: 'Information'),
                            contentPadding: const EdgeInsets.all(20.0),
                            children: [
                              const Text(
                                  textAlign: TextAlign.left,
                                  'Please checking again your hired student and your require student on this project'),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(contexts).pop();
                                      },
                                      child: const Text('Close')),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      project.typeFlag = 1;
                      context
                          .read<CompanyProjectBloc>()
                          .add(CompanyProjectUpdate(projectUpdate: project));
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.archive),
                  title: Text('Archive Project'),
                  onTap: () {
                    project.typeFlag = 2;
                    context
                        .read<CompanyProjectBloc>()
                        .add(CompanyProjectUpdate(projectUpdate: project));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _getMap(int projectId, int initialDetailTab) {
    return {"projectId": projectId, "initialDetailTab": initialDetailTab};
  }
}
