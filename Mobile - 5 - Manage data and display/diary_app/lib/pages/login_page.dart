import 'package:diary_final_app/components/my_button_icon.dart';
import 'package:diary_final_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/notebook.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to your Diary',
              style: TextStyle(fontSize: 52),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            MyButtonIcon(
                onTap: () async {
                  await AuthService().signInWithGoogle();
                },
                title: 'Continue with Google',
                size: 22,
                logo: 'assets/images/google.png'),
            const SizedBox(height: 5),
            MyButtonIcon(
                onTap: () async {
                  await AuthService().signInWithGitHub(context);
                },
                size: 22,
                title: 'Continue with GitHub',
                logo: 'assets/images/GitHub.png'),
          ],
        )),
      ),
    );
  }
}
