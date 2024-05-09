part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationFetched extends NotificationEvent {
  @override
  String toString() => 'NotificationFetched';
}

class NotificationUpdated extends NotificationEvent {
  final int notificationId;

  const NotificationUpdated({required this.notificationId});

  @override
  String toString() => 'NotificationUpdated';
}
