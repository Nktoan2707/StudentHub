
import 'package:student_hub/data/models/domain/student.dart';
import 'package:uuid/uuid.dart';

class StudentRepository {
  Student? _student;

  Future<Student?> getStudent() async {
    if (_student != null) return _student;
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => _student = Student(
          id: const Uuid().v4(),
          email: 'test@gmail.com',
          password: "testpassword"),
    );
  }
}