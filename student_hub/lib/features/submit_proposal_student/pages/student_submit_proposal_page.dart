import 'package:flutter/material.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/features/submit_proposal_student/bloc/submit_proposal_student_bloc.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentSubmitProposalPage extends StatefulWidget {
  static const String pageId = "/StudentSubmitProposalPage";

  const StudentSubmitProposalPage({super.key});

  @override
  State<StudentSubmitProposalPage> createState() =>
      _StudentSubmitProposalPageState();
}

class _StudentSubmitProposalPageState extends State<StudentSubmitProposalPage> {
  final TextEditingController _textEditingControllerCoverLetter =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    int projectId = ModalRoute.of(context)?.settings.arguments as int;

    return BlocListener<SubmitProposalStudentBloc, SubmitProposalStudentState>(
      listener: (context, state) {
        if (state is SubmitProposalStudentPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Submit Proposal Success!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else if (state is SubmitProposalStudentPostFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Submit Proposal Failed!'),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Submit Proposal',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          centerTitle: false,
          backgroundColor: Colors.grey,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cover letter",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Describe why do you fit to this project"),
              const SizedBox(
                height: 20,
              ),
              TextField(
                minLines: 1,
                maxLines: 10,
                controller: _textEditingControllerCoverLetter,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkCustomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: "Cancel",
                    height: 25,
                    width: (MediaQuery.of(context).size.width / 2.7),
                  ),
                  InkCustomButton(
                    onTap: () {
                      context.read<SubmitProposalStudentBloc>().add(
                          SubmitProposalStudentSubmitted(
                              projectId: projectId,
                              coverLetter:
                                  _textEditingControllerCoverLetter.text));
                    },
                    title: "Submit proposal",
                    height: 25,
                    width: (MediaQuery.of(context).size.width / 2.7),
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
