import 'package:flutter/material.dart';
import 'package:student_hub/features/authentication/pages/sign_up_step_1_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class LoginPage extends StatefulWidget {
  static const String pageId = "/LoginPage";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                "Login with StudentHub",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            _UsernameInput(),
            const SizedBox(height: 10),
            const _PasswordInput(),
            const SizedBox(height: 60),
            Column(
              children: [
                _LoginButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SignUpStep1Page.pageId);
                      },
                      child: const Text(
                        "Signup",
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

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) {},
      decoration: InputDecoration(
        labelText: "Username",
        errorText: false ? 'invalid username' : null,
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

class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {},
      obscureText: _obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Password",
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

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(200, 40),
              shape: const RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {
              Navigator.pushReplacementNamed(context, MainTabBarPage.pageId);
            } : null,
            child: const Text('Sign In'),
          );
  }
}
