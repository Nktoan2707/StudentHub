import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/message_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:student_hub/data/models/domain/user.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final MessageRepository _messageRepository;

  MessageBloc(
      {required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository,
      required MessageRepository messageRepository})
      : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        _messageRepository = messageRepository,
        super(MessageInitial()) {
    on<MessageProjectListFetchEvent>(_onMessageProjectListFetchEventd);
    on<MessageSentEvent>(_onMessageSentEvent);
    on<MessageGetListOfUserEvent>(_onMessageGetListOfUserEvent);
    on<MessageGetListOfMeEvent>(_onMessageGetListOfMeEvent);
    on<MessageInterviewSentEvent>(_onMessageInterviewSentEvent);
  }

  FutureOr<void> _onMessageProjectListFetchEventd(
      MessageProjectListFetchEvent event, Emitter<MessageState> emit) async {
    User currentUser =
        await _userRepository.getCurrentUser(_authenticationRepository.token);

    try {
      await _messageRepository
          .getListMessageOfProject(
              user: currentUser,
              projectId: event.projectId,
              token: _authenticationRepository.token)
          .then((value) {
        if (value is! List) {
          emit(MessageProjectListFetchFail());
          return;
        }
        emit(MessageProjectListFetchSuccess(listMessage: value!));
      });
    } catch (e) {
      print(e);
      emit(MessageProjectListFetchFail());
    }
  }

  FutureOr<void> _onMessageSentEvent(
      MessageSentEvent event, Emitter<MessageState> emit) async {
    try {
      await _messageRepository
          .sendMessage(
              messageSent: event.messageSent,
              token: _authenticationRepository.token)
          .then((value) {
        if (value is! List) {
          emit(MessageProjectMakeContactFail());
          return;
        }
        emit(MessageProjectMakeContactSuccess());
      });
    } catch (e) {
      print(e);
      emit(MessageProjectMakeContactFail());
    }
  }

  FutureOr<void> _onMessageGetListOfUserEvent(
      MessageGetListOfUserEvent event, Emitter<MessageState> emit) async {
    emit(MessageInprogress());
    User currentUser =
        await _userRepository.getCurrentUser(_authenticationRepository.token);

    try {
      await _messageRepository
          .getListMessageOfUser(
              userid: event.userId,
              me: currentUser,
              projectId: event.projectId,
              token: _authenticationRepository.token)
          .then((value) {
        if (value is! List) {
          emit(MessageProjectListFetchFail());
          return;
        }
        emit(MessageProjectListFetchSuccess(listMessage: value!));
      });
    } catch (e) {
      print(e);
      emit(MessageProjectListFetchFail());
    }
  }

  FutureOr<void> _onMessageGetListOfMeEvent(
      MessageGetListOfMeEvent event, Emitter<MessageState> emit) async {
    emit(MessageInprogress());
    User currentUser =
        await _userRepository.getCurrentUser(_authenticationRepository.token);
    try {
      await _messageRepository
          .getListMessageOfMe(
              me: currentUser, token: _authenticationRepository.token)
          .then((value) {
        if (value is! List) {
          emit(MessageProjectListFetchFail());
          return;
        }
        emit(MessageProjectListFetchSuccess(listMessage: value!));
      });
    } catch (e) {
      print(e);
      emit(MessageProjectListFetchFail());
    }
  }

  FutureOr<void> _onMessageInterviewSentEvent(MessageInterviewSentEvent event, Emitter<MessageState> emit) async {
    try {
      await _messageRepository
          .sendInterview(
              interviewSent: event.interviewSent,
              token: _authenticationRepository.token)
          .then((value) {
        if (value is! List) {
          emit(MessageProjectMakeContactFail());
          return;
        }
        emit(MessageProjectMakeContactSuccess());
      });
    } catch (e) {
      print(e);
      emit(MessageProjectMakeContactFail());
    }
  }
}
