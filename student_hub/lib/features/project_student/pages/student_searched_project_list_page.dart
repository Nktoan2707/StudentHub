import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/project_student/components/student_project_list_item_view.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';

class StudentSearchedProjectListPage extends StatefulWidget {
  static const String pageId = "/StudentSearchedProjectListPage";

  const StudentSearchedProjectListPage({super.key});

  @override
  State<StudentSearchedProjectListPage> createState() =>
      _StudentSearchedProjectListPageState();
}

class _StudentSearchedProjectListPageState
    extends State<StudentSearchedProjectListPage> {
  List<Project> projectList = List.from([], growable: true);

  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Project Search',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          centerTitle: false,
          backgroundColor: Colors.grey,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: [
            SlidingUpPanel(
              backdropEnabled: true,
              isDraggable: false,
              minHeight: panelHeightClosed,
              maxHeight: panelHeightOpen,
              parallaxEnabled: false,
              parallaxOffset: 0.5,
              renderPanelSheet: false,
              controller: panelController,
              panelBuilder: (scrollController) => _FilterFloatingPanel(
                panelController: panelController,
              ),
              collapsed: null,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Autocomplete<String>(
                            optionsBuilder: (textEditingValue) {
                              // return const Iterable<String>.empty();

                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }

                              return Iterable<String>.generate(
                                  10, (index) => "test$index");
                            },
                            displayStringForOption: (value) => value,
                            optionsViewBuilder: (context, onSelected, options) {
                              return Material(
                                elevation: 4,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: options.toList().length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () =>
                                          onSelected(options.toList()[index]),
                                      // contentPadding: EdgeInsets.zero,
                                      title: Text(options.toList()[index]),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 3,
                                      height: 20,
                                    );
                                  },
                                ),
                              );
                            },
                            onSelected: (String value) {
                              _searchItem();
                            },
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                onEditingComplete: onFieldSubmitted,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                                // onSubmitted: (value) {
                                //   // Perform search functionality here
                                //   // context.read<TodoBloc>().add(TodoSearched(searchedString: value));
                                // },
                              );
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _filterPanelToggle(true);
                            },
                            icon: const Icon(
                              Icons.filter_alt,
                              size: 35,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 3,
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        return StudentProjectListItemView(
                          project: projectList[index],
                        );
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
            ),
          ],
        ),
      ),
    );
  }

  void _searchItem() {
    Navigator.of(context).pushNamed(StudentSearchedProjectListPage.pageId);
  }
  void _filterPanelToggle(bool toggle) {
    toggle ? panelController.open() : panelController.close();
  }
}

class _FilterFloatingPanel extends StatefulWidget {
  final PanelController panelController;

  const _FilterFloatingPanel({required this.panelController});

  @override
  State<_FilterFloatingPanel> createState() => _FilterFloatingPanelState();
}

class _FilterFloatingPanelState extends State<_FilterFloatingPanel> {
  int? selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.panelController.close();
              },
              icon: const FaIcon(FontAwesomeIcons.circleXmark),
              constraints: const BoxConstraints(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Filter By",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 3,
              height: 40,
            ),
            const Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 30),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            ListTile(
              title: const Text('Less than one month'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: 1,
                groupValue: selectedOption,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('1 to 3 months'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: 2,
                groupValue: selectedOption,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('3 to 6 months'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: 3,
                groupValue: selectedOption,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('More than 6 months'),
              contentPadding: EdgeInsets.zero,
              leading: Radio<int>(
                value: 4,
                groupValue: selectedOption,
                activeColor: Colors.red,
                // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Colors.red),
                // Change the fill color when selected
                splashRadius: 20,
                // Change the splash radius when clicked
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Students needed",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 30),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            const Text(
              "Proposals less than",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 30),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkCustomButton(
                  title: "Clear Filters",
                  padding: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                InkCustomButton(
                  title: "Apply",
                  padding: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
