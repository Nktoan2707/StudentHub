import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/login_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class HomePage extends StatefulWidget {
  static const String pageId = "/HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Build your product with high-skilled student",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                textAlign: TextAlign.center,
                "Find and onboard best-skilled student for your project. Student works to gain experience & skills from real-world projects",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 6),
                    color: Colors.black.withOpacity(1),
                  ),
                ],
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: InkWell(
                onTap: () {
                   MainTabBarPage.userType = UserType.company;
                  Navigator.of(context).pushReplacementNamed(LoginPage.pageId);
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Center(
                      child: Text(
                    "Company",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 6),
                    color: Colors.black.withOpacity(1),
                  ),
                ],
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: InkWell(
                onTap: () {
                  MainTabBarPage.userType = UserType.student;
                  Navigator.of(context).pushReplacementNamed(LoginPage.pageId);

                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Center(
                      child: Text(
                    "Student",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                textAlign: TextAlign.center,
                "StudentHub is university market place to connect high-skilled student and company on a real-world project",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


