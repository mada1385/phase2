import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Authapi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // final String endPoint = 'http://10.0.2.2:8000/analyze';
  Future postima(File file, String token) async {
    String fileName = file.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      "image": file,
    });

    Dio dio = new Dio();

    dio
        .post(
      "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/users/update-image",
      data: data,
      options: Options(
        headers: {
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          "Authorization": "bearer $token",
        },
      ),
    )
        .then((response) {
      var jsonResponse = jsonDecode(response.toString());
      var testData = jsonResponse['histogram_counts'].cast<double>();
      var averageGrindSize = jsonResponse['average_particle_size'];
    }).catchError((error) => print(error));
  }

  Future postimage(File image, String token, BuildContext context) async {
    final bytes = await image.readAsBytes();
    String base64 = base64Encode(bytes);
    // print(base64);
    try {
      final favouriteteam = await http.post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/users/update-image",
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            "Authorization": "bearer $token",
          },
          body: {
            "image": base64,
          });
      var body;
      print("Api service: ${favouriteteam.body}");
      body = jsonDecode(favouriteteam.body);

      if (body["success"]) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Provider.of<Userprovider>(context, listen: false)
            .setimage(body["image"]);
        preferences.setString("image", body["image"]);

        print("success");
        return body;
      } else {
        return body;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future register(Users x, BuildContext context) async {
    try {
      final signup = await http.post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/users/signup",
          body: {
            "password": x.password,
            "email": x.email,
            "username": x.username
          });
      var body = jsonDecode(signup.body);
      print(body);
      if (body["success"]) {
        print("Sucsess");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", body["token"]);
        preferences.setString("username", x.username);
        preferences.setString("id", body["userId"]);

        Provider.of<Userprovider>(context, listen: false)
            .settoken(body["token"]);
        Provider.of<Userprovider>(context, listen: false)
            .setusername(body["username"]);

        print(Provider.of<Userprovider>(context, listen: false).token);
        return jsonDecode(signup.body);
      } else
        print("failed");
      return jsonDecode(signup.body);
    } catch (e) {
      print(e);
      return e;
    }
  }

  void signOutGoogle() async {
    await Firebase.initializeApp();

    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  Future<dynamic> handleSignIn(BuildContext context) async {
    // hold the instance of the authenticated user
    User user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    try {
      if (isSignedIn) {
        // if so, return the current user
        user = await _auth.currentUser;
        final token = await user.getIdToken();
        SharedPreferences preferences = await SharedPreferences.getInstance();

        final username = await user.displayName;
        final email = await user.email;
        final localuser = await googkelrgin(email, username, context);
        preferences.setString("username", username);
        Provider.of<Userprovider>(context, listen: false).setusername(username);
        return localuser;
      } else {
        final GoogleSignInAccount googleUser =
            await _googleSignIn.signIn().catchError((onError) {
          print("error $onError");
        });
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // get the credentials to (access / id token)
        // to sign in via Firebase Authentication
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", googleAuth.idToken);
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        user = (await _auth.signInWithCredential(credential)).user;
        final username = await user.displayName;
        final email = await user.email;
        final localuser = await googkelrgin(email, username, context);
        preferences.setString("username", username);
        Provider.of<Userprovider>(context, listen: false).setusername(username);
        return localuser;
      }
    } catch (e) {
      print(e);
    }
  }

  Future googkelrgin(
      String email, String username, BuildContext context) async {
    try {
      final signup = await http.post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/users/google",
          body: {
            "displayName": username,
            "email": email,
          });
      var body = jsonDecode(signup.body);
      print(body);
      if (body["success"]) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", body["token"]);
        // preferences.setString("username", body["username"]);
        preferences.setString("id", body["userId"]);
        preferences.setString("image", body["image"]);

        Provider.of<Userprovider>(context, listen: false)
            .settoken(body["token"]);
        // Provider.of<Userprovider>(context, listen: false)
        //     .setusername(body["username"]);
        Provider.of<Userprovider>(context, listen: false).setid(body["userId"]);
        Provider.of<Userprovider>(context, listen: false)
            .setimage(body["image"]);
        print(Provider.of<Userprovider>(context, listen: false).token);
        return body;
      } else {
        return body;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future login(Users x, BuildContext context) async {
    try {
      final signup = await http.post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/users/login",
          body: {
            "password": x.password,
            "email": x.email,
          });
      var body = jsonDecode(signup.body);
      print(body);
      if (body["success"]) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", body["token"]);
        preferences.setString("username", body["username"]);
        preferences.setString("id", body["userId"]);
        preferences.setString("image", body["image"]);

        Provider.of<Userprovider>(context, listen: false)
            .settoken(body["token"]);
        Provider.of<Userprovider>(context, listen: false)
            .setusername(body["username"]);
        Provider.of<Userprovider>(context, listen: false).setid(body["userId"]);
        Provider.of<Userprovider>(context, listen: false)
            .setimage(body["image"]);
        print(Provider.of<Userprovider>(context, listen: false).token);
        return body;
      } else {
        return body;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future logout(BuildContext context) async {
    await Firebase.initializeApp();

    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      signOutGoogle();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", null);
    preferences.setString("username", null);
    preferences.setString("id", null);

    print(preferences.get("token"));
    Provider.of<Userprovider>(context, listen: false).settoken(null);
  }
}
