import 'package:flutter/material.dart';
import 'package:lab3/screens/FavouritePage.dart';
import 'package:lab3/screens/NotificationPage.dart';
import 'package:lab3/screens/byCategory.dart';
import 'package:lab3/screens/home.dart';
import 'package:lab3/screens/mealDetail.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:lab3/services/FireBaseApi.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => const MyHomePage(title: "HomePage"),
        "/byCategory": (context) => const byCategory(),
        "/detail": (context) => const DetailPage(),
        "/favourite": (context) => const FavouritePage(),
        // "/notification_screen": (context) => const NotificationPage(),
      },
    );
  }
}
