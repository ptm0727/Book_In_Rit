import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbsproject/model/booked.dart';
import 'package:dbsproject/model/field_facility.dart';
import 'package:dbsproject/model/field_order.dart';
import 'package:dbsproject/model/audcategory.dart';
import 'package:dbsproject/model/aud.dart';
import 'package:dbsproject/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<UserD?> readUs() async{
  final nowuse=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
  final snapshot=await nowuse.get();
  if(snapshot.exists)
  {
    return UserD.fromJson(snapshot.data()!);
  }
}
var sampleUser = UserD(
    id: usern!.uid,
    name: usern!.email.toString(),
    email: "sample@gmail.com",
    accountType: true,
    dept: "Cse",
    phone: "9448670088"
);


var _lhc = AudCategory(
  name: "LHC Block",
  image: "assets/icons/lhc.jpg",
);
var _Apex = AudCategory(
  name: "Apex Block",
  image: "assets/icons/apex.jpg",
);
var _des = AudCategory(
  name: "DES Block",
  image: "assets/icons/des.jpg",
);
var _esb = AudCategory(
  name: "ESB Block",
  image: "assets/icons/esb.jpg",
);
var _arena = AudCategory(
  name: "Central Arena",
  image: "assets/icons/5.jpg",
);

List<AudCategory> sportCategories = [
  _lhc,
  _des,
  _esb,
  _Apex,
  _arena,
];

var _wifi = FieldFacility(name: "WiFi", imageAsset: "assets/icons/wifi.png");
var _toilet =
    FieldFacility(name: "Projector", imageAsset: "assets/icons/projector.png");
var _changingRoom = FieldFacility(
    name: "Air Condition", imageAsset: "assets/icons/ac.png");
var _canteen =
    FieldFacility(name: "Canteen", imageAsset: "assets/icons/canteen.png");
var _locker =
    FieldFacility(name: "Lockers", imageAsset: "assets/icons/lockers.png");
var _chargingArea = FieldFacility(
    name: "Charging Area", imageAsset: "assets/icons/charging.png");

Aud futsalRionov = Aud(
  id: 1,
  name: "Apex Seminar Hall",
  address: "7th Floor ,Apex Block ,MSRIT",
  category: _Apex,
  facilities: [_wifi, _toilet,_changingRoom,_chargingArea],
  phoneNumber: "+91-80-23600822",
  openDay: "Monday to Sunday",
  openTime: "09.00",
  closeTime: "19.00",
  imageAsset: "assets/images/aud1.jpeg",
  seating: 750,
  author: "General Sciences Department",
  ratings: "⭐⭐⭐⭐⭐"
);

Aud basketballVio = Aud(
    id: 2,
    name: "LHC seminar hall 1",
    address: "LHC ground floor, LHC block,MSRIT",
    category: _lhc,
    facilities: [_wifi, _toilet, _changingRoom, _canteen],
    author: "CSE/ISE department",
    phoneNumber: "+91-80-23600822",
    openDay: "All Day",
    openTime: "09.00",
    closeTime: "19.00",
    imageAsset: "assets/images/aud2.jpeg",
    ratings: "⭐⭐⭐⭐",
    seating: 150
);
Aud volleyTanjung = Aud(
    id: 3,
    name: "LHC seminar hall 2",
    address: "LHC ground floor, LHC block,MSRIT",
    category: _lhc,
    facilities: [_wifi, _toilet, _changingRoom, _canteen],
    author: "CSE/ISE department",
    phoneNumber: "+91-80-23600822",
    openDay: "All Day",
    openTime: "09.00",
    closeTime: "19.00",
    imageAsset: "assets/images/aud3.jpeg",
    ratings: "⭐⭐⭐",
    seating: 100
);
Aud tableTennisDCortez = Aud(
    id: 4,
    name: "DES Seminar hall",
    address: "DES ground floor, DES block,MSRIT",
    category: _des,
    facilities: [_wifi, _toilet, _canteen],
    author: "CSE department",
    phoneNumber: "+91-80-23600822",
    openDay: "All Day",
    openTime: "09.00",
    closeTime: "19.00",
    imageAsset: "assets/images/aud4.jpeg",
    ratings: "⭐⭐⭐⭐",
    seating: 200);
Aud basketballKali = Aud(
    id: 5,
    name: "ESB Seminar Hall 1",
    address: "ESB ground floor, ESB block,MSRIT",
    category: _esb,
    facilities: [_wifi, _toilet, _changingRoom, _canteen],
    author: "Mechanical/Civil department",
    phoneNumber: "+91-80-23600822",
    openDay: "All Day",
    openTime: "09.00",
    closeTime: "19.00",
    imageAsset: "assets/images/aud5.jpeg",
    ratings: "⭐⭐⭐⭐⭐",
    seating: 500);

Aud basketballLM = Aud(
    id: 6,
    name: "ESB Seminar Hall 2",
    address: "ESB ground floor, ESB block,MSRIT",
    category: _esb,
    facilities: [_wifi, _toilet, _changingRoom, _canteen],
    author: "Mechanical/Civil department",
    phoneNumber: "+91-80-23600822",
    openDay: "All Day",
    openTime: "09.00",
    closeTime: "19.00",
    imageAsset: "assets/images/aud6.jpeg",
    ratings: "⭐⭐⭐⭐⭐",
    seating: 150);

Aud tennisDC = Aud(
    id: 7,
    name: "Quadrangle",
    address: "Front of ramaiah statue,MSRIT ",
    category: _arena,
    facilities: [ _toilet, _locker],
    author: "All Departments",
    phoneNumber: "+91-80-23600822",
    openDay: "All Day",
    openTime: "09.00",
    closeTime: "19.00",
    imageAsset: "assets/images/aud7.jpg",
    ratings: "⭐⭐",
    seating: 1300);


List<Aud> sportFieldList = [
  futsalRionov,
  basketballVio,
  volleyTanjung,
  tableTennisDCortez,
  basketballKali,
  basketballLM,
  tennisDC,
];

List<Aud> recommendedSportField = [
  basketballVio,
  basketballKali,
  tableTennisDCortez,
  futsalRionov
];

List<FieldOrder> dummyUserOrderList = [];

List<String> timeToBook = [
  "09.00",
  "10.00",
  "11.00",
  "12.00",
  "13.00",
  "14.00",
  "15.00",
  "16.00",
  "17.00",
  "18.00",
  "19.00",
];
List<bool> checktime=[

];
