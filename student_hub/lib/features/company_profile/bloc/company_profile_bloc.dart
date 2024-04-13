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
    on<CompanyProfileCreated>(_onCompanyProfileCreated);
    on<CompanyProfileResetState>(_onCompanyProfileResetState);
  }

  Future<FutureOr<void>> _onCompanyProfileUpdated(
      CompanyProfileUpdated event, Emitter<CompanyProfileState> emit) async {
    User currentUser =
        await _userRepository.getCurrentUser(_authenticationRepository.token);
    emit(CompanyProfileInputInProgress(currentUser: currentUser));

    CompanyProfile currentCompanyProfile = currentUser.companyProfile!;
    CompanyProfile updateCompanyProfile = event.companyProfile;
    currentCompanyProfile.updatedAt = updateCompanyProfile.updatedAt;
    currentCompanyProfile.companyName = updateCompanyProfile.companyName;
    currentCompanyProfile.website = updateCompanyProfile.website;
    currentCompanyProfile.description = updateCompanyProfile.description;
    currentCompanyProfile.size = updateCompanyProfile.size;
    print('[PUT-Updated profile]');
    print(currentCompanyProfile.toJson());
    try {
      await _companyRepository
          .updateCompanyProfile(
              companyProfile: currentCompanyProfile,
              token: _authenticationRepository.token)
          .then((value) async {
        if (!(value as bool)) {
          emit(CompanyProfileInputFailure(
              currentUser: await _userRepository
                  .getCurrentUser(_authenticationRepository.token)));
          return;
        }

        emit(CompanyProfileInputSuccess(
            newestCompanyProfile: currentCompanyProfile,
            currentUser: await _userRepository
                .getCurrentUser(_authenticationRepository.token)));
      });
    } catch (e) {
      emit(CompanyProfileInputFailure(
          currentUser: await _userRepository
              .getCurrentUser(_authenticationRepository.token)));
    }
  }

  Future<FutureOr<void>> _onCompanyProfileFetched(
      CompanyProfileFetched event, Emitter<CompanyProfileState> emit) async {
    emit(CompanyProfileFetchInprogress(
        currentUser: await _userRepository
            .getCurrentUser(_authenticationRepository.token)));

    try {
      await _companyRepository
          .getCompanyProfile(
              user: await _userRepository
                  .getCurrentUser(_authenticationRepository.token),
              token: _authenticationRepository.token)
          .then((value) async {
        if (value is! CompanyProfile) {
          emit(CompanyProfileFetchNoProFile(
              currentUser: await _userRepository
                  .getCurrentUser(_authenticationRepository.token)));
          return;
        }
        emit(CompanyProfileFetchSuccess(
            newestCompanyProfile: value,
            currentUser: await _userRepository
                .getCurrentUser(_authenticationRepository.token)));
      });
    } catch (e) {
      emit(CompanyProfileFetchNetworkFailure(
          currentUser: await _userRepository
              .getCurrentUser(_authenticationRepository.token)));
    }
  }

  Future<FutureOr<void>> _onCompanyProfileCreated(
      CompanyProfileCreated event, Emitter<CompanyProfileState> emit) async {
    emit(CompanyProfileInputInProgress(
        currentUser: await _userRepository
            .getCurrentUser(_authenticationRepository.token)));
    try {
      await _companyRepository
          .createCompanyProfile(
              companyProfile: event.companyProfile,
              token: _authenticationRepository.token)
          .then((value) async {
        if (!(value as bool)) {
          emit(CompanyProfileInputFailure(
              currentUser: await _userRepository
                  .getCurrentUser(_authenticationRepository.token)));
          return;
        }

        emit(CompanyProfileInputSuccess(
            newestCompanyProfile: event.companyProfile,
            currentUser: await _userRepository
                .getCurrentUser(_authenticationRepository.token)));
      });
    } catch (e) {
      print(e.toString());
      emit(CompanyProfileInputFailure(
          currentUser: await _userRepository
              .getCurrentUser(_authenticationRepository.token)));
    }
  }

  Future<FutureOr<void>> _onCompanyProfileResetState(
      CompanyProfileResetState event, Emitter<CompanyProfileState> emit) async {

    emit(CompanyProfileInitial(
        currentUser: await _userRepository
            .getCurrentUser(_authenticationRepository.token)));
    ;
  }
}
