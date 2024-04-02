import 'package:flutter/material.dart';
import 'package:student_hub/features/message/pages/tab_message_page.dart';
import 'package:student_hub/features/notification/pages/notification_page.dart';
import 'package:student_hub/features/project_company/pages/company_dashboard_page.dart';
import 'package:student_hub/features/project_student/pages/student_dashboard_page.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

enum UserType { student, company }

class MainTabBarPage extends StatefulWidget {
  static const String pageId = "/MainTabBarPage";
  static UserType userType = UserType.student;

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
      body: IndexedStack(
        index: _currentIndex,
        children: [
          if (MainTabBarPage.userType == UserType.company) ...[
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
      ),
    );
  }

  void postJobButtonDidTap() {}
}
