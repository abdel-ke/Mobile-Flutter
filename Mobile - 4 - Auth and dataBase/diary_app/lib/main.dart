import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diary_app/firebase_options.dart';
import 'package:diary_app/pages/auth_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.greatVibes().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
