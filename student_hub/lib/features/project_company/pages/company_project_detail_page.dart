import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/message/components/tab_message_list_item_view.dart';
import 'package:student_hub/features/project_company/bloc/company_project_bloc.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/bloc/company_project_state.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class CompanyProjectDetailPage extends StatefulWidget {
  static const String pageId = "/ProjectDetailPage";

  const CompanyProjectDetailPage({super.key});

  @override
  State<CompanyProjectDetailPage> createState() =>
      _CompanyProjectDetailPageState();
}

class _CompanyProjectDetailPageState extends State<CompanyProjectDetailPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late Project project;
  late List<Proposal> proposals;
  late List<Proposal> listHired;
  bool isFirstLoad = true;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int projectId = (ModalRoute.of(context)?.settings.arguments as int);
    if (isFirstLoad) {
      context
          .read<CompanyProjectBloc>()
          .add(CompanyProjectGetDetail(projectId: projectId));
      isFirstLoad = false;
    }

    return BlocBuilder<CompanyProjectBloc, CompanyProjectState>(
      builder: (context, state) {
        if (state is CompanyProjectDetailFailure) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'StudentHub',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                centerTitle: false,
                backgroundColor: Colors.grey,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: const Center(
                child: Text(
                  "Error orcur. Please come back later",
                  textAlign: TextAlign.center,
                ),
              ));
        }

        if (state is! CompanyProjectDetailSuccess) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'StudentHub',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                centerTitle: false,
                backgroundColor: Colors.grey,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ));
        }

        project = state.project;
        proposals = state.project.proposals!;
        listHired = state.project.proposals!;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              'StudentHub',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            centerTitle: false,
            backgroundColor: Colors.grey,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Column(
              children: [
                HeaderText(title: project.title),
                TabBar(
                  controller: _tabController,
                  tabs: const <Widget>[
                    Tab(text: 'Proposals'), // Proposals
                    Tab(text: 'Detail'), // Detail
                    Tab(text: 'Message'), // Message
                    Tab(text: 'Hired'), // Hired
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      if (proposals.length == 0)
                        Center(
                          child: Text("Currently have no proposal"),
                        ),
                      if (proposals.length != 0)
                        ListView.builder(
                          itemCount: proposals.length,
                          itemBuilder: (context, index) {
                            Proposal proposal = proposals[index];

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(proposal.studentId.toString()),
                                    subtitle: const Text('4th year student'),
                                    leading: Image.network(
                                        'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg'),
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Full stack Engineer'),
                                      Text('Excellent')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(proposal.coverLetter),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkCustomButton(
                                        title: 'Message',
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                    2 -
                                                32,
                                        onTap: () {},
                                      ),
                                      InkCustomButton(
                                        title: 'Hire',
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                    2 -
                                                32,
                                        onTap: () {
                                          sentHiredButtonDidTap(index);
                                        },
                                      )
                                    ],
                                  ),
                                  const Divider(
                                      color: Colors.black,
                                      height: 50,
                                      thickness: 2),
                                ],
                              ),
                            );
                          },
                        ),
                      Column(
                        children: [
                          Divider(
                              color: Colors.black, height: 50, thickness: 2),
                          PrimaryText(title: project.description),
                          Divider(
                              color: Colors.black, height: 50, thickness: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.lock_clock,
                                size: 40,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Project scope:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  Text(
                                    '\t- ${getTimeTextProjectScope(project.projectScopeFlag)} students',
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 40,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student required:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                      '\t- ${project.numberOfStudents} students',
                                      textAlign: TextAlign.left)
                                ],
                              )
                            ],
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                    child: InkCustomButton(
                                      title: 'Post job',
                                      height: 40,
                                      width: 120,
                                    ),
                                  ))),
                        ],
                      ), // Detail content
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return const TabMessageListItemView();
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
                      if (listHired.length == 0)
                        Center(
                          child: Text("Currently have no hired"),
                        ),
                      if (listHired.length != 0)
                        ListView.builder(
                          itemCount: proposals.length,
                          itemBuilder: (context, index) {
                            Proposal proposal = proposals[index];

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(proposal.studentId.toString()),
                                    subtitle: const Text('4th year student'),
                                    leading: Image.network(
                                        'https://i.pinimg.com/originals/f9/64/2a/f9642a97146f7c952c3f929d8e557655.jpg'),
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Full stack Engineer'),
                                      Text('Excellent')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(proposal.coverLetter),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkCustomButton(
                                        title: 'Message',
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                    2 -
                                                32,
                                        onTap: () {},
                                      ),
                                      InkCustomButton(
                                        title: 'Hire',
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                    2 -
                                                32,
                                        onTap: () {
                                          sentHiredButtonDidTap(index);
                                        },
                                      )
                                    ],
                                  ),
                                  const Divider(
                                      color: Colors.black,
                                      height: 50,
                                      thickness: 2),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void sentHiredButtonDidTap(int id) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const HeaderText(title: 'Hired offer'),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          const Text(
              textAlign: TextAlign.left,
              'Do you really want to send hired offer for student to do this project?'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Send')),
            ],
          )
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
