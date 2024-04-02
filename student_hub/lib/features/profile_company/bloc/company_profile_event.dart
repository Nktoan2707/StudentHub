// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProfileUpdate extends CompanyProfileEvent {
  final CompanyProfile updateProfile;
  CompanyProfileUpdate({
    required this.updateProfile,
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProfileUpdate ${updateProfile.toString()}";
  }
}

class CompanyProfileFetch extends CompanyProfileEvent {
  final int id;
  CompanyProfileFetch({
    required this.id,
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProfileFetch $id";
  }
}
