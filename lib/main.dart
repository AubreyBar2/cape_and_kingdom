import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CapeAndKingdomApp());
}

class CapeAndKingdomApp extends StatelessWidget {
  const CapeAndKingdomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cape and Kingdom Exports',
      theme: ThemeData(
        fontFamily: 'Georgia',
        primaryColor: const Color(0xFF7B1E1E),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}

