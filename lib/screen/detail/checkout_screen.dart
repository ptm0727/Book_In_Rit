import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbsproject/model/booked.dart';
import 'package:dbsproject/widget/sport_field_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dbsproject/model/checkbox_state.dart';
import 'package:dbsproject/model/field_order.dart';
import 'package:dbsproject/model/aud.dart';
import 'package:dbsproject/screen/main/main_screen.dart';
import 'package:dbsproject/theme.dart';
import 'package:dbsproject/utils/dummy_data.dart';

class CheckoutScreen extends StatefulWidget {
  Aud field;

  CheckoutScreen({required this.field});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _controller = TextEditingController();
  final eventController=TextEditingController();
  DateTime _dateTime = DateTime.now();
  final dateFormat = DateFormat("EEEE, dd MMM yyyy");
  var availableBookTime = [
    CheckBoxState(title: "00.00"),
  ];
  int _totalBill = 0;
  bool _enableCreateOrderBtn = false;
  List<String> timeList = timeToBook;
  var currentTime = "00.00";
  List<dynamic> booked = [false,false,false,false,false,false,false,false,false,false];
  List<dynamic> checktime=[false,false,false,false,false,false,false,false,false,false];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

    for (var time in timeList) {
      if (time == widget.field.openTime) {
        currentTime = time;
        print("$currentTime and $time");
      }
    }

    availableBookTime.removeAt(0);
    for (int i = timeList.indexOf(currentTime); i < 24; i++) {
      if (currentTime == widget.field.closeTime) {
        break;
      } else {
        if(booked![i]==false){
        availableBookTime
            .add(CheckBoxState(title: "${timeList[i]} - ${timeList[i + 1]}"));
        currentTime = timeList[i + 1];}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: colorWhite,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: Text("Checkout"),
            backgroundColor: colorWhite,
            centerTitle: true,
            foregroundColor: primaryColor500,
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(right: 24, left: 24, bottom: 24, top: 8),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              StreamBuilder<List<Booked>>(
                stream: readTimes(),
                builder: (context, snapshot) {
                  if(snapshot.hasError)
                    return Text("${snapshot.error}");
                  else if(!snapshot.hasData)
                    return Center(child: CircularProgressIndicator(),);
                  final x=snapshot.data!;
                  for(int m=0;m<x.length;m++)
                    {
                      if(x[m].selectedDate==dateFormat.format(_dateTime).toString()&&x[m].Aid==widget.field.id){
                      for(int n=0;n<10;n++) {
                    if(x[m].selectedTime[n]==true){
                      checktime[n]=true;
                    }
                        }}
                    }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Venue Name",
                        style: subTitleTextStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor100, width: 2),
                            color: lightBlue100,
                            borderRadius: BorderRadius.circular(borderRadiusSize)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/pin.png",
                              width: 24,
                              height: 24,
                              color: primaryColor500,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(widget.field.name,
                                style: normalTextStyle.copyWith(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            "Event Name ",
                            style: subTitleTextStyle,
                          ),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor100,width: 2),
                            color: lightBlue100,
                            borderRadius: BorderRadius.circular(borderRadiusSize)),
                            child:TextFormField(
                              controller: eventController,
                              textInputAction: TextInputAction.done,
                              maxLength: 25,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value)=>
                              value != null && value.length<2?
                              'Enter min. 2 characters':
                              null,
                            ),
                            /*Text(widget.field.name,
                                style: normalTextStyle.copyWith(
                                    fontWeight: FontWeight.w600)),*/
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            "Pick a Date ",
                            style: subTitleTextStyle,
                          ),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {setState(() {
                          checktime=[false,false,false,false,false,false,false,false,false,false];
                          booked=[false,false,false,false,false,false,false,false,false,false];
                        });
                          _selectDate();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor100, width: 2),
                              color: lightBlue100,
                              borderRadius:
                                  BorderRadius.circular(borderRadiusSize)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.date_range_rounded,
                                color: primaryColor500,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                _dateTime == null
                                    ? "date not selected.."
                                    : dateFormat.format(_dateTime).toString(),
                                style: normalTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Pick a Time",
                        style: subTitleTextStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ...availableBookTime.map(buildSingleCheckBox).toList(),
                    ],
                  );
                }
              ),
            ])),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: lightBlue300,
            offset: Offset(0, 0),
            blurRadius: 10,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Seats:",
                  style: descTextStyle,
                ),
                Text(
                  widget.field.seating.toString(),
                  style: priceTextStyle,
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadiusSize))),
                  onPressed: !_enableCreateOrderBtn
                      ? null
                      : checkValid()?() {
                          List<String> selectedTime = [];
                          for (int i = 0; i < availableBookTime.length; i++) {
                            if (availableBookTime[i].value) {
                              selectedTime.add(availableBookTime[i].title);
                            }
                          }
                          createOrder();
                          createBooking();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MainScreen(currentScreen: 1)),
                              (route) => false);
                          _showSnackBar(
                              context, "Successfully create an order");
                        }:null,
                  child: checkValid()?Text(
                    "Create Booking",
                    style: buttonTextStyle,
                  ):Text(
                    "Time Selected",
                    style: buttonTextStyle,
                  )),
            ),
          ],
        ),
      ),
    );

  }

  void _showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      margin: const EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

bool checkValid()
{
  for(int i=0;i<checktime.length;i++)
    {
      if(checktime[i]==booked[i] && checktime[i]==true) {
        return false;
      }
    }
  return true;
}

  void _selectDate() async {
    await showDatePicker(
      currentDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
            context: context,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
            firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 7))
        .then((value) {
      setState(() {
        _dateTime = value!;
        checktime=[false,false,false,false,false,false,false,false,false,false];
        booked=[false,false,false,false,false,false,false,false,false,false];
      });
    });
  }

  Widget buildSingleCheckBox(CheckBoxState checkbox) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(checkbox.title),
      value: checkbox.value,
      onChanged: (bool? value) {
        setState(() {
          checkbox.value = value!;
        });
        int totalSelectedTime = 0;
        for (int i = 0; i < availableBookTime.length; i++) {
          booked![i]=availableBookTime[i].value;
          if (availableBookTime[i].value == true) {
            totalSelectedTime++;
          }
        }
        setState(() {
          _totalBill = widget.field.seating ;
          if (totalSelectedTime > 0) {
            _enableCreateOrderBtn = true;
          } else {
            _enableCreateOrderBtn = false;
          }
        });
      },
    );
  }
  Stream<List<Booked>> readTimes()=>FirebaseFirestore.instance
      .collection('booked')
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Booked.fromJson(doc.data())).toList());
  Future createBooking() async{
    final docUser=FirebaseFirestore.instance.collection('booked').doc();
    final ordernow=Booked(
        Aid: widget.field.id,
        selectedDate: dateFormat.format(_dateTime).toString(),
        selectedTime: booked!,);
    final json=ordernow.toJson();
    await docUser.set(json);
  }
  Future createOrder() async{
    final docUser=FirebaseFirestore.instance.collection('Orders').doc();
    final ordernow=FieldOrder(
        Aid: widget.field.id,
        id: FirebaseAuth.instance.currentUser!.uid,
        selectedDate: dateFormat.format(_dateTime).toString(),
        selectedTime: booked!,
        eventname: eventController.text.trim());
    final json=ordernow.toJson();
    await docUser.set(json);
  }

}
