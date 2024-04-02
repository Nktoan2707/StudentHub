import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/features/authentication/bloc/authentication_bloc.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/profile_company/pages/company_profile_input_page.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_1_page.dart';

import '../../../widgets/components/top_navigation_bar.dart';

class SwitchAccountPage extends StatefulWidget {
  static const String pageId = "/SwitchAccountPage";

  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  UserRole currentUserRole = UserRole.student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchProfile(),
            const Divider(
              thickness: 3,
              height: 10,
            ),

            // Vertical List
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text("Profile"),
                  onTap: () {
                    if (MainTabBarPage.userType == UserType.student) {
                      Navigator.of(context).pushReplacementNamed(
                          StudentProfileInputStep1Page.pageId);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(CompanyProfileInputPage.pageId);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Setting"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Log out"),
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLoggedOut());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchProfile() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // UserRole currentUserRole = (state as AuthenticationAuthenticateSuccess).userRole;

        List<UserRole> switchRoleFieldItems = UserRole.values.toList()
          ..remove(currentUserRole);

        return Column(
          children: [
            Ink(
              child: ListTile(
                leading: const Icon(Icons.account_box),
                title: const Text('Hai Pham'),
                subtitle: Text(
                  toBeginningOfSentenceCase(currentUserRole.name),
                ),
                onTap: () {},
              ),
            ),
            const Divider(
              thickness: 3,
              height: 10,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: switchRoleFieldItems.length,
              itemBuilder: (context, index) {
                return Ink(
                  child: ListTile(
                    leading: const Icon(Icons.switch_account),
                    title: const Text('Hai Pham'),
                    subtitle: Text(
                      toBeginningOfSentenceCase(
                          switchRoleFieldItems[index].name),
                    ),
                    onTap: () {
                      setState(() {
                        currentUserRole = switchRoleFieldItems[index];
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 3,
                  height: 10,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
