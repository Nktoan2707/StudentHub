import 'dart:math';

import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

const List<String> list = <String>['FullStack Engineer'];
class ProfileInputStep1 extends StatefulWidget {
  const ProfileInputStep1({super.key});

  @override
  State<ProfileInputStep1> createState() => _ProfileInputStep1State();
}

class _ProfileInputStep1State extends State<ProfileInputStep1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Center(
              child: Text('Welcome to Student Hub'),
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Tell us about your self and you will be on your way connect with real-world project"),
              ]
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  children: [
                    const Text("Techstack"),
                  ],
                  ),
                Row(
                  children: [
                    DropdownMenuExample(),
                  ],
                ),
              ]
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  children: [
                    const Text("Skillset"),

                  ],
                ),
                Row(
                  children: [
                   //Multi_select_skillset
                  ],
                ),
              ]
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  children: [
                    const Text("Language"),
                    Spacer(),
                    Icon(Icons.add),
                    Icon(Icons.edit),
                  ],
                ),
                Row(
                  children: [
                    const Text("English: Native or Bilingual"),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("Education"),
                    Spacer(),
                    Icon(Icons.add),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    const Text("Le Hong Phong High School"),
                    Spacer(),
                    Icon(Icons.edit),
                    Icon(Icons.delete_sharp),
                  ],
                ),
                Row(
                  children: [
                    const Text("2008-2010"),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    const Text("Ho Chi Minh University of Sciences"),
                    Spacer(),
                    Icon(Icons.edit),
                    Icon(Icons.delete_sharp),
                  ],
                ),
                Row(
                  children: [
                    const Text("2010-2014"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: nextButton(),
                    ),
                  ],
                ),
              ]
            ),
          ]
          
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class nextButton extends StatefulWidget {
  const nextButton({super.key});

  @override
  State<nextButton> createState() => _nextButtonState();
}

class _nextButtonState extends State<nextButton> {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('profileForm_Next_raisedButton'),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: Size(200, 40),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {} : null,
            child: const Text('Next'),
          );
  }
}