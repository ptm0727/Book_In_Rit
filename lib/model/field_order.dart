import 'package:dbsproject/model/aud.dart';
import 'package:dbsproject/model/user.dart';

class FieldOrder {
  int Aid;
  String id;
  Aud? field;
  String selectedDate;
  List<dynamic> selectedTime;
  String eventname;

  FieldOrder(
      {required this.Aid,
        required this.id,
        this.field,
      required this.selectedDate,
      required this.selectedTime,
       required this.eventname});

  Map<String, dynamic> toJson() {
    return {
      'Aid': Aid,
      'id': id,
      'selectedDate':selectedDate,
      'selectedTime':selectedTime,
      'eventname':eventname,
    };
  }

  static FieldOrder fromJson(Map<String, dynamic> json)=>FieldOrder(
      Aid: json['Aid'],
      id: json['id'],
      selectedDate: json['selectedDate'],
      selectedTime: json['selectedTime'],
      eventname: json['eventname'],
  );
}
