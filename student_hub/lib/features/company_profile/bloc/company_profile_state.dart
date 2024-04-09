// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  final User currentUser;

  CompanyProfileState({required this.currentUser});

  @override
  List<Object?> get props => [];
}

class CompanyProfileInitial extends CompanyProfileState {
  CompanyProfileInitial({required super.currentUser});
}

class CompanyProfilePutInProgress extends CompanyProfileState {
  CompanyProfilePutInProgress({required super.currentUser});
}

class CompanyProfilePutSuccess extends CompanyProfileState {
  final CompanyProfile? newestCompanyProfile;

  CompanyProfilePutSuccess({
    this.newestCompanyProfile,
    required super.currentUser,
  });

  @override
  List<Object?> get props => [newestCompanyProfile];

  @override
  String toString() =>
      "CompanyProfilePutSuccess { CompanyProfile: $newestCompanyProfile }";
}

class CompanyProfilePutFailure extends CompanyProfileState {
  CompanyProfilePutFailure({required super.currentUser});
}
