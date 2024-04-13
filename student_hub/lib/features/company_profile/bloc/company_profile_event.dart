// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProfileUpdated extends CompanyProfileEvent {
  final CompanyProfile companyProfile;

  CompanyProfileUpdated({required this.companyProfile});

  @override
  String toString() {
    return "[EVENT] CompanyProfileUpdated ${companyProfile.toString()}";
  }
}

class CompanyProfileCreated extends CompanyProfileEvent {
  final CompanyProfile companyProfile;

  CompanyProfileCreated({required this.companyProfile});

  @override
  String toString() {
    return "[EVENT] CompanyProfileCreated ${companyProfile.toString()}";
  }
}

class CompanyProfileFetched extends CompanyProfileEvent {
  @override
  String toString() {
    return "[EVENT] CompanyProfileFetched";
  }
}

class CompanyProfileResetState extends CompanyProfileEvent {
  @override
  String toString() {
    return "[EVENT] CompanyProfileResetState";
  }
}

