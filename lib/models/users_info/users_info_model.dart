

import 'package:equatable/equatable.dart';
import 'package:test_app_eds/models/users_info/address_model.dart';
import 'package:test_app_eds/models/users_info/company_model.dart';

class UsersModel extends Equatable{

  final int id;
  final String name;
  final String userName;
  final String email;
  final AddressModel address;
  final String website;
  final CompanyModel company;

  UsersModel(
      {
        required this.id,
        required this.name,
        required this.userName,
        required this.email,
        required this.address,
        required this.website,
        required this.company
      });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id:json['id'],
      name: json['name'],
      userName: json['username'],
      email: json['email'],
      website: json['website'],
      address: AddressModel.fromJson(json['address']  as Map<String, dynamic> ),
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>  ),

    );
  }



  @override
  List<Object> get props => [id,name, userName, email,/* address*/ website,/* company*/];
}
