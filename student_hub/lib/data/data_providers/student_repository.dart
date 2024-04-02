import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:uuid/uuid.dart';

class StudentRepository {
  StudentProfile? _student;

  Future<StudentProfile?> getStudent() async {
    if (_student != null) return _student;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _student = StudentProfile(
        techStack: TechStack(id: const Uuid().v4(), name: 'Tech Stack'),
        skillSet: const [],
        language: const [],
        education: const [],
        transcript: Transcript(),
        resume: Resume(),
      ),
    );
  }
}
