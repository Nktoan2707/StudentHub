// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';


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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fullname'] = this.fullname;
    data['companyName'] = this.companyName;
    data['website'] = this.website;
    data['size'] = this.size;
    data['description'] = this.description;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'fullname': this.fullname,
      'companyName': this.companyName,
      'website': this.website,
      'size': this.size,
      'description': this.description,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'id': this.id,
      'createdAt': this.createdAt,
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
