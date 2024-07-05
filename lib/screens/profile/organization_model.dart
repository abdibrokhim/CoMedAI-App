import 'package:brainmri/models/observation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class OrganizationModel {

  OrganizationModel({
    this.id,
    this.name,
    this.email,
    this.fullName,
    this.departmentName,
    this.phoneNumber,
    this.fullAddress,
  });

factory OrganizationModel.fromJson(Map<dynamic, dynamic> json) {
  return OrganizationModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    fullName: json['fullName'] ?? '',
    departmentName: json['departmentName'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    fullAddress: json['fullAddress'] ?? '',
  );
}
  String? id;
  String? name;
  String? email;
  String? fullName;
  String? departmentName;
  String? phoneNumber;
  String? fullAddress;

  OrganizationModel copyWith({
    String? id,
    String? name,
    String? email,
    String? fullName,
    String? departmentName,
    String? phoneNumber,
    String? fullAddress,
  }) {
    return OrganizationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      departmentName: departmentName ?? this.departmentName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullAddress: fullAddress ?? this.fullAddress,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'fullName': fullName,
      'departmentName': departmentName,
      'phoneNumber': phoneNumber,
      'fullAddress': fullAddress,
    };
  }
}