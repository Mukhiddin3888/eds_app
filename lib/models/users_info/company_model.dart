import 'package:hive/hive.dart';

part 'company_model.g.dart';

@HiveType(typeId: 3)
class CompanyModel extends HiveObject{

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String bs;

  CompanyModel({
    required this.name,
    required this.bs,

  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        name: json["name"],
        bs: json["bs"]
    );
  }


}