import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:student_hub/features/login/pages/login_page.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/signup/bloc/signup_bloc.dart';
import 'package:student_hub/features/signup/pages/sign_up_choose_role_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class SignUpAsStudentPage extends StatefulWidget {
  static const String pageId = "/SignUpAsStudentPage";

  const SignUpAsStudentPage({super.key});

  @override
  State<SignUpAsStudentPage> createState() => _SignUpAsStudentPageState();
}

class _SignUpAsStudentPageState extends State<SignUpAsStudentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Signup Failed...')),
            );
        } else if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Signup Successful!')),
            );
        }
      },
      child: Scaffold(
        appBar: const TopNavigationBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Sign up as Student',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const _UsernameInput(),
              const SizedBox(
                height: 10,
              ),
              const _WorkEmailAddressInput(),
              const SizedBox(
                height: 10,
              ),
              const _PasswordInput(),
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
                      const Text("Looking for a student to hire?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUpChooseRolePage.pageId);
                        },
                        child: const Text(
                          "Apply as company",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatefulWidget {
  const _UsernameInput();

  @override
  State<_UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<_UsernameInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpAsStudentPage_usernameInput_textField'),
          onChanged: (fullName) {},
          decoration: InputDecoration(
            labelText: "Username",
            errorText:
                state.username.displayError != null ? 'invalid username' : null,
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}

class _WorkEmailAddressInput extends StatefulWidget {
  const _WorkEmailAddressInput();

  @override
  State<_WorkEmailAddressInput> createState() => _WorkEmailAddressInputState();
}

class _WorkEmailAddressInputState extends State<_WorkEmailAddressInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      // buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpAsStudentPage_workEmailAddressInput_textField'),
          onChanged: (fullName) {},
          decoration: InputDecoration(
            labelText: "Work Email Address",
            errorText: false ? 'invalid email address' : null,
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpAsStudentPage_passwordInput_textField'),
          obscureText: _obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: "Password (8 or more characters)",
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
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
      },
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
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpAsStudentPage_continue_raisedButton'),
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
                onPressed: state.isValid
                    ? () {
                        context.read<SignupBloc>().add(SignupSignedUp());
                      }
                    : null,
                child: const Text('Create my account'),
              );
      },
    );
  }
}
