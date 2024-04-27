import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/dashboard_student/bloc/dashboard_student_bloc.dart';
import 'package:student_hub/features/message/pages/tab_message_page.dart';
import 'package:student_hub/features/notification/pages/notification_page.dart';
import 'package:student_hub/features/project_company/bloc/company_project_bloc.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/pages/company_dashboard_page.dart';
import 'package:student_hub/features/dashboard_student/pages/student_dashboard_page.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class MainTabBarPage extends StatefulWidget {
  static const String pageId = "/MainTabBarPage";

  const MainTabBarPage({super.key});

  @override
  State<MainTabBarPage> createState() => _MainTabBarPageState();
}

class _MainTabBarPageState extends State<MainTabBarPage> {
  int itemCount = 1;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      bottomNavigationBar: HUBBottomNavigationBar(
        onSelectedIndexPath: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticateSuccess) {
            context.read<DashboardStudentBloc>().add(DashboardStudentFetched());
            context
        .read<CompanyProjectBloc>()
        .add(CompanyProjectListFetch(typeFlag: -1));
            return IndexedStack(
              index: _currentIndex,
              children: [
                if (state.userRole == UserRole.company) ...[
                  const StudentProjectListPage(),
                  const CompanyDashboardPage(),
                  const TabMessagePage(),
                  const NotificationPage(),
                ] else ...[
                  const StudentProjectListPage(),
                  const StudentDashboardPage(),
                  const TabMessagePage(),
                  const NotificationPage(),
                ],
              ],
            );
          }
          return Placeholder();
        },
      ),
    );
  }

  void postJobButtonDidTap() {}
}
