import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_salon/app.dart';
import 'package:the_salon/firebase_options.dart';

void main() async {
  // init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
