

import 'package:hive/hive.dart';
import 'package:test_app_eds/models/users_info/address_model.dart';
import 'package:test_app_eds/models/users_info/company_model.dart';

part 'users_info_model.g.dart';

@HiveType(typeId: 1)
class UsersModel extends HiveObject{

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String userName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final AddressModel address;
  @HiveField(6)
  final String website;
  @HiveField(7)
  final CompanyModel company;

  UsersModel(
      {
        required this.id,
        required this.name,
        required this.userName,
        required this.phone,
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
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      address: AddressModel.fromJson(json['address']  as Map<String, dynamic> ),
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>  ),

    );
  }
}
