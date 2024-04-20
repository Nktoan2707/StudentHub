

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
  final int typeFlag;
  CompanyProjectListFetch({
    required this.typeFlag
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProjectListFetch";
  }
}

class CompanyProjectGetDetail extends CompanyProjectEvent {
  final int projectId;
  CompanyProjectGetDetail({
    required this.projectId
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProjectGetDetail";
  }
}

