part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationFetchInProgress extends NotificationState {}

class NotificationFetchSuccess extends NotificationState {
  final List<NotificationDetail> notificationList;

  NotificationFetchSuccess({required this.notificationList});


  @override
  List<Object> get props => [];
}

class NotificationFetchFailure extends NotificationState {}

class NotificationUpdateInProgress extends NotificationState {}

class NotificationUpdateSuccess extends NotificationState {}

class NotificationUpdateFailure extends NotificationState {}
