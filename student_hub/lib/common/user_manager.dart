import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:student_hub/data/models/domain/user.dart';

class UserManager {
  static User userInfo = User(
      id: '',
      userName: '',
      email: '',
      password: '',
      token: '',
      companyProfile: CompanyProfile(
          companyId: '1',
          companyName: '',
          employeeQuantityType: EmployeeQuantityType.large,
          websiteName: '',
          description: ''),
      studentProfile: StudentProfile(
          techStack: TechStack(id: '1', name: ''),
          skillSet: [SkillSet(id: '1', name: '')],
          language: [''],
          education: [
            Education(
                id: '1',
                studentId: '1',
                schoolName: '',
                startYear: DateTime.now(),
                endYear: DateTime.now())
          ],
          transcript: Transcript(),
          resume: Resume()));
}
