// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProfileUpdate extends CompanyProfileEvent {
  final User user;
  CompanyProfileUpdate({
    required this.user
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProfileUpdate ${user.companyProfile.toString()}";
  }
}

class CompanyProfileFetch extends CompanyProfileEvent {
  final User user;
  CompanyProfileFetch({
    required this.user,
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProfileFetch ${user.companyProfile!.companyId}";
  }
}
