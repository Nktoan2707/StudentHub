
import 'package:student_hub/data/models/domain/company.dart';
import 'package:uuid/uuid.dart';

class CompanyRepository {
  Company? _company;

  Future<Company?> getCompany() async {
    if (_company != null) return _company;
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => _company = Company(
          id: const Uuid().v4(),
          email: 'test@gmail.com',
          password: "testpassword"),
    );
  }
}