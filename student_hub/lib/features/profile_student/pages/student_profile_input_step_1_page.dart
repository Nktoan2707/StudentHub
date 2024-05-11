import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_2_page.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class StudentProfileInputStep1Page extends StatefulWidget {
  static const String pageId = "/StudentProfileInputStep1Page";

  const StudentProfileInputStep1Page({super.key});

  @override
  State<StudentProfileInputStep1Page> createState() =>
      _StudentProfileInputStep1PageState();
}

class _StudentProfileInputStep1PageState
    extends State<StudentProfileInputStep1Page> {
  Map<String, dynamic> studentProfileMap = {
    'id': -1,
    'createdAt': "",
    'updatedAt': "",
    'deletedAt': null,
    'userId': -1,
    'techStackId': -1,
    'resume': null,
    'transcript': null,
    'techStack': {},
    'proposals': [],
    'educations': [],
    'languages': [],
    'experiences': [],
    'skillSets': [],
  };

  late TechStack _selectedTechStack;
  List<SkillSet> _listSkillSet = List<SkillSet>.empty(growable: true);
  List<Language> _listLanguage = List<Language>.empty(growable: true);
  List<Education> _listEducation = List<Education>.empty(growable: true);
  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: BlocConsumer<StudentProfileBloc, StudentProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is StudentProfileFetchInProgress) {
            isFirstLoad = true;
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentProfileFetchSuccess) {
            final skillSetItemList = state.allSkillSetList
                .map((skillSet) =>
                    MultiSelectItem<SkillSet>(skillSet, skillSet.name))
                .toList();

            if (isFirstLoad) {
              _selectedTechStack = state.allTechStackList.firstWhere(
                  (element) => element.id == state.studentProfile.techStackId);
              _listSkillSet =
                  state.allSkillSetList.where((allSkillSetListElement) {
                return state.studentProfile.skillSets.any(
                    (thisExperienceSkillSetElement) =>
                        thisExperienceSkillSetElement.id ==
                        allSkillSetListElement.id);
              }).toList();
              _listLanguage = state.studentProfile.languages.toList();
              _listEducation = state.studentProfile.educations.toList();
              isFirstLoad = false;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Welcome to Student Hub',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      "Tell us about your self and you will be on your way connect with real-world project"),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("TechStack"),
                  DropdownMenu<TechStack>(
                    initialSelection: _selectedTechStack,
                    onSelected: (TechStack? value) {
                      _selectedTechStack = value!;
                    },
                    dropdownMenuEntries:
                        state.allTechStackList.map((TechStack techStack) {
                      return DropdownMenuEntry<TechStack>(
                          value: techStack, label: techStack.name);
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("SkillSet"),
                  Column(
                    children: [
                      MultiSelectBottomSheetField(
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: const Text("List of selected skill set(s)"),
                        title: const Text("SkillSet"),
                        items: skillSetItemList,
                        initialValue: _listSkillSet,
                        onConfirm: (values) {
                          setState(() {
                            _listSkillSet = values.cast();
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(100, 21, 18, 18),
                              width: 2,
                            ),
                          ),
                          onTap: (value) {
                            // setState(() {});
                          },
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(100, 21, 18, 18),
                            width: 2,
                          ),
                        ),
                      ),
                      if (_listSkillSet.isEmpty)
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(100, 21, 18, 18)),
                              bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(100, 21, 18, 18)),
                              right: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(100, 21, 18, 18)),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Language"),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SizedBox(
                                height: 22,
                                width: 22,
                                child: IconButton.outlined(
                                    padding: EdgeInsets.zero,
                                    iconSize: 17,
                                    onPressed: () {
                                      _displayInputDialogLanguage(context,
                                          onInputFinished: (language) {
                                        setState(() {
                                          _listLanguage.add(language);
                                        });
                                      });
                                    },
                                    icon: Icon(Icons.add)),
                              ),
                            ),
                          ],
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listLanguage.length,
                          itemBuilder: (context, index) {
                            return _ListItemViewLanguage(
                                language: _listLanguage[index],
                                onDeletePressed: () {
                                  setState(() {
                                    _listLanguage.removeAt(index);
                                  });
                                },
                                onEditPressed: () {
                                  _displayInputDialogLanguage(context,
                                      language: _listLanguage[index],
                                      onInputFinished: (language) {
                                    setState(() {
                                      _listLanguage[index] = language;
                                    });
                                  });
                                });
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              color: Colors.grey,
                              thickness: 3,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Education"),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SizedBox(
                                height: 22,
                                width: 22,
                                child: IconButton.outlined(
                                    padding: EdgeInsets.zero,
                                    iconSize: 17,
                                    onPressed: () {
                                      _displayInputDialogEducation(
                                        context,
                                        onInputFinished: (education) {
                                          setState(() {
                                            _listEducation.add(education);
                                          });
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.add)),
                              ),
                            ),
                          ],
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listEducation.length,
                          itemBuilder: (context, index) {
                            return _ListItemViewEducation(
                                education: _listEducation[index],
                                onDeletePressed: () {
                                  setState(() {
                                    _listEducation.removeAt(index);
                                  });
                                },
                                onEditPressed: () {
                                  _displayInputDialogEducation(context,
                                      education: _listEducation[index],
                                      onInputFinished: (education) {
                                    setState(() {
                                      _listEducation[index] = education;
                                    });
                                  });
                                });
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              color: Colors.grey,
                              thickness: 3,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildNextButton(),
                  ),
                ],
              ),
            );
          } else {
            return Placeholder();
          }
        },
      ),
    );
  }

  Future<void> _displayInputDialogLanguage(BuildContext context,
      {Language? language,
      required void Function(Language) onInputFinished}) async {
    final TextEditingController languageNameTextFieldController =
        TextEditingController(
            text: language == null ? "" : language.languageName);

    final TextEditingController languageLevelTextFieldController =
        TextEditingController(text: language == null ? "" : language.level);

    String test = "a";   

    String? getLanguageNameErrorText() {
      if (languageNameTextFieldController.text.isEmpty) {
        return "This field can not be empty";
      }
      return null;
    }

    String? getLevelErrorText() {
      if (languageNameTextFieldController.text.isEmpty) {
        return "This field can not be empty";
      }

      return null;
    }

    bool isInputValid() {
      return getLanguageNameErrorText() == null && getLevelErrorText() == null;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AlertDialog(
            // title: Text('TextField in Dialog'),
            content: SingleChildScrollView(
              // padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        size: 25,
                      ),
                      // constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    language == null ? "Add Language" : "Edit Language",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Divider(
                    thickness: 3,
                    height: 40,
                  ),
                  const Text(
                    "Language",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    controller: languageNameTextFieldController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      errorText: getLanguageNameErrorText(),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Level",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    controller: languageLevelTextFieldController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      errorText: getLanguageNameErrorText(),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkCustomButton(
                title: "Cancel",
                padding: 5,
                width: MediaQuery.of(context).size.width * 0.3,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              InkCustomButton(
                title: language == null ? "Add" : "Confirm",
                padding: 5,
                width: MediaQuery.of(context).size.width * 0.3,
                onTap: isInputValid()
                    ? () {
                        onInputFinished(Language(
                          id: -1,
                          createdAt: "",
                          updatedAt: "",
                          deletedAt: null,
                          studentId: -1,
                          languageName: languageNameTextFieldController.text,
                          level: languageLevelTextFieldController.text,
                        ));
                        Navigator.pop(context);
                      }
                    : () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                      });
                    },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _displayInputDialogEducation(BuildContext context,
      {Education? education,
      required void Function(Education) onInputFinished}) async {
    final TextEditingController schoolNameTextFieldController =
        TextEditingController(
            text: education == null ? "" : education.schoolName);

    final TextEditingController startYearTextFieldController =
        TextEditingController(
            text: education == null ? "" : education.startYear.toString());

    final TextEditingController endYearTextFieldController =
        TextEditingController(
            text: education == null ? "" : education.endYear.toString());

    String? getEndYearErrorText() {
      if (endYearTextFieldController.text.isEmpty) {
        return "End year can not be empty";
      }
      if (startYearTextFieldController.text.isNotEmpty &&
          int.parse(endYearTextFieldController.text) <=
              (int.parse(startYearTextFieldController.text))) {
        return 'End year must be larger than start year!';
      }

      return null;
    }

    String? getStartYearErrorText() {
      if (startYearTextFieldController.text.isEmpty) {
        return "Start year can not be empty";
      }

      return null;
    }

    Future<void> selectYear(BuildContext context,
        {required TextEditingController textController}) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select Year"),
            content: Container(
              // Need to use container to add size constraint.
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year),
                selectedDate: DateTime.now(),
                onChanged: (DateTime dateTime) {
                  // close the dialog when year is selected.
                  textController.text = dateTime.year.toString();
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      );
    }

    String? getSchoolNameErrorText() {
      return schoolNameTextFieldController.text.isEmpty
          ? "This field can not be empty"
          : null;
    }

    bool isInputValid() {
      return getSchoolNameErrorText() == null &&
          getStartYearErrorText() == null &&
          getEndYearErrorText() == null;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AlertDialog(
            // title: Text('TextField in Dialog'),
            content: SingleChildScrollView(
              // padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        size: 25,
                      ),
                      // constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    education == null ? "Add Education" : "Edit education",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Divider(
                    thickness: 3,
                    height: 40,
                  ),
                  const Text(
                    "School's name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    controller: schoolNameTextFieldController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      errorText: getSchoolNameErrorText(),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: startYearTextFieldController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        prefixIcon: Icon(Icons.calendar_month),
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: "Start Year",
                        errorText: getStartYearErrorText(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                    readOnly: true,
                    onTap: () {
                      selectYear(context,
                          textController: startYearTextFieldController);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: endYearTextFieldController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.calendar_month),
                      filled: true,
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      labelText: "End Year",
                      errorText: getEndYearErrorText(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      selectYear(context,
                          textController: endYearTextFieldController);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkCustomButton(
                title: "Cancel",
                padding: 5,
                width: MediaQuery.of(context).size.width * 0.3,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              InkCustomButton(
                title: education == null ? "Add" : "Confirm",
                padding: 5,
                width: MediaQuery.of(context).size.width * 0.3,
                onTap: isInputValid()
                    ? () {
                        onInputFinished(Education(
                            id: -1,
                            createdAt: "",
                            updatedAt: "",
                            deletedAt: null,
                            studentId: -1,
                            schoolName: schoolNameTextFieldController.text,
                            startYear:
                                int.parse(startYearTextFieldController.text),
                            endYear:
                                int.parse(endYearTextFieldController.text)));
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      key: const Key('studentProfileForm_next_raisedButton'),
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
      onPressed: () {
        studentProfileMap["techStackId"] = _selectedTechStack.id;
        studentProfileMap["techStack"] = _selectedTechStack.toMap();
        studentProfileMap["languages"] =
            _listLanguage.map((e) => e.toMap()).toList();
        studentProfileMap["educations"] =
            _listEducation.map((e) => e.toMap()).toList();
        studentProfileMap["skillSets"] =
            _listSkillSet.map((e) => e.toMap()).toList();

        Navigator.of(context).pushNamed(StudentProfileInputStep2Page.pageId,
            arguments: studentProfileMap);
      },
      child: const Text('Next'),
    );
  }
}

class _ListItemViewLanguage extends StatelessWidget {
  final Language language;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const _ListItemViewLanguage(
      {super.key,
      required this.language,
      required this.onDeletePressed,
      required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -0, vertical: -4),
      contentPadding: const EdgeInsets.only(left: 0, right: 0),
      title: Text("${language.languageName}: ${language.level}"),
      titleAlignment: ListTileTitleAlignment.center,
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 22,
              width: 22,
              child: IconButton.outlined(
                  padding: EdgeInsets.zero,
                  iconSize: 17,
                  onPressed: () {
                    onEditPressed();
                  },
                  icon: Icon(Icons.edit)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 22,
              width: 22,
              child: IconButton.outlined(
                  padding: EdgeInsets.zero,
                  iconSize: 17,
                  onPressed: () {
                    onDeletePressed();
                  },
                  icon: Icon(Icons.delete)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListItemViewEducation extends StatelessWidget {
  final Education education;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const _ListItemViewEducation(
      {super.key,
      required this.education,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -0, vertical: -4),
      contentPadding: const EdgeInsets.only(left: 0, right: 0),
      title: Text(education.schoolName),
      subtitle: Text("${education.startYear}-${education.endYear}"),
      titleAlignment: ListTileTitleAlignment.center,
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 22,
              width: 22,
              child: IconButton.outlined(
                  padding: EdgeInsets.zero,
                  iconSize: 17,
                  onPressed: () {
                    onEditPressed();
                  },
                  icon: Icon(Icons.edit)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 22,
              width: 22,
              child: IconButton.outlined(
                  padding: EdgeInsets.zero,
                  iconSize: 17,
                  onPressed: () {
                    onDeletePressed();
                  },
                  icon: Icon(Icons.delete)),
            ),
          ),
        ],
      ),
    );
  }
}
