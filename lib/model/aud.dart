import 'package:dbsproject/model/audcategory.dart';
import 'package:dbsproject/model/field_facility.dart';

class Aud {
  int id;
  String name;
  AudCategory category;
  List<FieldFacility> facilities;
  String address;
  String phoneNumber;
  String openDay;
  String openTime;
  String closeTime;
  String imageAsset;
  int seating;
  String author;
  String ratings;

  Aud(
      {required this.id,
      required this.name,
      required this.category,
      required this.facilities,
      required this.address,
      required this.phoneNumber,
      required this.openDay,
      required this.openTime,
      required this.closeTime,
      required this.imageAsset,
      required this.seating,
      required this.author,
        required this.ratings});
}
