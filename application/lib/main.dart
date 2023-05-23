import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

String clientId = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterFireUIAuth.configureProviders([
  //   const EmailProviderConfiguration(),
  //   const GoogleProviderConfiguration(clientId: clientId),
  // ]);

  runApp(const App());
}
