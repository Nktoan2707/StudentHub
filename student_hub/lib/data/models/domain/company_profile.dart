// ignore_for_file: public_member_api_docs, sort_constructors_first




enum EmployeeQuantityType { onlyMe, small, medium, large, xlarge }

class CompanyProfile {
  int? userId;
  String? fullname;
  String? companyName;
  String? website;
  int? size;
  String? description;
  String? updatedAt;
  String? deletedAt;
  int? id;
  String? createdAt;

  CompanyProfile(
      {this.userId,
        this.fullname,
        this.companyName,
        this.website,
        this.size,
        this.description,
        this.updatedAt,
        this.deletedAt,
        this.id,
        this.createdAt});



  CompanyProfile.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullname = json['fullname'];
    companyName = json['companyName'];
    website = json['website'];
    size = json['size'];
    description = json['description'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullname'] = fullname;
    data['companyName'] = companyName;
    data['website'] = website;
    data['size'] = size;
    data['description'] = description;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullname': fullname,
      'companyName': companyName,
      'website': website,
      'size': size,
      'description': description,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory CompanyProfile.fromMap(Map<String, dynamic> map) {
    return CompanyProfile(
      userId: map['userId'] as int,
      fullname: map['fullname'] as String,
      companyName: map['companyName'] as String,
      website: map['website'] as String,
      size: map['size'] as int,
      description: map['description'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] as Null,
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
    );
  }
}
