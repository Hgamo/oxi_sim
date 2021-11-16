import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oxi_sim/screens/start_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  final userCredential = await auth.signInAnonymously();
  final user = userCredential.user!;
  runApp(Provider<User>(
    create: (context) => user,
    lazy: false,
    child: MaterialApp(
      title: 'Oxi Sim',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const StartScreen(),
    ),
  ));
}
