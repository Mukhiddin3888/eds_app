import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 1)
class AddressModel extends HiveObject{

  @HiveField(0)
  final String street;
  @HiveField(1)
  final String suite;
  @HiveField(2)
  final String city;

  AddressModel({
    required this.street,
    required this.suite,
    required this.city
  });


  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json["street"],
      suite: json["suite"],
      city: json["city"],
    );
  }


}