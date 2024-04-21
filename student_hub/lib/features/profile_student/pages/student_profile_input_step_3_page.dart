// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:student_hub/features/main_tab_bar_page.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';

class StudentProfileInputStep3Page extends StatefulWidget {
  static const String pageId = "/StudentProfileInputStep3Page";

  const StudentProfileInputStep3Page({super.key});

  @override
  State<StudentProfileInputStep3Page> createState() =>
      StudentProfileInputStep3State();
}

class StudentProfileInputStep3State
    extends State<StudentProfileInputStep3Page> {
  Map<String, dynamic> studentProfileMap = {
    'id': -1,
    'createdAt': "",
    'updatedAt': "",
    'deletedAt': null,
    'userId': -1,
    'techStackId': -1,
    'resume': 'resume_url',
    'transcript': 'transcript_url',
    'techStack': {},
    'proposals': [],
    'educations': [],
    'languages': [],
    'experiences': [],
    'skillSets': [],
  };

  String resumeUrl = "";
  String transcriptUrl = "";

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      studentProfileMap =
          (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);

      // print("DATA MAP: $studentProfileMap");
    }

    return Scaffold(
      appBar: const TopNavigationBar(),
      body: BlocConsumer<StudentProfileBloc, StudentProfileState>(
        listener: (context, state) {
          if (state is StudentProfileUpdateInProgress) {
          } else if (state is StudentProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Update Profile Success!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is StudentProfileUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to update profile'),
                backgroundColor: Colors.red,
              ),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        builder: (context, state) {
          if (state is StudentProfileFetchInProgress ||
              state is StudentProfileUpdateInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentProfileFetchSuccess) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const HeaderText(title: 'CV & Transcript'),
                    const SizedBox(
                      height: 20,
                    ),
                    const PrimaryText(
                        title:
                            'Tell us about yourself and you will be on your way to connect with real-world projects.'),
                    const SizedBox(
                      height: 20,
                    ),
                    const PrimaryText(title: 'Resume/CV (*)'),
                    FilePickerWidget(
                      onSelectedFileWithFilePath: (filePath) =>
                          didResumeSelectedFileWithFilePath(filePath),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const PrimaryText(title: 'Transcript (*)'),
                    FilePickerWidget(
                      onSelectedFileWithFilePath: (filePath) =>
                          didTranscriptSelectedFileWithFilePath(filePath),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: _buildNextButton(),
                    ),
                  ],
                ),
              ),
            );
          }
          return Placeholder();
        },
      ),
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
        studentProfileMap["resume"] = resumeUrl;
        studentProfileMap["transcript"] = transcriptUrl;

        context.read<StudentProfileBloc>().add(StudentProfileUpdated(
            studentProfile: StudentProfile.fromMap(studentProfileMap)));
      },
      child: const Text('Confirm'),
    );
  }

  void didResumeSelectedFileWithFilePath(String filePath) {
    resumeUrl = filePath;
  }

  void didTranscriptSelectedFileWithFilePath(String filePath) {
    transcriptUrl = filePath;
  }
}
