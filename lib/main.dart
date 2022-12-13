import 'package:dbsproject/signin/Utils.dart';
import 'package:dbsproject/signin/auth_page.dart';
import 'package:dbsproject/signin/loginwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dbsproject/screen/main/main_screen.dart';
import 'package:dbsproject/screen/onboarding_screen.dart';
import 'package:dbsproject/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final skipOnBoarding = prefs.getBool("skipOnBoarding") ?? false;
  await Firebase.initializeApp();
  runApp(MyApp(skipOnBoarding: skipOnBoarding));
}
final navigatorKey=GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {

  final bool skipOnBoarding;

  const MyApp({Key? key, required this.skipOnBoarding}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'BookInRit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: createMaterialColor(primaryColor500),
          canvasColor: colorWhite),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError) {
              return Center(child: Text("Something went wrong!"),);
            }
          else if((snapshot.hasData)){
            return skipOnBoarding? MainScreen(currentScreen: 0): OnboardingScreen();
          }
          else{
            return AuthPage();
            }
        }
      )
    );
  }
}
