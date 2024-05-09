import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/dashboard_student_accept_proposal/bloc/dashboard_student_accept_proposal_bloc.dart';
import 'package:student_hub/features/project_student/bloc/project_student_bloc.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';
import 'package:student_hub/features/project_student/pages/student_saved_project_list_page.dart';
import 'package:student_hub/features/submit_proposal_student/pages/student_submit_proposal_page.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';

class DashboardStudentAcceptPage extends StatefulWidget {
  static const String pageId = "/DashboardStudentAcceptPage";

  const DashboardStudentAcceptPage({super.key});

  @override
  State<DashboardStudentAcceptPage> createState() =>
      _DashboardStudentAcceptPageState();
}

class _DashboardStudentAcceptPageState
    extends State<DashboardStudentAcceptPage> {
  late Proposal proposal;

  @override
  Widget build(BuildContext context) {
    proposal = ModalRoute.of(context)?.settings.arguments as Proposal;

    return BlocListener<DashboardStudentAcceptProposalBloc,
        DashboardStudentAcceptProposalState>(
      listener: (context, state) {
        if (state is DashboardStudentAcceptAcceptSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Submit Proposal Success!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
           if (state is AuthenticationAuthenticateSuccess) {
            proposal.studentProfile = state.user.studentProfile;
           }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              title: const Text(
                'Offer Project',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              centerTitle: false,
              backgroundColor: Colors.grey,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            bottomNavigationBar: proposal.statusFlag == 2
                ? Container(
                    margin: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkCustomButton(
                          onTap: () {
                            _onAcceptButtonClicked();
                          },
                          title: "Accept Offer",
                          height: 50,
                          width: (MediaQuery.of(context).size.width / 3),
                        ),
                      ],
                    ),
                  )
                : null,
            body: Container(
              margin: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(proposal.project!.title),
                        const Divider(
                          thickness: 3,
                          height: 30,
                        ),
                        Text(proposal.project!.description),
                        const Divider(
                          thickness: 3,
                          height: 30,
                        ),
                        ListTile(
                          title: Text(
                              "Project Scope: \n \t \t - ${proposal.project!.projectScopeFlag}"),
                          leading: const Icon(Icons.timer_outlined),
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          title: Text(
                              "Student Required: \n \t \t - ${proposal.project!.numberOfStudents} students"),
                          leading: const Icon(Icons.people_rounded),
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAcceptButtonClicked() {
    proposal.statusFlag = 3;
    context
        .read<DashboardStudentAcceptProposalBloc>()
        .add(DashboardStudentAcceptProposalAccepted(proposal: proposal));
  }
}
