part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationFetchInProgress extends NotificationState {}

class NotificationFetchSuccess extends NotificationState {
  final StudentProfile studentProfile;
  final String? resumeUrl;
  final String? transcriptUrl;
  final List<TechStack> allTechStackList;
  final List<SkillSet> allSkillSetList;

  NotificationFetchSuccess(
      {required this.studentProfile,
      required this.resumeUrl,
      required this.transcriptUrl,
      required this.allTechStackList,
      required this.allSkillSetList});

  @override
  List<Object> get props => [studentProfile];
}

class NotificationFetchFailure extends NotificationState {}

class NotificationUpdateInProgress extends NotificationState {}

class NotificationUpdateSuccess extends NotificationState {}

class NotificationUpdateFailure extends NotificationState {}
