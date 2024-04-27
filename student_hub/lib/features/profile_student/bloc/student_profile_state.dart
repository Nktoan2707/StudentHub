part of 'student_profile_bloc.dart';

abstract class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object> get props => [];
}

class StudentProfileInitial extends StudentProfileState {}

class StudentProfileFetchInProgress extends StudentProfileState {}

class StudentProfileFetchSuccess extends StudentProfileState {
  final StudentProfile studentProfile;
  final String? resumeUrl;
  final String? transcriptUrl;
  final List<TechStack> allTechStackList;
  final List<SkillSet> allSkillSetList;

  StudentProfileFetchSuccess(
      {required this.studentProfile,
      required this.resumeUrl,
      required this.transcriptUrl,
      required this.allTechStackList,
      required this.allSkillSetList});

  @override
  List<Object> get props => [studentProfile];
}

class StudentProfileFetchFailure extends StudentProfileState {}

class StudentProfileUpdateInProgress extends StudentProfileState {}

class StudentProfileUpdateSuccess extends StudentProfileState {}

class StudentProfileUpdateFailure extends StudentProfileState {}
