import 'package:equatable/equatable.dart';

class AddressModel extends Equatable{

  final String street;
  final String suite;
  final String city;

  AddressModel({
    required this.street,
    required this.suite,
    required this.city
  });


  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
    );
  }


  @override
  List<Object> get props => [street,suite,city];
}