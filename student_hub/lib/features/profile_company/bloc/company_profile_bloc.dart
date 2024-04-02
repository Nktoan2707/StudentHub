import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/company_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:student_hub/features/profile_student/bloc/student_profile_bloc.dart';

part 'company_profile_event.dart';

part 'company_profile_state.dart';

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final CompanyRepository _companyRepository;

  CompanyProfileBloc({
    required CompanyRepository companyRepository,
  })  : _companyRepository = companyRepository,
        super(CompanyProfileStateInitial()) {
    on<CompanyProfileUpdate>(_onCompanyProfileUpdate);
    on<CompanyProfileFetch>(_onCompanyProfileFetch);
  }

  FutureOr<void> _onCompanyProfileUpdate(
      CompanyProfileUpdate event, Emitter<CompanyProfileState> emit) {
    emit(CompanyProfileStateInProgress());
    try {
      _companyRepository
          .updateCompanyProfile(event.updateProfile)
          .then((value) {
        if (!(value as bool)) {
          emit(CompanyProfileStateFailure());
          return;
        }
        emit(CompanyProfileStateSuccess());
      });
    } catch (e) {
      emit(CompanyProfileStateFailure());
    }
  }

  FutureOr<void> _onCompanyProfileFetch(
      CompanyProfileFetch event, Emitter<CompanyProfileState> emit) {
    emit(CompanyProfileStateInProgress());

    try {
      _companyRepository.getCompanyProfile(event.id).then((value) {
        if (value is CompanyProfile) {
          emit(CompanyProfileStateFailure());
          return;
        }
        emit(CompanyProfileStateSuccess(newestCompanyProfile: value));
      });
    } catch (e) {
      emit(CompanyProfileStateFailure());
    }
  }
}
