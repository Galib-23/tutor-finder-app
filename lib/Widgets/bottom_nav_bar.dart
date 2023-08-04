import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/Search/search_tuitions.dart';
import 'package:tutor_finder/Search/tutor_profile.dart';
import 'package:tutor_finder/Tuitions/tuitions_screen.dart';
import 'package:tutor_finder/Tuitions/upload_tuition_profile.dart';
import 'package:tutor_finder/user_state.dart';

class BottomNavigationBarForApp extends StatelessWidget {
  int indexNum = 0;

  BottomNavigationBarForApp({required this.indexNum});

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
              ],
            ),
            content: const Text(
              'Do you want to log out?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => UserState()));
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        height: 50,
        color: const Color.fromARGB(255, 60, 122, 236),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        buttonBackgroundColor: const Color.fromARGB(255, 60, 122, 236),
        index: indexNum,
        items: const [
          Icon(
            Icons.list,
            size: 19,
            color: Colors.black,
          ),
          Icon(
            Icons.contact_page_outlined,
            size: 19,
            color: Colors.black,
          ),
          Icon(
            Icons.add,
            size: 19,
            color: Colors.black,
          ),
          Icon(
            Icons.person_pin,
            size: 19,
            color: Colors.black,
          ),
          Icon(
            Icons.exit_to_app,
            size: 19,
            color: Colors.black,
          ),
        ],
        animationDuration: const Duration(
          milliseconds: 300,
        ),
        animationCurve: Curves.linear,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => TuitionScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => AllStudentsScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => UploadTuitionProfile()));
          } else if (index == 3) {
            final FirebaseAuth _auth = FirebaseAuth.instance;
            final User? user = _auth.currentUser;
            final String uid = user!.uid;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                          userID: uid,
                        )));
          } else if (index == 4) {
            _logout(context);
          }
        });
  }
}
