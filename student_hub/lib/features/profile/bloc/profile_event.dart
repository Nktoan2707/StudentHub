part of 'profile_bloc.dart';


abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileUpdated extends ProfileEvent {


  @override
  String toString() {
    return "LoginLoggedIn {}";
  }
}