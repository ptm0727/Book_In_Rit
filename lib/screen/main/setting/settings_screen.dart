import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dbsproject/utils/dummy_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/user.dart';
import '../../../theme.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          toolbarHeight: kTextTabBarHeight,
          title: Text(
            "Settings",
            style: titleTextStyle,
          ),
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder<UserD?>(
          future: readUs(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
            final sampleUser=snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: subTitleTextStyle.copyWith(color: primaryColor500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/user_profile_example.png"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sampleUser!.name,
                                  style: subTitleTextStyle,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: primaryColor100.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: primaryColor500)),
                                    child: Text(
                                      sampleUser.accountType?'Faculty':'Student',
                                      style: descTextStyle.copyWith(
                                          color: primaryColor500),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Details",
                      style: subTitleTextStyle.copyWith(color: primaryColor500),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: primaryColor100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: colorWhite),
                              child: const Icon(
                                Icons.email,
                                size: 24,
                                color: darkBlue300,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email ID",
                                    overflow: TextOverflow.visible,
                                    style: normalTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    sampleUser.email,
                                    style: descTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: primaryColor100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: colorWhite),
                              child: const Icon(
                                Icons.phone_android,
                                size: 24,
                                color: darkBlue300,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Number",
                                    overflow: TextOverflow.visible,
                                    style: normalTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    sampleUser.phone,
                                    style: descTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: primaryColor100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: colorWhite),
                              child: const Icon(
                                CupertinoIcons.home,
                                size: 24,
                                color: darkBlue300,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Department",
                                    overflow: TextOverflow.visible,
                                    style: normalTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    sampleUser.dept,
                                    style: descTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Other",
                      style: subTitleTextStyle.copyWith(color: primaryColor500),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: primaryColor100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: colorWhite),
                              child: const Icon(
                                CupertinoIcons.moon_circle,
                                size: 24,
                                color: darkBlue300,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Theme",
                                  style: normalTextStyle,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Light",
                                  style: descTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: primaryColor100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: colorWhite),
                              child: const Icon(
                                Icons.language_rounded,
                                size: 24,
                                color: darkBlue300,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Language",
                                  style: normalTextStyle,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "English",
                                  style: descTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "About App",
                      style: subTitleTextStyle.copyWith(color: primaryColor500),
                    ),
                    InkWell(
                      onTap: () {
                        _showSnackBar(context, "Newest Version");
                      },
                      splashColor: primaryColor100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: colorWhite),
                              child: const Icon(
                                CupertinoIcons.info_circle_fill,
                                size: 24,
                                color: darkBlue300,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "BookInRit-Auditorium booking system",
                                    style: normalTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                  "Version 1.0.0",
                                    style: descTextStyle,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(Icons.arrow_back,size: 16,),
                        label: Text(
                          "Sign Out",
                          style: TextStyle(fontSize: 16),),
                      ),
                    ),

                  ],
                ),
              ),
            );}
            else if(snapshot.hasError)
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(Icons.arrow_back,size: 16,),
                        label: Text(
                          "Sign Out",
                          style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  ],
                );
              }
            else
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 50,),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(Icons.arrow_back,size: 16,),
                        label: Text(
                          "Sign Out",
                          style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  ],
                );
              }
          }
        ));
  }
  Stream<List<UserD>> readUsers()=>FirebaseFirestore.instance
      .collection('users')
      .snapshots().map((snapshot) =>
                snapshot.docs.map((doc) => UserD.fromJson(doc.data())).toList());
  
  void _showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      margin: const EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      // margin: EdgeInsets.all(16),
    ));
  }
}
