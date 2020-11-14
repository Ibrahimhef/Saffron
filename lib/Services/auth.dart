import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Services/database.dart';
import 'package:swe444/models/meals.dart';
import 'package:swe444/models/profile.dart';

import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  User _userFormFireBaseUser(FirebaseUser user,
      {String email, String full_name}) {
    return user != null
        ? User(uid: user.uid, email: email, full_name: full_name)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFormFireBaseUser(user));
        .map(_userFormFireBaseUser);
  }

  //sign in anon
  Future SignInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFormFireBaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  //sign in with google account edit by albra
  Future signinwithgoogleaccount() async {
    try {
      GoogleSignInAccount googleacc = await googleSignIn.signIn();

      if (googleacc != null) {
        GoogleSignInAuthentication googleauth = await googleacc.authentication;

        AuthCredential authCredential = GoogleAuthProvider.getCredential(
            idToken: googleauth.idToken, accessToken: googleauth.accessToken);

        AuthResult res = await _auth.signInWithCredential(authCredential);

        FirebaseUser user = await _auth.currentUser();
        // print("email : ${user.email}   name: ${user.displayName}");
        await DatabaseService(uid: user.uid)
            .insertUser(user.uid, user.displayName, user.email, "password");
        return _userFormFireBaseUser(user, email: user.email);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SingInWithEmailAndPassword(String email, String password) async {
    // try {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    Stream<List<profile1>> users = await DatabaseService(uid: user.uid).users;
    String full_name;
    users.listen((event) {
      print("length of data: ${event.length}");
      event.forEach((element) {
        if (element.email == email) full_name = element.name;
      });
    });
    return _userFormFireBaseUser(user, email: email, full_name: full_name);
    // } catch (e) {
    //   // print(e.toString());
    //   return null;
    // }
  }

  Future RegisterWithEmailAndPassword(
      String full_name, String email, String password) async {
    // try {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    await DatabaseService(uid: user.uid)
        .insertUser(user.uid, full_name, email, password);
    return _userFormFireBaseUser(user, email: email, full_name: full_name);
    // } catch (e) {
    //   // print(e.toString());
    //   return null;
    // }
  }

  Future ForgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // FirebaseUser user = result.user;
      // return _userFormFireBaseUser(user);
    } catch (e) {
      // print(e.toString());
      // return null;
    }
  }

//sign out edit by albra
  Future SignOut() async {
    try {
      // FirebaseUser user = await _auth.currentUser();
      // if (user.providerData[1].providerId == 'google.com') {
      //   await googleSignIn.disconnect();
      // }
      print("Sign out");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
