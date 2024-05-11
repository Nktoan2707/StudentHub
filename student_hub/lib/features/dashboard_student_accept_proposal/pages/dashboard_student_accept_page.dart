import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
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
                        Text(
                      proposal.project!.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 3,
                      height: 30,
                    ),
                    Text(
                      proposal.project!.description,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 3,
                      height: 30,
                    ),
                    ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: 'Project Scope: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n \t \t - ${getTimeTextProjectScope(proposal.project!.projectScopeFlag)}',
                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      leading: const Icon(Icons.timer_outlined),
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: 'Student Required: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n \t \t - ${proposal.project!.numberOfStudents} students',
                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
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
