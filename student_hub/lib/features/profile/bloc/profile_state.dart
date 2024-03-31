part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileUpdateInProgress extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final Student student;

  const ProfileUpdateSuccess({required this.student});

  @override
  List<Object> get props => [student];
}

class ProfileUpdateFailure extends ProfileState {}
