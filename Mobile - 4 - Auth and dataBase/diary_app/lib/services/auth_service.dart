import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Registration cancelled by user');
      return null;
    }
  }

  Future<UserCredential?> signInWithGitHub(BuildContext context) async {
    try {
      // Create a GitHubSignIn instance
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          clientSecret: dotenv.env['CLIENT_SECRET'].toString(),
          redirectUrl: dotenv.env['redirectUrl'].toString());
      // Trigger the sign-in flow
      final result = await gitHubSignIn.signIn(context);
      // Create a credential from the access token
      final githubAuthCredential =
          GithubAuthProvider.credential(result.token.toString());
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(githubAuthCredential);
    } catch (e) {
      debugPrint('Registration cancelled by user');
      return null;
    }
  }
}
