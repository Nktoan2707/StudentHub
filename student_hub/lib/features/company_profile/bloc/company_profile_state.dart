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

// Profile Input
class CompanyProfileInputInProgress extends CompanyProfileState {
  CompanyProfileInputInProgress({required super.currentUser});
}

class CompanyProfileInputSuccess extends CompanyProfileState {
  final CompanyProfile newestCompanyProfile;

  CompanyProfileInputSuccess({
    required this.newestCompanyProfile,
    required super.currentUser,
  });

  @override
  List<Object?> get props => [newestCompanyProfile];

  @override
  String toString() =>
      "CompanyProfileInputSuccess { CompanyProfile: $newestCompanyProfile }";
}

class CompanyProfileInputFailure extends CompanyProfileState {
  CompanyProfileInputFailure({required super.currentUser});
}


//Profile Fetch
class CompanyProfileFetchInprogress extends CompanyProfileState {
  CompanyProfileFetchInprogress({required super.currentUser});
}

class CompanyProfileFetchSuccess extends CompanyProfileState {
  final CompanyProfile newestCompanyProfile;

  CompanyProfileFetchSuccess({
    required this.newestCompanyProfile,
    required super.currentUser,
  });

  @override
  List<Object?> get props => [newestCompanyProfile];

  @override
  String toString() =>
      "CompanyProfileFetchSuccess { CompanyProfile: $newestCompanyProfile }";
}

class CompanyProfileFetchNoProFile extends CompanyProfileState {
  CompanyProfileFetchNoProFile({required super.currentUser});
}

class CompanyProfileFetchNetworkFailure extends CompanyProfileState {
  CompanyProfileFetchNetworkFailure({required super.currentUser});
}

