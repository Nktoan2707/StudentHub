import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class SignUpStep2Page extends StatefulWidget {
  static const String pageId = "/SignUpStep2Page";

  const SignUpStep2Page({super.key});

  @override
  State<SignUpStep2Page> createState() => _SignUpStep2PageState();
}

class _SignUpStep2PageState extends State<SignUpStep2Page> {
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
                "Sign up as Company",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const _Fullname(),
            const SizedBox(
              height: 10,
            ),
            const _WorkEmailAddress(),
            const SizedBox(
              height: 10,
            ),
            const _PassWordLimit(),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                _CheckBox(),
                Text("Yes, I understand and agree to StudentHub")
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                _CreateAccountButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Looking for a project?"),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Apply as student",
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

class _Fullname extends StatefulWidget {
  const _Fullname();

  @override
  State<_Fullname> createState() => _FullnameState();
}

class _FullnameState extends State<_Fullname> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signup_fullnameInput_textField'),
      onChanged: (fullname){},
      decoration: InputDecoration(
        labelText: "Fullname",
        errorText: false ?'invalid fullname': null,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
      ),
    );
  }
}

class _WorkEmailAddress extends StatefulWidget {
  const _WorkEmailAddress();

  @override
  State<_WorkEmailAddress> createState() => _WorkEmailAddressState();
}

class _WorkEmailAddressState extends State<_WorkEmailAddress> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signup_WorkEmailAddressInput_textField'),
      onChanged: (fullname){},
      decoration: InputDecoration(
        labelText: "Work Email Address",
        errorText: false ?'invalid email address': null,
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
      ), 
    );
  }
}

class _PassWordLimit extends StatefulWidget {
  const _PassWordLimit();

  @override
  State<_PassWordLimit> createState() => _PassWordLimitState();
}

class _PassWordLimitState extends State<_PassWordLimit> {
  bool _obscurePassword = true;
  bool _isValidPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signup_passwordInput_textField'),
      onChanged: (password) {
        setState(() {
          _isValidPassword = password.length >= 8;
        });
      },
      obscureText: _obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Password (8 or more characters)",
        errorText: false ? 'invalid password' : null,
        prefixIcon: const Icon(Icons.password_outlined),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: _obscurePassword
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _CheckBox extends StatefulWidget {
  const _CheckBox();

  @override
  State<_CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('signUpPageStep2_continue_raisedButton'),
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
            onPressed: true ? () {} : null,
            child: const Text('Create my account'),
          );
  }
}