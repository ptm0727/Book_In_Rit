class Booked {
  int Aid;
  String selectedDate;
  List<dynamic> selectedTime;

  Booked(
      {required this.Aid,
        required this.selectedDate,
        required this.selectedTime,
        });

  Map<String, dynamic> toJson() {
    return {
      'Aid': Aid,
      'selectedDate':selectedDate,
      'selectedTime':selectedTime,
    };
  }

  static Booked fromJson(Map<String, dynamic> json)=>Booked(
    Aid: json['Aid'],
    selectedDate: json['selectedDate'],
    selectedTime: json['selectedTime'],
  );
}