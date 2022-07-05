import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<bool> signInWithGoogle() async{

  GoogleSignInAccount? googleUser;

  try {
    googleUser = await GoogleSignIn().signIn();
  } on Exception catch (e) {
    debugPrint(e.toString());
  }

  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  return false;
}

Future<bool> signInWithApple() async{

  try {
    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);

    final oauthCrendential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    await FirebaseAuth.instance.signInWithCredential(oauthCrendential);

    return true;

  } on Exception catch (e) {
    debugPrint(e.toString());
  }  



  return false;
}

