part of 'student_profile_bloc.dart';

abstract class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object> get props => [];
}

class StudentProfileInitial extends StudentProfileState {}

class StudentProfileUpdateInProgress extends StudentProfileState {}

class StudentProfileUpdateSuccess extends StudentProfileState {
  final StudentProfile student;

  const StudentProfileUpdateSuccess({required this.student});

  @override
  List<Object> get props => [student];
}

class StudentProfileUpdateFailure extends StudentProfileState {}
