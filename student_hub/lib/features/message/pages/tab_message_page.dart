import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/features/message/bloc/message_bloc.dart';
import 'package:student_hub/features/message/components/tab_message_list_item_view.dart';
import 'package:student_hub/features/project_student/pages/student_searched_project_list_page.dart';

class TabMessagePage extends StatefulWidget {
  static const String pageId = "/TabMessagePage";

  const TabMessagePage({super.key});

  @override
  State<TabMessagePage> createState() => _TabMessagePageState();
}

class _TabMessagePageState extends State<TabMessagePage> {
  late List<MessageContent> messageLists = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is MessageProjectListFetchSuccess) {
          messageLists = state.listMessage
            ..sort((a, b) {
              return a.createdAt!.microsecondsSinceEpoch >= b.createdAt!.microsecondsSinceEpoch ?  0 : 1;
            });
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            body: SingleChildScrollView(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              // onSubmitted: (value) {
                              //   // Perform search functionality here
                              //   // context.read<TodoBloc>().add(TodoSearched(searchedString: value));
                              // },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 3,
                  ),
                  if (state is MessageProjectListFetchSuccess && messageLists.isEmpty)
                    const Center(
                      child: Text(
                        "You haven't contact with anyone",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (!messageLists.isEmpty)
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: messageLists.length,
                            itemBuilder: (context, index) {
                              MessageContent messageContent =
                                  messageLists[index];
                              return TabMessageListItemView(
                                  messageContent: messageContent);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                color: Colors.grey,
                                thickness: 3,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _searchItem() {
    Navigator.of(context).pushNamed(StudentSearchedProjectListPage.pageId);
  }
}
