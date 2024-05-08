import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/message/bloc/message_bloc.dart';
import 'package:student_hub/features/message/components/tab_message_list_item_view.dart';
import 'package:student_hub/features/message/pages/tab_message_detail_page.dart';
import 'package:student_hub/features/project_company/bloc/company_project_bloc.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/bloc/company_project_state.dart';
import 'package:student_hub/features/project_company/bloc/proposal/company_proposal_bloc.dart';
import 'package:student_hub/features/project_company/bloc/proposal/company_proposal_event.dart';
import 'package:student_hub/features/project_company/bloc/proposal/company_proposal_state.dart';
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
  late List<MessageContent> messageLists;
  late User userInfo;
  bool isFirstLoad = true;
  late MessageContent messageForNavigate;
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
    Map<String, dynamic> projectInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    int projectId = projectInfo['projectId'];
    int initialDetailTab = projectInfo['initialDetailTab'];
    _tabController.index = initialDetailTab;
    if (isFirstLoad) {
      context
          .read<CompanyProjectBloc>()
          .add(CompanyProjectGetDetail(projectId: projectId));
      context
          .read<CompanyProposalBloc>()
          .add(CompanyProposalListFetched(projectId: projectId));
      context
          .read<MessageBloc>()
          .add(MessageProjectListFetchEvent(projectId: projectId));
      isFirstLoad = false;
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is! AuthenticationAuthenticateSuccess) {
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

        userInfo = state.user;
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
            proposals = project.proposals!;
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
                          //Proposal
                          if (proposals.length == 0)
                            Center(
                              child: Text("Currently have no proposal"),
                            ),
                          if (proposals.length != 0)
                            BlocListener<CompanyProposalBloc,
                                CompanyProposalState>(
                              listener: (context, state) {
                                if (state
                                    is CompanyProposalStateUpdateSuccess) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Update status proposal successfully'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                }

                                if (state
                                    is CompanyProposalStateUpdateFailure) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Update status proposal fail'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                }
                              },
                              child: BlocBuilder<CompanyProposalBloc,
                                  CompanyProposalState>(
                                builder: (contextProposal, state) {
                                  if (state is! CompanyProposalStateSuccess) {
                                    contextProposal
                                        .read<CompanyProposalBloc>()
                                        .add(CompanyProposalListFetched(
                                            projectId: projectId));
                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                    ;
                                  }

                                  List<Proposal> proposalList = [];
                                  state.proposalList.every((element) {
                                    if (element.statusFlag != 3) {
                                      proposalList.add(element);
                                    }
                                    return true;
                                  });

                                  if (proposalList.isEmpty) {
                                    return Center(
                                      child: Text("Currently have no hired"),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: proposalList.length,
                                    itemBuilder: (context, index) {
                                      Proposal proposal = proposalList[index];

                                      StudentProfile student =
                                          proposal.studentProfile!;
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 4, 0, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                  student.user!.fullname,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                student.educations
                                                            .firstOrNull ==
                                                        null
                                                    ? "Anonymous"
                                                    : student
                                                        .educations
                                                        .firstOrNull!
                                                        .schoolName,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              leading: Image.network(
                                                  'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png'),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(student.techStack.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14)),
                                                Text('Excellent')
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(proposal.coverLetter),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text("Proposal Status:",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14)),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(getProposalStatusWithType(
                                                    proposal.statusFlag)),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            BlocBuilder<AuthenticationBloc,
                                                AuthenticationState>(
                                              builder: (context, state) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkCustomButton(
                                                      title: 'Message',
                                                      width: proposal.statusFlag ==
                                                              0
                                                          ? MediaQuery.sizeOf(
                                                                      context)
                                                                  .width -
                                                              48
                                                          : MediaQuery.sizeOf(
                                                                          context)
                                                                      .width /
                                                                  2 -
                                                              32,
                                                      onTap: () {
                                                        if (proposal
                                                                .statusFlag ==
                                                            0) {
                                                          makeActiveProposal(
                                                              proposal);
                                                        } else {
                                                          if (state
                                                              is AuthenticationAuthenticateSuccess) {
                                                            messageForNavigate =
                                                                MessageContent(
                                                              project: project,
                                                              me: state.user,
                                                              sender: User(
                                                                  id: proposal
                                                                      .studentProfile!
                                                                      .userId,
                                                                  fullname: proposal
                                                                      .studentProfile!
                                                                      .user!
                                                                      .fullname),
                                                              receiver: User(
                                                                  id: proposal
                                                                      .studentProfile!
                                                                      .userId,
                                                                  fullname: proposal
                                                                      .studentProfile!
                                                                      .user!
                                                                      .fullname),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    TabMessageDetailPage
                                                                        .pageId,
                                                                    arguments: {
                                                                  "messageInit":
                                                                      messageForNavigate
                                                                });
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    if (proposal.statusFlag !=
                                                        0)
                                                      InkCustomButton(
                                                        title: proposal
                                                                    .statusFlag ==
                                                                2
                                                            ? 'Sent hire offer'
                                                            : 'Hire',
                                                        width: MediaQuery.sizeOf(
                                                                        context)
                                                                    .width /
                                                                2 -
                                                            32,
                                                        onTap: () {
                                                          sentHiredButtonDidTap(
                                                              proposal);
                                                        },
                                                      )
                                                  ],
                                                );
                                              },
                                            ),
                                            const Divider(
                                                color: Colors.black,
                                                height: 50,
                                                thickness: 2),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          //Detail
                          Column(
                            children: [
                              Divider(
                                  color: Colors.black,
                                  height: 50,
                                  thickness: 2),
                              PrimaryText(title: project.description),
                              Divider(
                                  color: Colors.black,
                                  height: 50,
                                  thickness: 2),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              // Expanded(
                              //     child: Align(
                              //         alignment: Alignment.bottomRight,
                              //         child: Padding(
                              //           padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                              //           child: InkCustomButton(
                              //             title: 'Post job',
                              //             height: 40,
                              //             width: 120,
                              //           ),
                              //         ))),
                            ],
                          ), // Detail content
                          //Message
                          BlocBuilder<MessageBloc, MessageState>(
                            builder: (context, state) {
                              if (state is! MessageProjectListFetchSuccess) {
                                context.read<MessageBloc>().add(
                                    MessageProjectListFetchEvent(
                                        projectId: projectId));
                                return Center(
                                    child: const CircularProgressIndicator());
                                ;
                              }

                              messageLists = state.listMessage;
                              if (messageLists.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "There is 0 message in this project",
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: messageLists.length,
                                      itemBuilder: (context, index) {
                                        MessageContent messageContent =
                                            messageLists[index];
                                        return TabMessageListItemView(
                                            messageContent: messageContent);
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
                              );
                            },
                          ),
                          if (proposals.length == 0)
                            Center(
                              child: Text("Currently have no hired"),
                            ),
                          if (proposals.length != 0)
                            BlocBuilder<CompanyProposalBloc,
                                CompanyProposalState>(
                              builder: (contextProposal, state) {
                                if (state is! CompanyProposalStateSuccess) {
                                  contextProposal
                                      .read<CompanyProposalBloc>()
                                      .add(CompanyProposalListFetched(
                                          projectId: projectId));
                                  return Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                  ;
                                }

                                List<Proposal> proposalList = [];
                                state.proposalList.every((element) {
                                  if (element.statusFlag == 3) {
                                    proposalList.add(element);
                                  }
                                  return true;
                                });

                                if (proposalList.isEmpty) {
                                  return Center(
                                    child: Text("Currently have no hired"),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: proposalList.length,
                                  itemBuilder: (context, index) {
                                    Proposal proposal = proposalList[index];

                                    StudentProfile student =
                                        proposal.studentProfile!;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(student.user!.fullname,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            subtitle: Text(
                                              student.educations.firstOrNull ==
                                                      null
                                                  ? "Anonymous"
                                                  : student.educations
                                                      .firstOrNull!.schoolName,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            leading: Image.network(
                                                'https://cdn3.iconfinder.com/data/icons/incognito-avatars/154/incognito-face-user-man-avatar-512.png'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(student.techStack.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14)),
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
                                                    MediaQuery.sizeOf(context)
                                                            .width -
                                                        48,
                                                onTap: () {},
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
      },
    );
  }

  void makeActiveProposal(Proposal proposal) {
    showDialog(
      context: context,
      builder: (contextDialog) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<CompanyProposalBloc>(context),
          ),
          BlocProvider.value(
            value: BlocProvider.of<MessageBloc>(context),
          ),
        ],
        child: SimpleDialog(
          title: const HeaderText(title: 'Make contact'),
          contentPadding: const EdgeInsets.all(20.0),
          children: [
            const Text(
                textAlign: TextAlign.left,
                'Do you really want to make contact with this proposal'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(contextDialog).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      proposal.statusFlag = 1;
                      context.read<CompanyProposalBloc>().add(
                          CompanyProposalUpdated(updatedProposal: proposal));
                      context.read<MessageBloc>().add(MessageSentEvent(
                          messageSent: MessageSent(
                              projectId: 851,
                              content:
                                  "Hey, i want to make contact to you with project \"${project.title}\"",
                              senderId: userInfo.id,
                              receiverId: proposal.studentProfile!.userId,
                              messageFlag: 0)));
                      Navigator.of(contextDialog).pop();
                    },
                    child: const Text('Send')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void sentHiredButtonDidTap(Proposal proposal) {
    if (proposal.statusFlag == 1) {
      showDialog(
        context: context,
        builder: (dialogContext) => BlocProvider.value(
          value: BlocProvider.of<CompanyProposalBloc>(context),
          child: SimpleDialog(
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
                        proposal.statusFlag = 2;
                        context.read<CompanyProposalBloc>().add(
                            CompanyProposalUpdated(updatedProposal: proposal));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Send')),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (dialogContext) => BlocProvider.value(
          value: BlocProvider.of<CompanyProposalBloc>(context),
          child: SimpleDialog(
            title: const HeaderText(title: 'Sent hire offer'),
            contentPadding: const EdgeInsets.all(20.0),
            children: [
              const Text(
                  textAlign: TextAlign.left,
                  'You already sent hire offer for this proposal. Please wait for employee reply.'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close')),
                ],
              )
            ],
          ),
        ),
      );
    }
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

  String getProposalStatusWithType(int type) {
    switch (type) {
      case 0:
        return "Waiting";

      case 1:
        return "Active";

      case 2:
        return "Sent Offer";

      case 3:
        return "Working";

      default:
        return 'Unknown';
    }
  }
}
