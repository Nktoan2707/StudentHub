import 'package:flutter/material.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/profile/pages/company_profile_input_page.dart';
import 'package:student_hub/features/profile/pages/student_profile_input_step_1_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar2.dart';

import '../../../widgets/components/top_navigation_bar.dart';

class SwitchAccountPage extends StatefulWidget {
  static const String pageId = "/SwitchAccountPage";

  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hai Pham"),
                    Text("Company"),
                  ],
                ),
                Icon(Icons.arrow_drop_up_outlined)
              ],
            ),
            const SizedBox(height: 10),

            const Divider(
              thickness: 2,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
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
                      Navigator.of(context).pushReplacementNamed(
                          CompanyProfileInputPage.pageId);
                    }
                    // Navigator.of(context).pushReplacementNamed(CompanyNotHaveProfileInputPage.pageId);
                    // Navigator.of(context).pushReplacementNamed(CompanyNotHaveProfileInputPage.pageId);
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
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
