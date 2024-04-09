
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_2_page.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class Skillset {
  final int id;
  final String name;

  Skillset({
    required this.id,
    required this.name,
  });
}

const List<String> list = <String>['FullStack Engineer'];

class StudentProfileInputStep1Page extends StatefulWidget {
  static const String pageId = "/StudentProfileInputStep1Page";

  const StudentProfileInputStep1Page({super.key});

  @override
  State<StudentProfileInputStep1Page> createState() => _StudentProfileInputStep1PageState();
}

class _StudentProfileInputStep1PageState extends State<StudentProfileInputStep1Page> {
  static final List<Skillset> _skillset = [
    Skillset(id: 1, name: "NodeJS"),
    Skillset(id: 2, name: "Swift"),
    Skillset(id: 3, name: "Objective C"),
    Skillset(id: 4, name: "C/C++"),
    Skillset(id: 5, name: "Java"),
    Skillset(id: 6, name: "Python"),
    Skillset(id: 7, name: "Golang"),
    Skillset(id: 8, name: "React"),
    Skillset(id: 9, name: "React Native"),
    Skillset(id: 10, name: "Flutter"),
    Skillset(id: 11, name: "MySQL"),
    Skillset(id: 12, name: "SQLite"),
    Skillset(id: 13, name: "PostgreSQL"),
    Skillset(id: 14, name: "AWS")
  ];

  final _items = _skillset
      .map((animal) => MultiSelectItem<Skillset>(animal, animal.name))
      .toList();

  List<Skillset> _selectedSkillset = [];

  Map<String, dynamic> studentProfile = {
  'id': 1,
  'createdAt': ,
  'updatedAt': ,
  'deletedAt': ,
  'userId': ,
  'techStackId': ,
  'resume': ,
  'transcript': ,
  'techStack': ,
  'proposals': ,
  'educations': ,
  'languages': ,
  'experiences': ,
  'skillSets': ,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: BlocListener<StudentProfileBloc, StudentProfileState>(
        listener: (context, state) {
          if (state is StudentProfileUpdateInProgress) {
          } else if (state is StudentProfileUpdateSuccess) {
            Navigator.of(context).pushReplacementNamed(StudentProfileInputStep2Page.pageId);
          } else if (state is StudentProfileUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to update profile'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text('Welcome to Student Hub'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                  "Tell us about your self and you will be on your way connect with real-world project"),
            ]),
            const SizedBox(
              height: 10,
            ),
            const Column(children: [
              Row(
                children: [
                  Text("Techstack"),
                ],
              ),
              Row(
                children: [
                  DropdownMenuExample(),
                ],
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Column(children: [
              const Row(
                children: [
                  Text("Skillset"),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(100, 21, 18, 18),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          MultiSelectBottomSheetField(
                            initialChildSize: 0.4,
                            listType: MultiSelectListType.CHIP,
                            searchable: true,
                            buttonText: const Text("List of selected Skillsets"),
                            title: const Text("Skillset"),
                            items: _items,
                            onConfirm: (values) {
                              _selectedSkillset = values.cast();
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              onTap: (value) {
                                setState(() {
                                  _selectedSkillset.remove(value);
                                });
                              },
                            ),
                          ),
                          _selectedSkillset.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            const Column(children: [
              Row(
                children: [
                  Text("Language"),
                  Spacer(),
                  Icon(Icons.add),
                  Icon(Icons.edit),
                ],
              ),
              Row(
                children: [
                  Text("English: Native or Bilingual"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Education"),
                  Spacer(),
                  Icon(Icons.add),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("Le Hong Phong High School"),
                  Spacer(),
                  Icon(Icons.edit),
                  Icon(Icons.delete_sharp),
                ],
              ),
              Row(
                children: [
                  Text("2008-2010"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("Ho Chi Minh University of Sciences"),
                  Spacer(),
                  Icon(Icons.edit),
                  Icon(Icons.delete_sharp),
                ],
              ),
              Row(
                children: [
                  Text("2010-2014"),
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
            ]),
          ]),
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
          studentProfile["techStack"] = value!;
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
              minimumSize: const Size(200, 40),
              shape: const RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {
              Navigator.of(context).pushReplacementNamed(StudentProfileInputStep2Page.pageId);

            } : null,
            child: const Text('Next'),
          );
  }
}
