import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project/components/custom_bottom_navigation_bar.dart';
import 'package:student_hub/features/project/components/student_project_list_item_view.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';
import 'package:student_hub/widgets/components/text_custom.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class StudentDashboardPage extends StatefulWidget {
  static const String pageId = "/StudentDashboardPage";

  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: const TopNavigationBar(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(title: 'Your Projects'),
              SizedBox(
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
                      gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.orangeAccent]),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent),
                  controller: _tabController,
                  tabs: const <Widget>[
                    Tab(text: 'All projects'), // Proposals
                    Tab(text: 'Working'), // Detail
                    Tab(text: 'Archived'), // Message
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Active Proposal (0)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return StudentProjectListItemView(
                                      project: projectList[index],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      color: Colors.grey,
                                      thickness: 3,
                                      height: 50,
                                    );
                                  },
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, style: BorderStyle.solid),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Active Proposal (0)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
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
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      color: Colors.grey,
                                      thickness: 3,
                                      height: 50,
                                    );
                                  },
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, style: BorderStyle.solid),
                            ),
                          ),
                        ],
                      ),
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
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.grey,
                          thickness: 3,
                          height: 50,
                        );
                      },
                    ),
                    const Center(child: Text('Archived')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
