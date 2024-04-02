import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/features/login/pages/login_page.dart';
import 'package:student_hub/features/signup/bloc/signup_bloc.dart';
import 'package:student_hub/features/signup/pages/sign_up_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class SignUpChooseRolePage extends StatefulWidget {
  static const String pageId = "/SignUpChooseRolePage";

  const SignUpChooseRolePage({super.key});

  @override
  State<SignUpChooseRolePage> createState() => _SignUpChooseRolePageState();
}

class _SignUpChooseRolePageState extends State<SignUpChooseRolePage> {
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
              child: BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.account_box_rounded),
                        trailing: Checkbox(
                          shape: const CircleBorder(),
                          value: state.userRole == UserRole.company,
                          onChanged: (value) {
                            if (value == true) {
                              context
                                  .read<SignupBloc>()
                                  .add(SignupUserRoleChosen(UserRole.company));
                            }
                          },
                        ),
                        visualDensity:
                            const VisualDensity(horizontal: -0, vertical: -4),
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 0),
                      ),
                      const Text("I am a company, find engineer for project")
                    ],
                  );
                },
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
              child: BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.account_box_rounded),
                        trailing: Checkbox(
                          shape: const CircleBorder(),
                          value: state.userRole == UserRole.student,
                          onChanged: (value) {
                            context
                                .read<SignupBloc>()
                                .add(SignupUserRoleChosen(UserRole.student));
                          },
                        ),
                        visualDensity:
                            const VisualDensity(horizontal: -0, vertical: -4),
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 0),
                      ),
                      const Text("I am a student, find project to experience")
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _CreateAccountButton(onPressed: () {
                  _onCreateButtonPressed();
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginPage.pageId);
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

  void _onCreateButtonPressed() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.pageId);
  }
}

class _CreateAccountButton extends StatelessWidget {
  final Function onPressed;

  const _CreateAccountButton({required this.onPressed});

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
            onPressed: true
                ? () async {
                    onPressed();
                  }
                : null,
            child: const Text('Create account'),
          );
  }
}
