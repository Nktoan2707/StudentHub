import 'package:student_hub/data/models/domain/student_profile.dart';

class StudentRepository {
  StudentProfile? _student;

  Future<StudentProfile?> getStudent() async {
    return null;
  
    // if (_student != null) return _student;
    // return Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _student = StudentProfile(
    //     techStack: TechStack(id: const Uuid().v4(), name: 'Tech Stack'),
    //     skillSet: const [],
    //     language: const [],
    //     education: const [],
    //     transcript: Transcript(),
    //     resume: Resume(),
    //   ),
    // );
  }
}
