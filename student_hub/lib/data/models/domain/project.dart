
class Project {
  final String createdAt;
  final String jobTitle;
  final String jobDescription;
  final int numberOfRequiredStudents;
  final int numberOfProposals;
  final String projectDuration;

  const Project({
    required this.createdAt,
    required this.jobTitle,
    required this.jobDescription,
    required this.numberOfRequiredStudents,
    required this.numberOfProposals,
    required this.projectDuration,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'numberOfRequiredStudents': numberOfRequiredStudents,
      'numberOfProposals': numberOfProposals,
      'projectDuration': projectDuration,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      createdAt: map['createdAt'] as String,
      jobTitle: map['jobTitle'] as String,
      jobDescription: map['jobDescription'] as String,
      numberOfRequiredStudents: map['numberOfRequiredStudents'] as int,
      numberOfProposals: map['numberOfProposals'] as int,
      projectDuration: map['projectDuration'] as String,
    );
  }
}