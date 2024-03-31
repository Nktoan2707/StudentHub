part of 'student_profile_bloc.dart';


abstract class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();
  @override
  List<Object?> get props => [];
}

class StudentProfileUpdated extends StudentProfileEvent {
  const StudentProfileUpdated();

  @override
  String toString() => 'StudentProfileUpdated';
}