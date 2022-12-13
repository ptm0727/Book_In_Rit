import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dbsproject/model/aud.dart';
import 'package:dbsproject/screen/search_screen.dart';
import 'package:dbsproject/theme.dart';
import 'package:dbsproject/utils/dummy_data.dart';
import 'package:dbsproject/widget/category_card.dart';
import 'package:dbsproject/widget/sport_field_card.dart';

import '../../../model/user.dart';

class HomeScreen extends StatelessWidget {
  List<Aud> fieldList = recommendedSportField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          header(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Text(
                    "Let's Have Fun and \nStart Booking!",
                    style: greetingTextStyle,
                  ),
                ),
                CategoryListView(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended Venue",
                        style: subTitleTextStyle,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchScreen(
                                selectedDropdownItem: "All",
                              );
                            }));
                          },
                          child: const Text("Show All"))
                    ],
                  ),
                ),
                // RECOMMENDED FIELDS
                Column(
                    children: fieldList
                        .map((fieldEntity) => SportFieldCard(
                              field: fieldEntity,
                            ))
                        .toList()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header(context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        // SEARCH Icon
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
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
                FutureBuilder<UserD?>(
                  future: readUs(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final sampleUser=snapshot.data;
                      return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: descTextStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          sampleUser!.name,
                          style: subTitleTextStyle,
                        ),
                      ],
                    );}
                    else {
                        return Center(child: Text("Connecting....."),);
                      }
                  }
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: primaryColor500,
                  borderRadius: BorderRadius.circular(borderRadiusSize)),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen(
                      selectedDropdownItem: "",
                    );
                  }));
                },
                icon: const Icon(Icons.search, color: colorWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
