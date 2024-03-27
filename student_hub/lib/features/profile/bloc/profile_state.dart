part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {

}


class ProfileUpdateInProgress extends ProfileState {

}


class ProfileUpdateSuccess extends ProfileState {

}

class ProfileUpdateFailure extends ProfileState {

}