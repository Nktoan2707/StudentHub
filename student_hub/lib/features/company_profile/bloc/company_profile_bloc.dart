import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/company_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:student_hub/data/models/domain/user.dart';

part 'company_profile_event.dart';

part 'company_profile_state.dart';

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final CompanyRepository _companyRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  CompanyProfileBloc(
      {required CompanyRepository companyRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _companyRepository = companyRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(CompanyProfileInitial(currentUser: User.empty)) {
    on<CompanyProfileUpdated>(_onCompanyProfileUpdated);
    on<CompanyProfileFetched>(_onCompanyProfileFetched);

  }

  Future<FutureOr<void>> _onCompanyProfileUpdated(
      CompanyProfileUpdated event, Emitter<CompanyProfileState> emit) async {
    emit(CompanyProfilePutInProgress(
        currentUser: await _userRepository
            .getCurrentUser(_authenticationRepository.token)));
    try {
      _companyRepository
          .updateCompanyProfile(
              companyProfile: event.companyProfile,
              token: _authenticationRepository.token)
          .then((value) async {
        if (!(value as bool)) {
          emit(CompanyProfilePutFailure(
              currentUser: await _userRepository
                  .getCurrentUser(_authenticationRepository.token)));
          return;
        }
        emit(CompanyProfilePutSuccess(
            currentUser: await _userRepository
                .getCurrentUser(_authenticationRepository.token)));
      });
    } catch (e) {
      emit(CompanyProfilePutFailure(
          currentUser: await _userRepository
              .getCurrentUser(_authenticationRepository.token)));
    }
  }

  Future<FutureOr<void>> _onCompanyProfileFetched(
      CompanyProfileFetched event, Emitter<CompanyProfileState> emit) async {
    emit(CompanyProfilePutInProgress(
        currentUser: await _userRepository
            .getCurrentUser(_authenticationRepository.token)));

    try {
      _companyRepository
          .getCompanyProfile(
              user: await _userRepository
                  .getCurrentUser(_authenticationRepository.token),
              token: _authenticationRepository.token)
          .then((value) async {
        if (value is CompanyProfile) {
          emit(CompanyProfilePutFailure(
              currentUser: await _userRepository
                  .getCurrentUser(_authenticationRepository.token)));
          return;
        }
        emit(CompanyProfilePutSuccess(
            newestCompanyProfile: value,
            currentUser: await _userRepository
                .getCurrentUser(_authenticationRepository.token)));
      });
    } catch (e) {
      emit(CompanyProfilePutFailure(
          currentUser: await _userRepository
              .getCurrentUser(_authenticationRepository.token)));
    }
  }
}
