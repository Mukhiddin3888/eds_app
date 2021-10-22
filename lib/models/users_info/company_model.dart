import 'package:equatable/equatable.dart';

class CompanyModel extends Equatable{

  final String name;
  final String bs;

  CompanyModel({
    required this.name,
    required this.bs,

  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        name: json['name'],
        bs: json['bs']
    );
  }


  @override
  List<Object> get props => [name,bs];
}