import 'dart:math';
import 'package:flutter/material.dart';
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
class ProfileInputStep2 extends StatefulWidget {
  const ProfileInputStep2({super.key});

  @override
  State<ProfileInputStep2> createState() => _ProfileInputStep2State();
}

class _ProfileInputStep2State extends State<ProfileInputStep2> {
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
              child: Text('Experiences'),
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
                    const Text("Project"),
                    Spacer(),
                    Icon(Icons.add),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    const Text("Intelligent Taxi Dispatching system"),
                    Spacer(),
                    Icon(Icons.edit),
                    Icon(Icons.delete_sharp),
                  ],
                ),
                Row(
                  children: [
                    const Text("9/2020 - 12/2020, 4 months"),
                  ],
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    const Text("It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, .."),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text("Skillset"),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                       SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(100, 21, 18, 18),
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
                        _selectedSkillset == null || _selectedSkillset.isEmpty
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
                  ]
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("Intelligent Taxi Dispatching system"),
                    Spacer(),
                    Icon(Icons.edit),
                    Icon(Icons.delete_sharp),
                  ],
                ),
                Row(
                  children: [
                    const Text("9/2020 - 12/2020, 4 months"),
                  ],
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    const Text("It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, .."),
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
            SizedBox(height: 10,),
            
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

class Multi_select_skillset extends StatefulWidget {
  const Multi_select_skillset({super.key});

  @override
  State<Multi_select_skillset> createState() => _Multi_select_skillsetState();
}

class _Multi_select_skillsetState extends State<Multi_select_skillset> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}