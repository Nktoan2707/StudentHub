import 'package:flutter/material.dart';

class SignUpStep1Page extends StatefulWidget {
  const SignUpStep1Page({super.key});

  @override
  State<SignUpStep1Page> createState() => _SignUpStep1PageState();
}

class _SignUpStep1PageState extends State<SignUpStep1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'StudentHub',
          style: const TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Join as company or Student",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
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
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.account_box_rounded),
                    trailing: Checkbox(
                      shape: CircleBorder(),
                      value: false,
                      onChanged: (value) {

                      },
                    ),
                    visualDensity: VisualDensity(horizontal: -0, vertical: -4),
                    contentPadding: EdgeInsets.only(left: 0, right: 0),
                  ),
                  Text("I am a company, find engineer for project")
                ],
              ),
            ),
            SizedBox(
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
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.account_box_rounded),
                    trailing: Checkbox(
                      shape: CircleBorder(),
                      value: false,
                      onChanged: (value) {

                      },
                    ),
                    visualDensity: VisualDensity(horizontal: -0, vertical: -4),
                    contentPadding: EdgeInsets.only(left: 0, right: 0),
                  ),
                  Text("I am a student, find project to experience")
                ],
              ),
            ),
            SizedBox(
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
                        // Navigator.pushNamed(context, '/signup');
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
              minimumSize: Size.fromHeight(30),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {} : null,
            child: const Text('Create account'),
          );
  }
}
