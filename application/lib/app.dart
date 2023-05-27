import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hob_sparcs/login_page.dart';
import 'src/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  UserName userName = UserName("id", "realName", "nickName");
  Future getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection("user");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    for (var doc in querySnapshot.docs) {
      if (doc.data()["id"] == user!.email) {
        userName = UserName(
            doc.data()["id"], doc.data()["realName"], doc.data()["nickname"]);
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hob-SPARCS",
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                getUserInfo();
                return Home(userName);
              } else {
                return LoginPage();
              }
            }));
  }
}
