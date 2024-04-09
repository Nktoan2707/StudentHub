

import 'package:equatable/equatable.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';

abstract class CompanyProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProjectCreate extends CompanyProjectEvent {
  Project projectCreate;
  CompanyProjectCreate({
    required this.projectCreate
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProjectCreate ${projectCreate.toString()}";
  }
}

class CompanyProjectListFetch extends CompanyProjectEvent {
  final User user;
  CompanyProjectListFetch({
    required this.user,
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProjectListFetch ${user.companyProfile!.id}";
  }
}
