import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/notification_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/notification_detail.dart';

import '../../../data/models/domain/student_profile.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  NotificationBloc({required NotificationRepository notificationRepository,
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository})
      : _notificationRepository = notificationRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(NotificationInitial()) {
    on<NotificationFetched>(_onNotificationFetched);
    on<NotificationUpdated>(_onNotificationUpdated);
  }

  Future<FutureOr<void>> _onNotificationFetched(NotificationFetched event,
      Emitter<NotificationState> emit) async {
    emit(NotificationFetchInProgress());
    try {
      final List<NotificationDetail> notificationList = await
      _notificationRepository.getNotificationListByUserId(
          token: _authenticationRepository.token,
          user: await _userRepository
              .getCurrentUser(_authenticationRepository.token));

      emit(NotificationFetchSuccess(notificationList: notificationList));
    } catch (e) {
      emit(NotificationFetchFailure());
      rethrow;
    }
  }

  Future<void> _onNotificationUpdated(NotificationUpdated event,
      Emitter<NotificationState> emit) async {
    emit(NotificationUpdateInProgress());
    try {
      await _notificationRepository.markReadNotificationById(
          notificationId: event.notificationId,
          token: _authenticationRepository.token);
      emit(NotificationUpdateSuccess());
      add(NotificationFetched());
    } catch (e) {
      emit(NotificationUpdateFailure());
      add(NotificationFetched());
      rethrow;
    }
  }
}
