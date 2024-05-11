import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';
import 'package:student_hub/features/profile_student/pages/student_profile_input_step_3_page.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

const List<String> list = <String>['FullStack Engineer'];

class StudentProfileInputStep2Page extends StatefulWidget {
  static const String pageId = "/StudentProfileInputStep2Page";

  const StudentProfileInputStep2Page({super.key});

  @override
  State<StudentProfileInputStep2Page> createState() =>
      _StudentProfileInputStep2PageState();
}

class _StudentProfileInputStep2PageState
    extends State<StudentProfileInputStep2Page> {
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

  List<Experience> _listExperience = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      studentProfileMap =
          (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
    }

    return Scaffold(
      appBar: const TopNavigationBar(),
      body: BlocConsumer<StudentProfileBloc, StudentProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is StudentProfileFetchInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentProfileFetchSuccess) {
            _listExperience = state.studentProfile.experiences;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Experiences',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "Tell us about your self and you will be on your way connect with real-world project"),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Projects", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                      _displayInputDialogExperience(
                                        context,
                                        onInputFinished: (experience) {
                                          setState(() {
                                            _listExperience.add(experience);
                                          });
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.add)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listExperience.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Nền màu trắng cho từng mục
                                border: Border.all(
                                  color: Colors.grey, // Màu của viền
                                  width: 1.0, // Độ dày của viền
                                ),
                                borderRadius: BorderRadius.circular(10), // Làm tròn góc của Container
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12), // Khoảng cách từng mục
                              padding: const EdgeInsets.all(8), // Khoảng cách từ viền của Container tới nội dung bên trong
                              child: _ListItemViewExperience(
                                experience: _listExperience[index],
                                onDeletePressed: () {
                                  setState(() {
                                    _listExperience.removeAt(index);
                                  });
                                },
                                onEditPressed: () {
                                  _displayInputDialogExperience(context,
                                      experience: _listExperience[index],
                                      onInputFinished: (experience) {
                                    setState(() {
                                      _listExperience[index] = experience;
                                    });
                                  });
                                }
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 8); // Khoảng cách giữa các mục
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
          }

          return Placeholder();
        },
      ),
    );
  }

  Future<void> _displayInputDialogExperience(BuildContext context,
      {Experience? experience,
      required void Function(Experience) onInputFinished}) async {
    final TextEditingController titleTextFieldController =
        TextEditingController(text: experience == null ? "" : experience.title);

    final TextEditingController startMonthTextFieldController =
        TextEditingController(
            text: experience == null ? "" : experience.startMonth.toString());

    final TextEditingController endMonthTextFieldController =
        TextEditingController(
            text: experience == null ? "" : experience.endMonth.toString());

    final TextEditingController descriptionTextFieldController =
        TextEditingController(
            text: experience == null ? "" : experience.description);

    List<SkillSet> _listSkillSet = List<SkillSet>.empty(growable: true);

    String? getEndTimeErrorText() {
      if (startMonthTextFieldController.text.isEmpty) {
        return null;
      }

      int differenceInMonths(DateTime date1, DateTime date2) {
        int yearsDiff = date2.year - date1.year;
        int monthsDiff = date2.month - date1.month;
        return (yearsDiff * 12) + monthsDiff;
      }

      if (endMonthTextFieldController.text.isEmpty) {
        return "End Time can not be empty";
      }

      DateFormat dateFormat = DateFormat("MM-yyyy");
      if (differenceInMonths(
              dateFormat.parse(startMonthTextFieldController.text),
              dateFormat.parse(endMonthTextFieldController.text)) <=
          0) {
        return 'End Time must be larger than Start Time!';
      }

      return null;
    }

    String? getStartTimeErrorText() {
      if (startMonthTextFieldController.text.isEmpty) {
        return "Start time can not be empty";
      }

      return null;
    }

    Future<void> selectMonthYear(BuildContext context,
        {required TextEditingController textController}) async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2200));

      if (pickedDate != null) {
        textController.text = pickedDate
            .toString()
            .split(" ")[0]
            .substring(0, 7)
            .split("-")
            .reversed
            .join("-");
      }
    }

    String? getTitleErrorText() {
      return titleTextFieldController.text.isEmpty
          ? "Title can not be empty"
          : null;
    }

    String? getDescriptionErrorText() {
      return descriptionTextFieldController.text.isEmpty
          ? "Description can not be empty"
          : null;
    }

    bool isInputValid() {
      return getTitleErrorText() == null &&
          getStartTimeErrorText() == null &&
          getEndTimeErrorText() == null &&
          getDescriptionErrorText() == null;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (contextDialog) {
        return Dialog(
          // backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: BlocProvider.value(
            value: context.read<StudentProfileBloc>(),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(contextDialog).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(contextDialog);
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
                      experience == null
                          ? "Add Project Experience"
                          : "Edit Project Experience",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Divider(
                      thickness: 3,
                      height: 40,
                    ),
                    const Text(
                      "Project Name/Title",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.digitsOnly,
                      // ],
                      controller: titleTextFieldController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        errorText: getTitleErrorText(),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: startMonthTextFieldController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          prefixIcon: Icon(Icons.calendar_month),
                          filled: true,
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          labelText: "Start Time",
                          errorText: getStartTimeErrorText(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                      readOnly: true,
                      onTap: () {
                        selectMonthYear(contextDialog,
                            textController: startMonthTextFieldController);
                        FocusScope.of(contextDialog).unfocus();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: endMonthTextFieldController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        prefixIcon: Icon(Icons.calendar_month),
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: "End Time",
                        errorText: getEndTimeErrorText(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        selectMonthYear(contextDialog,
                            textController: endMonthTextFieldController);
                        FocusScope.of(contextDialog).unfocus();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Description",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      maxLines: null,
                      controller: descriptionTextFieldController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        errorText: getDescriptionErrorText(),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("SkillSet"),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<StudentProfileBloc, StudentProfileState>(
                      builder: (context, state) {
                        if (state is StudentProfileFetchInProgress) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is StudentProfileFetchSuccess) {
                          final skillSetItemList = state.allSkillSetList
                              .map((skillSet) => MultiSelectItem<SkillSet>(
                                  skillSet, skillSet.name))
                              .toList();

                          if (experience != null) {
                            for (var allSkillSetListElement
                                in state.allSkillSetList) {
                              if (experience.skillSets.any(
                                  (thisExperienceSkillSetElement) =>
                                      thisExperienceSkillSetElement.id ==
                                      allSkillSetListElement.id)) {
                                _listSkillSet.add(allSkillSetListElement);
                              }
                            }
                          }

                          return Column(
                            children: [
                              MultiSelectBottomSheetField(
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                searchable: true,
                                buttonText:
                                    const Text("List of selected skill set(s)"),
                                title: const Text("SkillSet"),
                                items: skillSetItemList,
                                initialValue: _listSkillSet,
                                onConfirm: (values) {
                                  _listSkillSet = values.cast();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(100, 21, 18, 18),
                                      width: 2,
                                    ),
                                  ),
                                  onTap: (value) {
                                    // setState(() {});
                                  },
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(100, 21, 18, 18),
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
                                          color:
                                              Color.fromARGB(100, 21, 18, 18)),
                                      bottom: BorderSide(
                                          width: 2,
                                          color:
                                              Color.fromARGB(100, 21, 18, 18)),
                                      right: BorderSide(
                                          width: 2,
                                          color:
                                              Color.fromARGB(100, 21, 18, 18)),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                )
                            ],
                          );
                        }

                        return Placeholder();
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(contextDialog).size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkCustomButton(
                          title: "Cancel",
                          padding: 5,
                          width: MediaQuery.of(contextDialog).size.width * 0.3,
                          onTap: () {
                            Navigator.pop(contextDialog);
                          },
                        ),
                        InkCustomButton(
                          title: experience == null ? "Add" : "Confirm",
                          padding: 5,
                          width: MediaQuery.of(contextDialog).size.width * 0.3,
                          onTap: isInputValid()
                              ? () {
                                  onInputFinished(
                                    Experience(
                                        id: -1,
                                        createdAt: "",
                                        updatedAt: "",
                                        deletedAt: null,
                                        studentId: -1,
                                        title: titleTextFieldController.text,
                                        startMonth:
                                            startMonthTextFieldController.text,
                                        endMonth:
                                            endMonthTextFieldController.text,
                                        description:
                                            descriptionTextFieldController.text,
                                        skillSets: _listSkillSet),
                                  );
                                  Navigator.pop(contextDialog);
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
        studentProfileMap["experiences"] =
            _listExperience.map((e) => e.toMap()).toList();

        Navigator.of(context).pushNamed(StudentProfileInputStep3Page.pageId,
            arguments: studentProfileMap);
      },
      child: const Text('Next'),
    );
  }
}

class _ListItemViewExperience extends StatelessWidget {
  final Experience experience;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const _ListItemViewExperience(
      {super.key,
      required this.experience,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    final skillSetItemList = experience.skillSets
        .map((skillSet) => MultiSelectItem<SkillSet>(skillSet, skillSet.name))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -0, vertical: -4),
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          title: Text(experience.title),
          subtitle: Text(_getFormattedDuration()),
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
        ),
        Text(
          experience.description,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text("SkillSet"),
        SizedBox(
          height: 20,
        ),
        skillSetItemList.isNotEmpty
            ? MultiSelectChipDisplay<SkillSet>(
                items: skillSetItemList,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(100, 21, 18, 18),
                    width: 2,
                  ),
                ),
                onTap: (value) {
                  // setState(() {});
                },
              )
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(100, 21, 18, 18),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
              )
      ],
    );
  }

  String _getFormattedDuration() {
    int differenceInMonths(DateTime date1, DateTime date2) {
      int yearsDiff = date2.year - date1.year;
      int monthsDiff = date2.month - date1.month;
      return ((yearsDiff * 12) + monthsDiff).abs();
    }

    String formattedStartMonthYear = experience.startMonth.split("-").join("/");
    String formattedEndMonthYear = experience.endMonth.split("-").join("/");

    DateFormat dateFormat = DateFormat("MM-yyyy");
    String durationMonth =
        "${differenceInMonths(dateFormat.parse(experience.startMonth), dateFormat.parse(experience.endMonth))} month(s)";

    return "${formattedStartMonthYear} - ${formattedEndMonthYear}, $durationMonth";
  }
}
