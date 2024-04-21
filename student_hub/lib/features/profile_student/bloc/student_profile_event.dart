part of 'student_profile_bloc.dart';

abstract class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object?> get props => [];
}

class StudentProfileFetched extends StudentProfileEvent {
  @override
  String toString() => 'StudentProfileFetched';
}

class StudentProfileUpdated extends StudentProfileEvent {
  final StudentProfile studentProfile;

  const StudentProfileUpdated({required this.studentProfile});

  @override
  String toString() => 'StudentProfileUpdated';
}
