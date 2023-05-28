import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
