import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
final usern=FirebaseAuth.instance.currentUser;
class UserD {
  String id;
  String name;
  String email;
  bool accountType;
  String dept;
  String phone;

  UserD(
      {required this.id,
      required this.name,
      required this.email,
      required this.accountType,
      required this.dept,
      required this.phone});
  /*Map<String, dynamic> toMap(){
    return {
    'id'=this.id,
    'name'=this.name,
    'email'=this.email,
    'accountType'=accountType};
  }*/
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'accountType':accountType,
      'dept':dept,
      'phone number':phone,
    };
  }

  static UserD fromJson(Map<String, dynamic> json)=>UserD(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      accountType: json['accountType'],
      dept: json['dept'],
    phone: json['phone number']
  );


}
