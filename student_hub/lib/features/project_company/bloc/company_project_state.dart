
import 'package:equatable/equatable.dart';
import 'package:student_hub/data/models/domain/project.dart';

abstract class CompanyProjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProjectStateInitial extends CompanyProjectState {

}


class CompanyProjectStateInProgress extends CompanyProjectState {

}

class CompanyProjectStateSuccess extends CompanyProjectState {
  List <Project> projectList;
  CompanyProjectStateSuccess({
    required this.projectList,
  });

   @override
  List<Object?> get props => [projectList];

  @override
  String toString() => "CompanyProfileStateSuccess { Company: $projectList }";
}

class CompanyProjectStateFailure extends CompanyProjectState {

}

class CompanyProjectPostStateSuccess extends CompanyProjectState {

}
