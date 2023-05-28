import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hob_sparcs/login_page.dart';
import 'src/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _App();
}

UserName userName = UserName("id", "realName", "nickName");

class _App extends State<App> {
  Future getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection("users");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    for (var doc in querySnapshot.docs) {
      if (doc.data()["email"].toString() == user!.email.toString()) {
        userName = UserName(doc.data()["email"], doc.data()["realName"],
            doc.data()["nickname"]);
      }
    }
    return;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hob-SPARCS",
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber, brightness: Brightness.light),
          primaryColor: Colors.amber,
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(),
          ),
          iconTheme: IconThemeData(color: Colors.amber, size: 20.0),
          textTheme: TextTheme(
              titleLarge: GoogleFonts.ibmPlexSansKr(
                  color: Colors.black, fontWeight: FontWeight.bold),
              titleMedium: GoogleFonts.ibmPlexSansKr(
                  color: Colors.black, fontWeight: FontWeight.bold),
              titleSmall: GoogleFonts.ibmPlexSansKr(
                  color: Colors.black, fontWeight: FontWeight.bold),
              displaySmall: GoogleFonts.ibmPlexSansKr(
                  color: Colors.black, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                color: Colors.black,
              ),
              displayMedium: GoogleFonts.ibmPlexSansKr(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              enableFeedback: true,
              showUnselectedLabels: false,
              selectedLabelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              backgroundColor: Colors.amber,
              elevation: 1,
              selectedIconTheme: IconThemeData(color: Colors.white, size: 40),
              unselectedIconTheme: IconThemeData(
                color: Colors.black45,
              )),
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: getUserInfo(),
                  builder: (context, snapshot) {
                    return Home(userName);
                  },
                );
              } else {
                return LoginPage();
              }
            }));
  }
}
