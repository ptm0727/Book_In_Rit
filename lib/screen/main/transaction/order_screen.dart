

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dbsproject/model/field_order.dart';
import 'package:dbsproject/theme.dart';
import 'package:dbsproject/utils/dummy_data.dart';
import 'package:dbsproject/widget/no_transaction_message.dart';

import '../../../model/aud.dart';
import '../../../model/user.dart';


class OrderScreen extends StatelessWidget {
  late BuildContext c;
  List<String> displaytime = [
    "09.00-10.00",
    "10.00-11.00",
    "11.00-12.00",
    "12.00-13.00",
    "13.00-14.00",
    "14.00-15.00",
    "15.00-16.00",
    "16.00-17.00",
    "17.00-18.00",
    "18.00-19.00",
  ];

  @override
  Widget build(BuildContext context) {
    c=context;
    return StreamBuilder<List<FieldOrder>>(
      stream: readOrders(),
      builder: (context, snapshot) {
        if(snapshot.hasError)
          {
            return Text('Something went wrong ${snapshot.error}');
          }
        else if (snapshot.hasData) {
          final fieldOrderList = snapshot.data?.where((element) => element.id==FirebaseAuth.instance.currentUser?.uid);
          return Scaffold(
              backgroundColor: backgroundColor,
              body: fieldOrderList!.isEmpty
                  ? Center(
                  child: SingleChildScrollView(
                      child: NoTranscationMessage(
                        messageTitle: "No Transactions, yet.",
                        messageDesc:
                        "You have never placed an order. Let's explore Auditoriums in MSRIT",
                      )))
                  : ListView(
                children: fieldOrderList.map(buildOrder).toList(),
              )
          );
        }
        else {
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );

  }
  Widget buildOrder(FieldOrder fieldorder) {
    Future<UserD?> readthis() async{
      final nowuse=FirebaseFirestore.instance.collection('users').doc(fieldorder.id);
      final snapshot=await nowuse.get();
      if(snapshot.exists)
      {
        return UserD.fromJson(snapshot.data()!);
      }
    }
    int x=fieldorder.Aid;
    Aud a=sportFieldList[x-1];
    List tim=fieldorder.selectedTime;
    String timings="";
    for(int i=0;i<tim.length;i++)
    {
      if(i==0 && tim[i]==true&& tim[i+1]==false)
        timings=timings+" "+displaytime[i];
      else if(i==0 && tim[i]==true)
        timings=timings+" "+displaytime[i].substring(0,5);
      else if(i==(tim.length-1) && tim[i]==true && tim[i-1]==false) {
        timings = timings + displaytime[i].substring(5);
      }
      else if(i==(tim.length-1) && tim[i]==true) {
        timings = timings + displaytime[i].substring(5);
      }

      else {
        if(i!=0 && i!=(tim.length-1))
          if (tim[i-1] == false && tim[i] == true)
            timings=timings+" "+displaytime[i].substring(0,5);
          else if(tim[i+1] == false && tim[i] == true)
            timings=timings+displaytime[i].substring(5);
          else if(tim[i+1] == false && tim[i] == true && tim[i-1] == false)
            timings=timings+" "+displaytime[i];

      }
    }
    return InkWell(
        onTap: ()
                  {
                    showModalBottomSheet<void>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                      ),
                      context: c,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.teal.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.teal)),
                                  child: Text(
                                    "ORDER DETAILS",
                                    style: normalTextStyle.copyWith(
                                      fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.teal),
                                  )),
                              /*Center(
                                child: Text(
                                  "ORDER DETAILS",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.blue
                                  ),
                                ),
                              ),*/
                              SizedBox(height: 25,),
                              Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: colorWhite),
                                  child: const Icon(
                                    Icons.event_available,
                                    size: 24,
                                    color: darkBlue300,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Event :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),

                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      fieldorder.eventname,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: const Icon(
                                      Icons.date_range,
                                      size: 24,
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),

                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        fieldorder.selectedDate,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: const Icon(
                                      Icons.timer,
                                      size: 24,
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Timings :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),

                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        timings,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: const Icon(
                                      Icons.location_city,
                                      size: 24,
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Venue :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),

                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        a.name,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: const Icon(
                                      Icons.person,
                                      size: 24,
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Oraganizor :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),

                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      FutureBuilder<UserD?>(
                                          future: readthis(),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              final sampleUser=snapshot.data;
                                              return Text(
                                                sampleUser!.name,
                                                style: normalTextStyle,
                                              );}
                                            else{
                                              return Text("Connecting....");
                                            }
                                          }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: ()  {
                                    Navigator.pop(context);
                                    final doc=  FirebaseFirestore.instance.collection('Orders').where("Aid",isEqualTo: fieldorder.Aid)
                                        .where("selectedDate",isEqualTo: fieldorder.selectedDate).where("selectedTime",isEqualTo: fieldorder.selectedTime).get()
                                        .then((querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        doc.reference.delete();
                                      });
                                      return null; });
                                    FirebaseFirestore.instance.collection('booked').where("Aid",isEqualTo: fieldorder.Aid)
                                        .where("selectedDate",isEqualTo: fieldorder.selectedDate).where("selectedTime",isEqualTo: fieldorder.selectedTime).get()
                                        .then((querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        doc.reference.delete();
                                      });
                                      return null; });
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Booking Deleted',style: TextStyle(
                                          color: Colors.blue
                                        ),),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.delete,size: 16,),
                                  label: Text(
                                    "Delete Order",
                                    style: TextStyle(fontSize: 16),),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
    splashColor: primaryColor100,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
    children: [
    Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(a.imageAsset))),
    ),
      const SizedBox(
        width: 16,
      ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "Event : "+fieldorder.eventname,
    style: normalTextStyle,
    ),
    const SizedBox(
    height: 4,
    ),
    Text(fieldorder.selectedDate,
    style: normalTextStyle),
      const SizedBox(
        height: 4,
      ),
      FutureBuilder<UserD?>(
        future: readthis(),
        builder: (context, snapshot) {
    if(snapshot.hasData){
    final sampleUser=snapshot.data;
          return Text(
            "Organizor : "+sampleUser!.name,
            style: normalTextStyle,
          );}
    else{
      return Text("Connecting....");
    }
        }
      ),
    ],
    ),
    const Spacer(),
    Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
    color: Colors.teal.withOpacity(0.1),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.teal)),
    child: Text(
    "Confirmed",
    style: normalTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: Colors.teal),
    )),
    ],
    ),
    )
    ,
    );
  }

  Stream<List<FieldOrder>> readOrders()=>FirebaseFirestore.instance
      .collection('Orders')
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => FieldOrder.fromJson(doc.data())).toList());
  Future<UserD?> readUs() async{
    final nowuse=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
    final snapshot=await nowuse.get();
    if(snapshot.exists)
    {
      return UserD.fromJson(snapshot.data()!);
    }
  }

}
