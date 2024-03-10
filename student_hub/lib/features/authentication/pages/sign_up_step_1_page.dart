import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/login_page.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_2_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class SignUpStep1Page extends StatefulWidget {
  static const String pageId = "/SignUpStep1Page";

  const SignUpStep1Page({super.key});

  @override
  State<SignUpStep1Page> createState() => _SignUpStep1PageState();
}

class _SignUpStep1PageState extends State<SignUpStep1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Join as company or Student",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_box_rounded),
                    trailing: Checkbox(
                      shape: const CircleBorder(),
                      value: false,
                      onChanged: (value) {

                      },
                    ),
                    visualDensity: const VisualDensity(horizontal: -0, vertical: -4),
                    contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  ),
                  const Text("I am a company, find engineer for project")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_box_rounded),
                    trailing: Checkbox(
                      shape: const CircleBorder(),
                      value: false,
                      onChanged: (value) {

                      },
                    ),
                    visualDensity: const VisualDensity(horizontal: -0, vertical: -4),
                    contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  ),
                  const Text("I am a student, find project to experience")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _CreateAccountButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginPage.pageId);
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('signUpPageStep1_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(30),
              shape: const RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {
              Navigator.of(context).pushReplacementNamed(SignUpStep2Page.pageId);
            } : null,
            child: const Text('Create account'),
          );
  }
}
