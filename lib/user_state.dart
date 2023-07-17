import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/LoginPage/login_screen.dart';
import 'package:tutor_finder/Tuitions/tuitions_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnashot) {
        if (userSnashot.data == null) {
          //print('user is not logged in yet');
          return Login();
        } else if (userSnashot.hasData) {
          //print('user is already logged in');
          return TuitionScreen();
        } else if (userSnashot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('An Error has been occurred. Try again later'),
            ),
          );
        } else if (userSnashot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text(
              'Something Went Wrong',
            ),
          ),
        );
      },
    );
  }
}
