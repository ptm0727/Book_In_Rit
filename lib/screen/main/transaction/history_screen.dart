import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dbsproject/theme.dart';
import 'package:dbsproject/widget/no_transaction_message.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import '../../../model/aud.dart';
import '../../../model/field_order.dart';
import '../../../model/user.dart';
import '../../../utils/dummy_data.dart';

class HistoryScreen extends StatelessWidget {

  HistoryScreen({Key? key}) : super(key: key);
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
    return StreamBuilder<List<FieldOrder>>(
        stream: readOrders(),
        builder: (context, snapshot) {
          if(snapshot.hasError)
          {
            return Text('Something went wrong ${snapshot.error}');
          }
          else if (snapshot.hasData) {
            final fieldOrderList = snapshot.data;
            fieldOrderList?.sort((a, b) => DateFormat("EEEE, dd MMM yyyy").parse(b.selectedDate).day.compareTo(DateFormat("EEEE, dd MMM yyyy").parse(a.selectedDate).day));
            return Scaffold(
                backgroundColor: backgroundColor,
                body: fieldOrderList!.isEmpty
                    ? Center(
                    child: SingleChildScrollView(
                        child: NoTranscationMessage(
                          messageTitle: "No Events Currently",
                          messageDesc:
                          "Want to conduct an event\nThen come on , Let's explore Auditoriums in MSRIT",
                        ),
                    ))
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
          timings=timings+"\n"+displaytime[i];
        else if(i==0 && tim[i]==true)
          timings=timings+"\n"+displaytime[i].substring(0,5);
        else if(i==(tim.length-1) && tim[i]==true && tim[i-1]==false) {
          timings = timings + displaytime[i].substring(5);
        }
        else if(i==(tim.length-1) && tim[i]==true) {
          timings = timings + displaytime[i].substring(5);
        }

        else {
          if(i!=0 && i!=(tim.length-1))
          if(tim[i-1] == false && tim[i] == true)
            timings=timings+"\n"+displaytime[i].substring(0,5);
          else if(tim[i+1] == false && tim[i] == true)
            timings=timings+displaytime[i].substring(5);
          else if(tim[i+1] == false && tim[i] == true && tim[i-1] == false)
            timings=timings+"\n"+displaytime[i];

        }
      }
    return InkWell(
      onTap: ()
      {
        print(DateFormat("EEEE, dd MMM yyyy").parse(fieldorder.selectedDate));
        print(DateTime.now());
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
                /*FutureBuilder<UserD?>(
                    future: readthis(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final sampleUser=snapshot.data;
                        return Text(
                          "Organizor : "+sampleUser!.name,
                          style: normalTextStyle,
                        );}
                      else{
                        return Text("Conecting....");
                      }
                    }
                ),*/
                Text("Timings " +timings,
                    style: normalTextStyle),
                const SizedBox(
                  height: 4,
                ),
                Text("Venue: " +a.name,
                    style: normalTextStyle),
              ],
            ),
            const Spacer(),
            DateFormat("EEEE, dd MMM yyyy").parse(fieldorder.selectedDate).isAfter(DateTime.now())?Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green)),
                child: Text(
                  "Upcoming",
                  style: normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                )):DateFormat("EEEE, dd MMM yyyy").parse(fieldorder.selectedDate).day==DateTime.now().day?Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue)),
                child: Text(
                  "Today",
                  style: normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                )):Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red)),
                child: Text(
                  "Ended",
                  style: normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
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
}
