// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProfileStateInitial extends CompanyProfileState {

}


class CompanyProfileStateInProgress extends CompanyProfileState {

}

class CompanyProfileStateSuccess extends CompanyProfileState {
  CompanyProfile? newestCompanyProfile;
  CompanyProfileStateSuccess({
    this.newestCompanyProfile = null,
  });

   @override
  List<Object?> get props => [newestCompanyProfile];

  @override
  String toString() => "CompanyProfileStateSuccess { Company: $newestCompanyProfile }";
}

class CompanyProfileStateFailure extends CompanyProfileState {

}