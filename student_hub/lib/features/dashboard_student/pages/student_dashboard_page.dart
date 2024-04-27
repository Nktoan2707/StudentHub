import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/dashboard_student/bloc/dashboard_student_bloc.dart';
import 'package:student_hub/features/dashboard_student/bloc/dashboard_student_bloc.dart';
import 'package:student_hub/features/dashboard_student/components/student_proposal_list_item_view.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';
import 'package:student_hub/widgets/components/text_custom.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class StudentDashboardPage extends StatefulWidget {
  static const String pageId = "/StudentDashboardPage";

  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage>
    with TickerProviderStateMixin {
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
    return BlocBuilder<DashboardStudentBloc, DashboardStudentState>(
      builder: (context, state) {
        if (state is DashboardStudentFetchSuccess) {
          List<Proposal> listProposalNew = state.proposalList
              .where((element) => element.project!.typeFlag == 0)
              .toList();
          List<Proposal> listProposalWorking = state.proposalList
              .where((element) =>
                  element.project!.typeFlag == 1 && element.statusFlag == 3)
              .toList();
          List<Proposal> listProposalArchived = state.proposalList
              .where((element) => element.project!.typeFlag == 2)
              .toList();

          List<Proposal> listProposalWaiting = listProposalNew
              .where((element) => element.statusFlag == 0)
              .toList();
          List<Proposal> listProposalActive = listProposalNew
              .where((element) => element.statusFlag == 1)
              .toList();
          List<Proposal> listProposalOffer = listProposalNew
              .where((element) => element.statusFlag == 2)
              .toList();
          List<Proposal> listProposalHired = listProposalNew
              .where((element) => element.statusFlag == 3)
              .toList();

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderText(title: 'Your Projects'),
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
                          Tab(text: 'All projects'), // Proposals
                          Tab(text: 'Working'), // Detail
                          Tab(text: 'Archived'), // Message
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
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hired Proposal (${listProposalHired.length})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listProposalHired.length,
                                        itemBuilder: (context, index) {
                                          return StudentProposalListItemView(
                                            proposal: listProposalHired[index],
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Offer Proposal (${listProposalOffer.length})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listProposalOffer.length,
                                        itemBuilder: (context, index) {
                                          return StudentProposalListItemView(
                                            proposal: listProposalOffer[index],
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Active Proposal (${listProposalActive.length})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listProposalActive.length,
                                        itemBuilder: (context, index) {
                                          return StudentProposalListItemView(
                                            proposal: listProposalActive[index],
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Waiting Proposal (${listProposalWaiting.length})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listProposalWaiting.length,
                                        itemBuilder: (context, index) {
                                          return StudentProposalListItemView(
                                            proposal:
                                                listProposalWaiting[index],
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listProposalWorking.length,
                            itemBuilder: (context, index) {
                              return StudentProposalListItemView(
                                proposal: listProposalWorking[index],
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
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listProposalArchived.length,
                            itemBuilder: (context, index) {
                              return StudentProposalListItemView(
                                proposal: listProposalArchived[index],
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is DashboardStudentFetchInProgress) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Placeholder();
        }
      },
    );
  }
}
